# Twist Out: Technical Design Document (TDD)

**Version:** 0.1 (draft) | **Date:** 25 October 2026 | **Depends on:** SRS v0.1 (requirement IDs referenced as FR-xx-nn)

## 1. Technical decisions

| Area | Choice | Why | Fallback |
| --- | --- | --- | --- |
| Language and framework | Dart 3 and Flutter (stable) | One codebase for Android and iOS, text-based project files that AI agents edit reliably, good tooling | Godot 4 or Unity if you later need heavy 3D |
| Game layer | Flame | Lightweight 2D engine on top of Flutter, sprites, effects, particles, tweening | Plain Flutter CustomPainter for very simple scenes |
| Rules engine | Pure Dart package inside the repo | Deterministic, fast tests, reusable by the solver and level tools | None needed |
| State management | Riverpod | Testable, little boilerplate, good for UI around the game | Bloc |
| Physics | Custom gravity and rotation tweens (no physics engine) | Smoother on low-end phones, predictable, smaller | Flame Forge2D for a later mode |
| Storage | JSON file via path\_provider with atomic write, plus shared\_preferences for tiny flags | Simple and migratable | Isar or drift if data grows |
| Ads | google\_mobile\_ads (AdMob), UMP consent | Official plugin, well documented | AppLovin MAX or LevelPlay for mediation later |
| Purchases | in\_app\_purchase | First-party plugin | RevenueCat if server-side receipts are needed |
| Backend services | Firebase Analytics, Crashlytics, Remote Config | Free tier, A/B testing support | Amplitude plus a config service |
| Audio | flame\_audio with OGG files | Low latency, small size | audioplayers |
| Haptics | HapticFeedback and the vibration package for custom patterns | Built in | None |
| CI | GitHub Actions | Common, agent friendly | Codemagic |

Pin all package versions in pubspec.lock and upgrade deliberately. Verify current package versions and API levels at project start, because they change.

## 2. Architecture

Four layers. Dependencies only point downward.

```
+---------------------------------------------+
|  App / UI layer (Flutter widgets, Riverpod)  |  menus, HUD, modals, shop, workshop
+---------------------------------------------+
|  Game layer (Flame components)               |  renders state, plays animations from events
+---------------------------------------------+
|  Services layer (interfaces + implementations)|  ads, consent, analytics, config, iap, audio, haptics, storage
+---------------------------------------------+
|  Domain layer (pure Dart)                    |  models, rules reducer, solver, generator
+---------------------------------------------+
```

**Key principle:** the Domain layer decides what happens; the Game layer only shows it. A tap becomes a command, the reducer returns a new immutable state plus a list of events, and the Game layer plays those events as animations. This makes gameplay testable without a screen, makes replays and the solver free, and allows the replay-share feature (FR-SH-01) by recording commands.

## 3. Repository structure

```
twist_out/
  AGENTS.md                  # standing instructions for Antigravity agents
  .agents/rules/             # focused rule files
  .agents/workflows/         # saved prompts (slash commands)
  docs/                      # SRS, TDD, UI doc, playbook, launch plan
  lib/
    app/                     # bootstrap, router, theme, DI providers
    domain/                  # PURE DART: no flutter or flame imports
      model/                 # LevelDef, GameState, Plate, Screw, BoxState
      rules/                 # reducer, blocking, win and lose checks
      solver/                # DFS solver, difficulty metrics
      generator/             # level generator
    game/                    # Flame: BoardGame, components, effects, event player
    features/                # home, game_hud, workshop, shop, settings, daily, tutorial
    services/                # ads/, consent/, analytics/, config/, iap/, audio/, haptics/, storage/
    l10n/                    # ARB files
  assets/
    levels/                  # level_001.json ... level_300.json, shapes.json
    images/ audio/ fonts/
  tool/                      # CLI: generate, validate, simulate, export_report
  test/                      # unit, property, golden
  integration_test/
```

## 4. Domain model and rules engine (FR-GP-01, FR-GP-07)

### 4.1 Core types

