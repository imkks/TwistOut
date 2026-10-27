# Twist Out: Antigravity Build Playbook

**Version:** 0.1 (draft) | **Date:** 25 October 2026 | **Use with:** SRS, TDD, UI/UX document

This playbook turns the specification into a sequence of agent tasks for Google Antigravity. Antigravity is an agent-first IDE with an Editor view and an Agent Manager view where you spawn and supervise agents. Its folder conventions and features change between versions, so check the in-app documentation for your version where this playbook says verify.

## 1. How to work with Antigravity on this project

### 1.1 Working agreements

1. **Specs first.** Copy the five documents into /docs as Markdown (export from the docs, or paste) before the first agent run. Agents get a short summary in AGENTS.md and read the full docs only when relevant.
2. **One agent per module.** Run parallel agents only on separate folders (for example domain/ and services/). Never have two agents editing the same files.
3. **Plan before code on big tasks.** Use Planning mode for milestones M1, M2, M3, M7 and M8, and read the plan artifact before approving. Use Fast mode for small fixes and polish.
4. **Tests are the contract.** Every task ends with the agent running flutter analyze and flutter test and reporting the output. A task is not done until both pass.
5. **Small commits.** Ask the agent to commit per task with a message that cites requirement IDs (for example FR-GP-03).
6. **Review terminal commands at first.** Keep a review policy that asks before running commands until you trust the agent's habits; relax it later for test and analyze commands.
7. **Do not let agents invent package APIs.** Instruct them to check the installed package version and its documentation before using an API, and to prefer small proven packages.
8. **Visual checks.** For quick UI iteration the agent can run the game as a Flutter web build in its browser; always do the final check on an Android emulator and a real device, because performance and haptics differ.
9. **Docs stay true.** If code changes behaviour or structure, the agent must update the relevant doc in the same commit.

### 1.2 Project files for Antigravity

Antigravity reads project rules from an AGENTS.md at the workspace root (supported by recent IDE versions) and from rule files under a hidden agents folder (the folder was named .agent in earlier versions and .agents in newer ones; verify). It also supports saved workflows you trigger with a slash command, and skills defined in SKILL.md files. The sections below give you the content.

## 2. Bootstrap checklist (before M0)

1. Install Flutter (stable), Android Studio with the Android SDK and an emulator, and Git. Run flutter doctor until it is clean.
2. Create a GitHub repository and an empty folder twist\_out.
3. Create /docs and add the five documents plus docs/INDEX.md (one paragraph per document).
4. Create AGENTS.md using section 3.
5. Create the rule and workflow files in section 4 and 5.
6. Open the folder in Antigravity, confirm in the Agent Manager that the rules are detected (start a throwaway task and ask the agent to list the rules it sees).
7. Create Firebase and AdMob accounts later, at M7. Until then use test IDs only.

## 3. AGENTS.md (copy this file to the repo root)

```
# Twist Out: standing instructions for AI agents

## Project
Twist Out is a casual mobile puzzle game (Flutter 3 + Flame, Dart 3). Players unscrew coloured screws from stacked plates into colour boxes and a 5-slot tray.
Source of truth: /docs (SRS = what, TDD = how, UI doc = look and feel, Playbook = process, Launch plan = growth).
When docs and code disagree, stop and ask the human which is right.

## Architecture rules (hard)
- Layers: domain (pure Dart) -> services (interfaces) -> game (Flame) -> app/features (Flutter UI).
- lib/domain must NEVER import flutter or flame. Enforce with a test that scans imports.
- Game rules live only in domain/rules as a pure function step(state, command) -> (state, events). The UI and Flame layers never mutate game state.
- All services (ads, analytics, config, iap, consent, audio, haptics, storage) are used through abstract interfaces with fakes for tests.
- No physics engine. Plate falling uses simple custom gravity.
- No allocations in hot update loops; pool sprites and particles.

## Code style
- Dart null safety, strict analyzer (analysis_options.yaml with flutter_lints plus strict casts and strict inference).
- Small files (under 300 lines), small functions, descriptive names, no dead code.
- Immutable models (copyWith). Use sealed classes for commands and events.
- Comments explain why, not what. Public APIs get doc comments.
- Strings come from ARB localisation files, never hard-coded in widgets.

## Process rules
- Before finishing any task run: flutter analyze && flutter test && dart run tool/validate_levels.dart. Report the results.
- Add or update tests for every behaviour change. Domain coverage target 90% or higher.
- Commit per task. Message format: type(scope): summary [FR-xx-nn].
- Never commit secrets, keystores, google-services files with real keys, or real ad unit IDs. Use test IDs in debug.
- Do not add dependencies without stating why and checking the latest compatible version and licence.
- Do not edit files outside the task scope. If a refactor is needed, propose it first.
- Ads and analytics must wait for consent. Ads never show before level 6 and never block gameplay on failure.

## Done means
Requirement IDs satisfied, tests green, analyzer clean, docs updated, verified on an emulator, no new warnings.
```

