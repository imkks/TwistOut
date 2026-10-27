# Twist Out: Software Requirements Specification (SRS)

**Version:** 0.1 (draft) | **Date:** 25 October 2026 | **Working title:** Twist Out (run a trademark and store-name search before release)

## 1. Introduction

### 1.1 Purpose

This SRS defines what the game must do. It is the source of truth for the AI agents building the project in Antigravity and for anyone reviewing their work. Companion documents: 2. Technical Design Document (TDD), 3. UI/UX Design Document, 4. Antigravity Build Playbook, 5. Launch, Growth and Analytics Plan.

### 1.2 Scope

Twist Out is a free-to-play, offline-capable, single-player mobile puzzle game. Android ships first, iOS follows in phase 2 from the same Flutter codebase. This SRS covers v1.0 (launch) and flags post-launch items.

### 1.3 Definitions

| Term | Meaning |
| --- | --- |
| Plate | A flat shape (plank, hexagon, star and so on) pinned to the backdrop by screws. Plates sit on layers. |
| Layer | Integer depth of a plate. Layer 0 is the bottom; higher layers are on top. |
| Screw | A coloured screw that holds one plate. Each screw belongs to exactly one plate. |
| Blocked screw | A screw covered by any remaining plate on a higher layer. It cannot be tapped. |
| Box | A coloured container at the top of the screen. It holds 3 screws of its colour, then clears. |
| Tray | A row of holding slots (5 by default) for screws that have no matching open box. |
| Booster | A consumable power-up used inside a level. |
| Coins | Soft currency earned by playing and spent on boosters. |
| Toy / Part | Meta collection. A Toy is built from 6 Parts; 1 Part is earned per 5 levels. |
| Revive | One-time rescue after a failed level, unlocked by a rewarded ad. |

### 1.4 Requirement conventions

IDs follow FR-AREA-nn. Priority: **M** = must for v1.0, **S** = should, **C** = could. Every requirement must be testable. Agents must reference IDs in commits and pull requests.

## 2. Product overview

### 2.1 Vision

A one-thumb puzzle that is satisfying to watch. The player unscrews coloured screws from stacked plates, sorts them into boxes, and watches plates clatter away. A level takes 45 to 90 seconds. The core loop must be understandable from a muted 5-second video, because short video ads and shares are the main growth engine.

### 2.2 Goals and success metrics

Primary goal: maximise installs at low blended cost per install while keeping retention healthy enough to scale. The numbers below are starting hypotheses to validate in soft launch, not facts.

| Metric | Initial target |
| --- | --- |
| Tutorial completion | 85% or higher |
| Levels 1 to 10 completion rate | 80% or higher |
| Day-1 retention | 40% or higher |
| Day-7 retention | 15% or higher |
| Crash-free sessions | 99.5% or higher |
| Median level duration | 45 to 90 seconds |

### 2.3 Target users

Casual players aged roughly 16 to 55 worldwide, playing in short breaks (commute, queue, bed). Text-light UI so the game works in any language without translation on day 1.

### 2.4 Platforms and constraints

- Android 7.0 (API 24) and above at launch; iOS 15 and above in phase 2.
- Portrait only, phones first; tablets must be usable but are not optimised.
- Flutter (stable channel) with the Flame game engine; see the TDD.
- Fully playable offline. Ads and analytics degrade gracefully with no network.
- Target audience 13 and over (decision D1 in section 8).

### 2.5 Assumptions and dependencies

- A Google Play developer account and AdMob account exist before M7.
- Art and audio are produced with free or licensed assets plus AI-assisted generation, with licences recorded in /docs/asset-licences.md.
- Platform policies change; verify Play Console, AdMob and App Store requirements at the time of each release.

## 3. Core game rules (canonical)

1. **Board.** Plates are stacked on layers. Each plate is held by 1 to 6 screws.
2. **Tap.** The player taps a free (unblocked) screw. Tapping a blocked screw gives a short shake and a soft sound, and costs nothing.
3. **Destination.** A tapped screw flies to an active Box of its colour that has fewer than 3 screws. If none exists it flies to the first empty Tray slot.
4. **Box clear.** At 3 screws a Box clears. The next Box in the queue becomes active, and any Tray screws of that colour move into it automatically, left to right. This repeats until stable (chain reactions are intended and must feel good).
5. **Plate fall.** When a plate's last screw is removed the plate falls away, uncovering screws beneath it.
6. **Active boxes.** 3 Boxes are active at a time and the next 2 are previewed.
7. **Tray size.** 5 slots by default; a level may override it.
8. **Win.** All Boxes are cleared (equivalently, no screws remain on the board or in the Tray).
9. **Lose.** After a move fully resolves, the Tray is full and no free screw on the board matches an active Box. The game ends immediately; it must not wait for a wasted tap.
10. **Solvability.** Every shipped level has at least one winning sequence, proven by the offline solver.
11. **Determinism.** The same level and the same sequence of taps always produce the same outcome.

## 4. Functional requirements

### 4.1 Gameplay (GP)