```dart
enum GameStatus { playing, won, lost }

class Screw { final String id; final String plateId; final int color; final Vec2 pos; }
class Plate { final String id; final int layer; final Polygon shape; final bool present; }
class BoxState { final int color; final int count; }          // capacity is always 3

class GameState {
  final Map<String, Plate> plates;
  final Map<String, Screw> screwsOnBoard;
  final List<BoxState> activeBoxes;       // max 3
  final List<int> boxQueue;               // remaining colours, front is next
  final List<Screw?> tray;                // length = trayLimit (+ temporary slots)
  final GameStatus status;
  final int moves;
  final int trayPeak;
}
```

### 4.2 Commands, events and the reducer

```dart
sealed class Command { }
class TapScrew extends Command { final String screwId; }
class UseBooster extends Command { final BoosterType type; final String? targetId; }
class GrantTraySlots extends Command { final int slots; }   // revive and Extra Slot

sealed class GameEvent { }   // ScrewLifted, ScrewMovedToBox, ScrewMovedToTray, TrayToBoxMove,
                             // BoxCleared, BoxActivated, PlateFell, ScrewRejected, Won, Lost

class StepResult { final GameState state; final List<GameEvent> events; }
StepResult step(GameState s, Command c);   // pure, deterministic
```

**TapScrew algorithm**

1. Reject (emit ScrewRejected) if the screw is missing or blocked.
2. Remove the screw from the board. If its plate has no screws left, mark the plate not present and emit PlateFell.
3. If an active box has the same colour and count below 3, add the screw and emit ScrewMovedToBox. Otherwise place it in the first empty tray slot and emit ScrewMovedToTray.
4. Resolve boxes in a loop: while any active box has count 3, emit BoxCleared, pop the next colour from boxQueue into activeBoxes (emit BoxActivated), then move matching tray screws into open boxes (emit TrayToBoxMove for each). Repeat until stable.
5. Recompute trayPeak and moves.
6. Win check: activeBoxes and boxQueue are both empty. Emit Won.
7. Lose check: tray has no empty slot AND no unblocked board screw matches an active box colour. Emit Lost.

The lose check runs after resolution so players never need a wasted tap to see the failure (rule 9 in the SRS).

### 4.3 Invariants (property-tested)

- The number of screws on board plus in tray plus in boxes plus cleared equals the total at level load.
- Per colour, total screws is a multiple of 3 and equals 3 times the number of boxes of that colour in the queue.
- A tapped blocked screw never changes state except for the rejection event.
- The tray never holds more than its limit.
- step() with the same inputs returns identical outputs (determinism).

## 5. Geometry and blocking (FR-GP-03)

Board space is normalised: x in 0 to 1, y in 0 to 1.25 (4:5 aspect). Plate shapes come from shapes.json as polygons with local coordinates and recommended anchor points for screws. A plate instance has position, rotation and scale.

A screw is blocked if any present plate with a higher layer contains the screw world position, with a margin equal to the screw radius. Use point-in-polygon after transforming the point into the plate's local space. Precompute for each screw the list of candidate blockers at load. When a plate falls, update only the screws that listed that plate. This keeps each tap O(k) with small k.

A plate may not be placed so that it fully hides another plate's anchor with no possible release (the generator and solver check this).

## 6. Level format and validation (FR-LV-01)

Example (coordinates in board space, colour as integer index 0 to 7):

```json
{
  "id": 12,
  "world": 1,
  "kind": "normal",
  "trayLimit": 5,
  "plates": [
    { "id": "p1", "layer": 0, "shape": "plank_l", "pos": [0.5, 0.62], "rot": 0.2, "scale": 1.0 },
    { "id": "p2", "layer": 1, "shape": "hex_m",   "pos": [0.42, 0.55], "rot": 0.0, "scale": 1.0 }
  ],
  "screws": [
    { "id": "s1", "plate": "p1", "anchor": 0, "color": 2 },
    { "id": "s2", "plate": "p1", "anchor": 1, "color": 4 }
  ],
  "boxQueue": [2, 4, 0, 1],
  "meta": { "solvable": true, "minTrayPeak": 3, "randomWinRate": 0.18, "difficulty": 0.42 }
}
```

The validator (tool/validate.dart) runs on every level in CI and fails the build if any check fails:

1. Schema valid; ids unique; layers contiguous.
2. Screw count per colour is a multiple of 3 and matches boxQueue.
3. No two screws closer than 2.2 times the screw radius.
4. Solver finds a winning sequence (solvable is recomputed, never trusted from the file).
5. meta values match the recomputed values.
6. Difficulty sits inside the band for the level's position on the curve.

