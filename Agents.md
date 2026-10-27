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