| ID | Requirement | Pri |
| --- | --- | --- |
| FR-GP-01 | Implement rules 1 to 11 in a pure Dart rules engine with no Flutter or Flame imports. | M |
| FR-GP-02 | Tap hit area for a screw is at least 48 dp regardless of the visual size. | M |
| FR-GP-03 | Blocked state of every screw is recalculated whenever a plate falls and visibly dims blocked screws. | M |
| FR-GP-04 | Screw animation: unscrew, lift, arc flight to destination. Total under 600 ms; taps during animations are queued, not dropped. | M |
| FR-GP-05 | Plates with exactly one remaining screw swing or dangle on it before falling. | S |
| FR-GP-06 | Plate fall uses lightweight custom gravity and rotation, not a full physics engine. | M |
| FR-GP-07 | Win and lose are detected by the rules engine and reported as events to the UI layer. | M |
| FR-GP-08 | Pause, restart and quit are available during play; restart is free. | M |
| FR-GP-09 | A hint shows one recommended free screw after 8 seconds of inactivity (from the solver or a heuristic). | S |
| FR-GP-10 | Chain reactions (Tray to Box auto-moves) play in sequence with an escalating pitch sound. | M |

### 4.2 Levels and progression (LV)

| ID | Requirement | Pri |
| --- | --- | --- |
| FR-LV-01 | Ship 300 levels in v1.0, defined as JSON assets (schema in the TDD). | M |
| FR-LV-02 | Levels 1 to 5 introduce mechanics one at a time with an interactive, text-light tutorial (pointer hand, highlights). | M |
| FR-LV-03 | Difficulty follows a sawtooth curve: every 10th level is a flagged Hard level, every 5th level is a short Chill level. | M |
| FR-LV-04 | Level select is linear (next level) with a progress map of Toys; no free level skipping. | M |
| FR-LV-05 | Each level stores best stars (1 to 3) based on tray usage and mistakes (rules in the TDD). | S |
| FR-LV-06 | A Daily Challenge level is generated from a date seed; one reward per day. | S |
| FR-LV-07 | Level packs are loadable from remote config or an asset bundle without an app update. | C |

### 4.3 Boosters and economy (BO)

| ID | Requirement | Pri |
| --- | --- | --- |
| FR-BO-01 | Extra Slot: adds 1 temporary Tray slot for the current level. | M |
| FR-BO-02 | Magnet: sends up to 3 free screws of the colour of the leftmost active Box straight into it. | M |
| FR-BO-03 | Smash: the player taps a plate and it falls immediately, removing its screws from the level. | S |
| FR-BO-04 | New players start with 3 of each booster. A booster costs 100 Coins; a level win grants 20 Coins. All values come from remote config. | M |
| FR-BO-05 | When out of a booster, the player may watch a rewarded ad to receive one, or buy it with Coins. | M |
| FR-BO-06 | Revive after losing: a rewarded ad grants 3 extra temporary Tray slots; once per level attempt. | M |
| FR-BO-07 | Currency and inventory changes are transactional and survive app kill. | M |

### 4.4 Meta layer (ME)

| ID | Requirement | Pri |
| --- | --- | --- |
| FR-ME-01 | Workshop screen shows the current Toy as a build-up silhouette; 1 Part is unlocked per 5 levels completed. | M |
| FR-ME-02 | Completing a Toy (6 Parts, 30 levels) plays a reveal animation and grants a booster chest, then unlocks the next Toy and World theme. | M |
| FR-ME-03 | Launch content: 10 Toys and 10 World themes mapped to the 300 levels. | M |
| FR-ME-04 | Daily reward calendar with streak bonus; missing a day does not delete earned rewards. | S |
| FR-ME-05 | A gallery shows collected Toys and can be shared as an image. | C |

### 4.5 Monetisation (MO)

| ID | Requirement | Pri |
| --- | --- | --- |
| FR-MO-01 | Rewarded ads for: revive, free booster, double level reward. Always player-initiated. | M |
| FR-MO-02 | Interstitial ads start at level 6, no more often than a remote-config interval (default 90 s), never during a level, never right after a fail. | M |
| FR-MO-03 | No banner ads. | M |
| FR-MO-04 | IAP: Remove Interstitials (non-consumable), Starter Pack (one time), Booster Bundles. Remove Interstitials keeps rewarded ads optional. | M |
| FR-MO-05 | Purchases can be restored on a new device. | M |
| FR-MO-06 | An ad placement manager preloads ads, handles failure with no blocking UI, and logs every impression and failure. | M |

### 4.6 Sharing and virality (SH)

| ID | Requirement | Pri |
| --- | --- | --- |
| FR-SH-01 | On win, offer Share with an automatically recorded replay clip (last 8 to 12 seconds, 9:16, watermark with store link). | S |
| FR-SH-02 | Share via the system share sheet with a prefilled caption and store link. | M |
| FR-SH-03 | Invite link or code for challenge a friend on the Daily level. | C |
| FR-SH-04 | In-app rating prompt after a win at a high point (for example after level 12 or a 3-star win), at most once per 60 days. | M |

### 4.7 Settings, accessibility and localisation (ST)