## 7. Solver, difficulty and generator

### 7.1 Solver

Depth-first search with memoisation over the key (set of removed screws, active box counts, queue index, tray multiset). Moves are the currently free screws. Prune states where the tray is full without a matching tap. Order moves by heuristic: screws matching an active box first, then screws that free the most blocked screws. Cap search nodes (for example 2 million) and report unknown when exceeded. Output: solvable flag, one solution path, minimum tray peak.

### 7.2 Difficulty score (0 to 1)

Combine: minimum tray peak relative to tray limit (tight means harder), average number of free screws per step (fewer choices is harder), fraction of the search tree that wins, and the win rate of a random bot over 2,000 playouts and of a greedy bot over 200 playouts. Targets by tier: Easy random-bot win rate above 40%, Normal 15 to 40%, Hard 3 to 15%. Treat these as starting values and tune with live data.

### 7.3 Generator

1. Choose world, plate count (2 to 8), colour count (3 to 8), total screws (3 times k).
2. Place plates by layer with overlap constraints so most layers hide something.
3. Choose screw anchors respecting minimum spacing.
4. Assign colours with a tension controller: spread colours across layers so early free screws are mixed, and make late colours appear under heavy plates.
5. Order the box queue to tune difficulty (queue order versus access order).
6. Run the solver and difficulty score; accept, adjust or reject. Seeded RNG makes levels reproducible; the Daily Challenge uses a date seed (FR-LV-06).
7. Export JSON; designers hand-tune and re-validate.

Stars (FR-LV-05): 3 stars if trayPeak is at most 3 and no booster or revive was used; 2 stars if trayPeak is at most 4; otherwise 1.

## 8. Rendering and animation (Flame)

- **BoardGame** (FlameGame) owns the camera (fixed logical resolution 360 by 800 dp scaled to fit, letterboxed on very wide screens), the event player and the component tree.
- **Components:** PlateComponent, ScrewComponent, BoxComponent, TrayComponent, BackdropComponent, EffectsLayer.
- **EventPlayer:** a queue of GameEvents from the reducer. It plays each event's animation, and allows independent events (for example a plate falling while a screw flies) to overlap. Input taps are accepted during animation because the reducer state is already updated; visuals catch up (FR-GP-04).
- **Screw animation:** lift and rotate (180 ms), arc flight (260 ms), settle with squash (120 ms). Exact values are in the UI document.
- **Plate fall (FR-GP-06):** semi-implicit Euler with gravity 2400 dp per second squared, random angular velocity, no collision except an optional soft bounce off other present plates by simple AABB checks. The plate is removed from the tree once off screen.
- **Pooling:** reuse particle and screw sprites; no allocation inside update() for hot paths.
- **Atlas:** all board sprites in one or two atlases per world; WebP for backgrounds.
- **Frame pacing:** stop updating when the scene is static; cap particles at 150.

## 9. Services (interfaces first)

Each service has an abstract interface, a real implementation and a fake for tests. The UI and game depend only on interfaces.

| Service | Responsibilities |
| --- | --- |
| ConsentService | UMP flow, region detection, consent status, reopen settings; iOS ATT prompt. Ads and analytics wait for it. |
| AdsService | Preload and show rewarded and interstitial ads; frequency caps from config; no ads before level 6; failure never blocks play; logs every outcome. |
| AnalyticsService | Typed event methods, session id, user properties (level, spend flag, ad exposure bucket). |
| ConfigService | Remote Config with baked defaults; fetch on start with 3 s timeout; activate on next session. |
| IapService | Product catalogue, purchase, restore, entitlement cache. |
| AudioService | Music and SFX with pooled players, pitch ramp for chains, mute and focus handling. |
| HapticsService | Named patterns (tick, thunk, win) with a global toggle. |
| StorageService | Load, migrate and atomically save the SaveData document. |

**Ad flow (FR-MO-02, FR-MO-06):** on level win, the placement manager checks level at least 6, cooldown elapsed, ad ready and not remove-ads entitled; then it shows the interstitial after the win animation and before the win modal's next button. Rewarded ads are only offered through explicit buttons and grant rewards only on the reward callback.

## 10. Save data