## 4. Rule files (optional split of AGENTS.md)

Create these small files in the Antigravity rules folder if you prefer focused rules. Each should be under 40 lines.

| File | Content |
| --- | --- |
| rules/domain-purity.md | The no-Flutter-imports rule, determinism requirement, how to write reducer tests, invariants list from TDD section 4.3 |
| rules/performance.md | Frame budget, pooling, atlas usage, particle cap, how to profile; reject changes that allocate in update() |
| rules/privacy-ads.md | Consent first, ad cadence, no ads before level 6, no child-directed targeting, SDK inventory must be updated when adding an SDK |
| rules/ui-style.md | Colour tokens, fonts, tap target sizes, motion durations from the UI doc, no hard-coded strings |

## 5. Workflows (saved prompts to trigger with a slash command)

**/new-feature**

```
Read AGENTS.md and the SRS requirement IDs I name. Produce a short implementation plan listing files to add or change, tests to write, and risks. Wait for my approval. Then implement, run analyze and tests, update docs, and commit with the requirement IDs.
```

**/add-levels**

```
Using the generator in lib/domain/generator, create N levels for world W within difficulty band B. Run the solver on each, reject unsolvable or out-of-band levels, write JSON to assets/levels, run tool/validate_levels.dart, and give me a table of id, difficulty, minimum tray peak and random-bot win rate.
```

**/release-check**

```
Run analyze, tests, level validation and a release build. Verify no test ad IDs in the release artifact, check app size against the budget, list all SDKs and compare with docs/sdk-inventory.md, and report any mismatch with the Data Safety draft.
```

**/perf-pass**

```
Profile levels 1, 50, 150 and 300 in profile mode on the emulator. Report frame times, jank counts and memory. Propose the three highest impact fixes ranked by effort. Do not change code until I approve.
```

## 6. Milestone prompts

Each milestone has a goal, a prompt to paste into a new Agent Manager conversation, and a human check. Estimated durations assume one developer supervising agents.

### M0. Project scaffolding (about 1 day)

**Prompt:** Read AGENTS.md and the TDD section 3. Create the Flutter project twist\_out with the folder structure from the TDD, Riverpod, strict analysis options, flutter\_lints, a CI workflow (analyze, test, validate levels, build debug APK), a test that fails if lib/domain imports flutter or flame, and placeholder tool scripts. Commit. **Human check:** app launches on the emulator showing a blank game scene; CI passes.

### M1. Domain model and rules engine (2 to 3 days, Planning mode)

**Prompt:** Implement lib/domain/model and lib/domain/rules exactly as in the TDD section 4 and SRS section 3 (FR-GP-01, FR-GP-03, FR-GP-07). Include geometry, blocking, TapScrew, boosters Extra Slot and Magnet, revive slots, win and lose detection and events. Write unit tests for each rule and property tests with random tap sequences that check all invariants. Coverage 90% or higher. **Done when:** all tests green; a CLI script can play a level with random taps and print events.

### M2. Level format, validator and solver (3 days, Planning mode)

**Prompt:** Implement the level JSON loader, shapes.json catalogue (10 shapes to start), tool/validate\_levels.dart and the DFS solver with memoisation and node cap from TDD sections 6 and 7. Include difficulty scoring with random and greedy bots. Hand-author 10 levels for the tutorial and early game and prove they pass. **Done when:** validator fails on a deliberately broken level and passes on good ones; solver output shows solution path and minimum tray peak.

### M3. Flame board prototype (4 days, Planning mode)

**Prompt:** Build the Flame BoardGame and components from TDD section 8 using placeholder shapes (coloured vector shapes, no final art). Render a level from JSON, handle taps through the reducer, play events as animations with the EventPlayer, and implement plate fall with custom gravity. Show boxes and tray per the UI layout. Follow motion durations in UI doc section 8. **Human check:** play levels 1 to 10 on the emulator; it already feels responsive and readable. This build is your first shareable prototype; record a video of it.