| ID | Requirement | Pri |
| --- | --- | --- |
| FR-ST-01 | Toggles for music, sound effects and haptics. | M |
| FR-ST-02 | Colourblind mode: every screw colour also has a distinct head shape (see UI doc). The shapes are on by default for the two most confusable colour pairs and fully on in colourblind mode. | M |
| FR-ST-03 | All strings are externalised (ARB files); v1.0 ships English, with Hindi, Indonesian, Portuguese (Brazil), Spanish and Turkish as the first translation batch. | S |
| FR-ST-04 | Support dynamic text size up to 130% without clipping. | S |
| FR-ST-05 | Reduced motion option disables screen shake and heavy particles. | S |
| FR-ST-06 | Links to privacy policy, terms, restore purchases and consent management. | M |

### 4.8 Analytics and remote config (AN)

| ID | Requirement | Pri |
| --- | --- | --- |
| FR-AN-01 | Log the event set defined in the Launch plan (level start, win, fail, ad shown, booster used, IAP and so on) with level id and session id. | M |
| FR-AN-02 | Firebase Remote Config controls ad cadence, rewards, tray size, booster costs and feature flags with safe defaults baked in. | M |
| FR-AN-03 | Crash reporting is enabled for release builds. | M |
| FR-AN-04 | Analytics may only start after consent is resolved where required. | M |

### 4.9 Data and privacy (DA, PR)

| ID | Requirement | Pri |
| --- | --- | --- |
| FR-DA-01 | Save data is a versioned JSON document with migration support, written atomically. | M |
| FR-DA-02 | Corrupt saves fall back to the last good backup and never crash the app. | M |
| FR-DA-03 | Cloud save via Google Play Games (phase 2). | C |
| FR-PR-01 | Show the Google UMP consent form in applicable regions before initialising ads and analytics; on iOS show the ATT prompt at a sensible moment. | M |
| FR-PR-02 | Provide an in-app privacy policy link and a way to reopen consent choices. | M |
| FR-PR-03 | Complete Play Data Safety and App Store privacy forms accurately from the actual SDK list. | M |

## 5. Non-functional requirements

| ID | Requirement |
| --- | --- |
| NFR-01 | Performance: steady 60 fps on a low-end Android device (2 GB RAM, entry Snapdragon class); never below 30 fps during chain reactions and plate falls. |
| NFR-02 | Start-up: cold start to interactive home screen in under 3 seconds on the same device. |
| NFR-03 | Size: Android download under 50 MB (stretch goal 35 MB). |
| NFR-04 | Memory: peak under 300 MB. |
| NFR-05 | Battery: no wakelocks; frame rate drops to idle when the board is static. |
| NFR-06 | Reliability: crash-free sessions at least 99.5%; no data loss on kill or low battery. |
| NFR-07 | Offline: all gameplay works without network. |
| NFR-08 | Security: no secrets in the repo; ad unit IDs and keys via build config; release builds use R8 shrinking and obfuscation. |
| NFR-09 | Accessibility: tap targets 48 dp or larger; text contrast 4.5:1 for body text, 3:1 for large text. |
| NFR-10 | Maintainability: rules engine unit-test coverage 90% or higher; the CI pipeline blocks merges on failing tests or unsolvable levels. |
| NFR-11 | Compatibility: tested on at least 3 physical or cloud devices spanning low, mid and high tiers, and on aspect ratios from 16:9 to 21:9 with notches. |

## 6. Release scope

**v1.0 (launch):** all M items, most S items, 300 levels, 10 Toys, English plus first translation batch if time allows.

**v1.1 to v1.3:** Daily Challenge polish, replay sharing, hint system, level pack updates every 2 weeks (30 levels), seasonal events.

**Phase 2:** iOS release, cloud save, friend challenges, mediation and bidding expansion, new mechanics (for example moving plates, locked screws needing a key).

## 7. Definition of done (per feature)

1. Linked to requirement IDs and passes their acceptance checks.
2. Unit and widget tests added; all tests green; flutter analyze clean.
3. Verified on an emulator and one physical device at 60 fps.
4. No new analyzer warnings, no TODOs without an issue reference.
5. Docs updated (TDD or UI doc) if behaviour or structure changed.

## 8. Open decisions and risks

| ID | Decision or risk | Default |
| --- | --- | --- |
| D1 | Target audience: 13 and over avoids child-directed requirements, but the game looks kid-friendly. Confirm and set Play Console target audience and ad content ratings consistently. | 13+ |
| D2 | Final game name and icon. | Twist Out (placeholder) |
| D3 | Art style: 2.5D shiny plastic and wood versus flat vector. | Flat vector with soft shading (cheaper, clearer in ads) |
| D4 | Mediation: start with AdMob only or add a second network at launch. | AdMob only, add later |
| R1 | Genre is crowded with look-alikes; differentiation relies on theme, juice and creative testing. | Test 3 themes in soft launch |
| R2 | Puzzle ad creatives fatigue within days; creative supply is a bottleneck. | Plan weekly creative batches |
| R3 | Policy changes in ads, privacy or developer account testing requirements. | Verify before each release |