```json
{
  "schema": 3,
  "profile": { "installId": "...", "createdAt": 0 },
  "progress": { "currentLevel": 12, "stars": { "1": 3, "2": 2 }, "toyIndex": 0, "parts": 2 },
  "wallet": { "coins": 340, "boosters": { "extraSlot": 3, "magnet": 3, "smash": 2 } },
  "entitlements": { "removeAds": false },
  "daily": { "lastClaim": "2026-10-25", "streak": 3 },
  "settings": { "music": true, "sfx": true, "haptics": true, "colourblind": false, "reducedMotion": false },
  "flags": { "ratePromptedAt": 0, "tutorialDone": true }
}
```

Write to a temp file then rename (atomic); keep one backup copy; run migrations by schema number on load (FR-DA-01, FR-DA-02). Never store ad IDs or personal data here.

## 11. Remote Config keys and safe defaults

| Key | Default | Purpose |
| --- | --- | --- |
| interstitial\_start\_level | 6 | First level where interstitials may show |
| interstitial\_min\_interval\_s | 90 | Minimum seconds between interstitials |
| rewarded\_revive\_enabled | true | Toggle revive offer |
| coins\_per\_win | 20 | Level reward |
| booster\_cost\_coins | 100 | Booster price |
| tray\_limit\_default | 5 | Tray size |
| revive\_extra\_slots | 3 | Slots granted by revive |
| rate\_prompt\_min\_level | 12 | Earliest rating prompt |
| difficulty\_offset | 0.0 | Global nudge applied by level selection tools |
| feature\_replay\_share | false | Flag for the replay feature |

## 12. Performance and size budget (NFR-01 to NFR-05)

| Budget | Target |
| --- | --- |
| Frame time | 16.6 ms average, 33 ms worst case on the low-end test device |
| Cold start | Under 3 s |
| Android app bundle | Under 50 MB (stretch 35 MB) |
| Peak memory | Under 300 MB |
| Per-level assets loaded | Only the active world's atlas and audio |

Techniques: sprite atlases, WebP, OGG at modest bitrate, lazy world loading, no large PNG backgrounds, tree shaking, R8 shrinking, split debug info, deferred components only if needed.

## 13. Testing strategy

| Layer | Tests |
| --- | --- |
| Domain | Unit tests for every rule; property tests with random tap sequences to enforce invariants; golden level fixtures with known outcomes; coverage at least 90% |
| Level data | CI runs the validator and solver on all levels; fails on unsolvable or out-of-band levels |
| Services | Fakes for ads, analytics, IAP; test frequency caps, consent gating and failure paths |
| UI | Widget tests for modals and HUD; golden tests for key screens at 3 screen sizes |
| Integration | integration\_test flows: first launch, tutorial, win, fail and revive, purchase restore, offline start |
| Device | Manual and cloud runs on low, mid and high devices; profile mode frame timeline for levels 1, 50, 150, 300 |

## 14. CI/CD and release

1. Pull request: flutter analyze, flutter test, validate levels, build debug APK.
2. Main branch: also build a release app bundle and upload to the Play Console internal track (fastlane or the Play publishing action).
3. Versioning: semantic version in pubspec plus build number from the CI run.
4. Secrets (keystore, service account) live only in CI secrets, never in the repo.
5. Use test ad unit IDs in debug and flavor-based real IDs in release. A release check script fails the build if test ad IDs are found in a release artifact.

## 15. Security and privacy engineering

- No personal data collected beyond what the SDKs collect; list every SDK in /docs/sdk-inventory.md and keep it synced with the Data Safety form.
- Obfuscate and shrink release builds; keep mapping files for Crashlytics.
- Consent first: no analytics or ads initialisation until the consent state allows it.
- Offline single-player means low cheating risk; do not add server trust in v1.0. If real-money items grow, add server-side receipt validation.

## 16. Technical risks

| Risk | Mitigation |
| --- | --- |
| Solver cannot prove large levels in time | Node cap, heuristic ordering, limit screw count per level, precompute offline |
| Animations stutter on low-end phones | Pooling, atlases, particle cap, a performance test gate at M4 |
| Level difficulty feels unfair | Telemetry on fail rate by level, difficulty\_offset flag, fast level patch pipeline |
| Ad SDK crashes or ANRs | Initialise after first frame, wrap in try and catch, monitor in Crashlytics |
| Agent-generated code drifts from the architecture | AGENTS.md rules, layer lint (no flutter imports in domain), PR review checklist |