### M4. Juice, audio, haptics and performance gate (3 days)

**Prompt:** Add particles (cap 150), chain pitch ramp, squash and settle, camera nudge, win and fail sequences, audio service with pooled players, haptics service and the settings toggles. Then run /perf-pass. **Done when:** 60 fps on the low-end test device on levels 1, 50 and 150 or a written plan to fix; reduced-motion mode works.

### M5. App shell (4 days)

**Prompt:** Implement Splash, Home, Game HUD, Pause, Win and Fail modals, Settings, tutorial overlay for levels 1 to 5, save system with atomic writes, backup and migrations, per SRS 4.7, 4.9 and UI doc sections 4 to 6. Use fakes for ads for now. **Done when:** a new install can play from level 1 through 20, kill the app, and resume with progress intact.

### M6. Economy and meta (4 days)

**Prompt:** Implement coins, booster inventory and shop-by-coins, out-of-booster modal (ad stubbed), Workshop and Toy progression (6 Parts, 5 levels per Part), daily reward calendar and Daily Challenge with seeded generation, per SRS 4.3 and 4.4. Values come from a ConfigService with defaults from TDD section 11. **Done when:** a player can complete a Toy and see the reveal; economy values change when fake config changes.

### M7. Platform services (4 days, Planning mode)

**Prompt:** Implement real ConsentService (UMP), AdsService (AdMob test IDs), IapService, AnalyticsService, ConfigService and Crashlytics per TDD sections 9 and 11. Ads wait for consent, interstitials start at level 6 with a cooldown, rewarded ads grant rewards only on the reward callback, and failures never block play. Add every event from the Launch plan. Write the SDK inventory. **Human check:** with test IDs you see ads at the right moments; airplane mode and consent denial both leave the game fully playable.

### M8. Content and balancing (5 days, Planning mode)

**Prompt:** Implement the generator from TDD 7.3 and use /add-levels to produce 300 levels in 10 worlds following the sawtooth curve (every 5th Chill, every 10th Hard). Create the difficulty report. Hand-polish the first 50 levels. **Human check:** play levels 1 to 60 yourself; ask 3 friends to play the first 30 minutes while you watch silently.

### M9. Art, QA, store and soft launch build (5 days or more)

**Prompt:** Replace placeholders with final art and audio, run a localisation pass for the first translation batch, add creative capture mode, run /release-check and /perf-pass, and prepare store listing assets per UI doc section 11. **Done when:** a release app bundle is uploaded to the Play internal testing track and passes a 3-device test run.

## 7. Prompt patterns that work well with agents

- State the goal, the files in scope, the requirement IDs, and the acceptance test in one message.
- Ask for a plan and wait for approval on anything that touches more than 5 files.
- Ask the agent to write the failing test first for bug fixes.
- When an agent loops on a failing test, tell it to stop, explain the failure in plain words, list two hypotheses, and test the cheaper one first.
- When quality drops in a long conversation, start a new conversation with a one-paragraph handover instead of continuing.
- Use a short review prompt after each milestone: Review this diff against AGENTS.md and the TDD. List violations, risks and missing tests. Do not change code.

## 8. Human-only tasks (agents cannot do these)

1. Create and verify the Play Console and AdMob accounts, and set up payments and tax.
2. Decide target audience and content rating answers (SRS decision D1) and complete the Data Safety form.
3. Choose final name, icon and brand; run trademark and store-name checks.
4. Review third-party and AI-assisted asset licences.
5. Final playtesting, taste decisions on juice, and every release approval.
6. Check current Play Console requirements for new developer accounts (for example closed-testing requirements before production) and plan the calendar around them.

## 9. Suggested schedule

| Week | Milestones | Output |
| --- | --- | --- |
| 1 | M0, M1, start M2 | Rules engine with tests |
| 2 | M2, M3 | Playable prototype and first video |
| 3 | M4, M5 | Game feels good; full shell |
| 4 | M6, M7 | Economy, ads, analytics on test IDs |
| 5 | M8 | 300 levels balanced |
| 6 | M9 | Release candidate on internal testing |
| 7 to 8 | Closed test and soft launch | Retention and CPI data |

Keep the prototype from end of week 2 as a creative asset: start testing ad hooks early using screen recordings of the prototype, long before the final art is ready.
