# Twist Out: UI/UX Design Document

**Version:** 0.1 (draft) | **Date:** 25 October 2026 | **Depends on:** SRS v0.1, TDD v0.1

## 1. Design principles

1. **Readable in 3 seconds.** A new player, or a viewer of a muted video ad, should understand the goal from the first frame: tap screws, fill boxes.
2. **Satisfaction is the product.** Every tap gets motion, sound and haptics. Juice is a requirement, not decoration.
3. **Text-light.** Icons, colours and animation carry meaning so the game travels across languages.
4. **One thumb, portrait.** All primary controls sit in the lower two thirds of the screen.
5. **Never punish the player's curiosity.** Blocked taps and restarts are free; failure is quick to recover from.
6. **Ad-friendly by design.** Clean silhouettes, high contrast, big colourful objects that read at thumbnail size.

## 2. Visual identity

### 2.1 Art direction

Flat vector shapes with soft inner shading and a subtle glossy highlight, chunky outlines of 2 to 3 dp in a darker shade of the fill, and warm tactile materials (painted wood, enamel metal, plastic). Each World changes the backdrop and plate materials but never the screw colours, so the core readability stays constant.

### 2.2 Screw colours and head shapes (colourblind safe)

Every colour has a unique engraved head symbol. Symbols are always visible at low opacity and fully visible in colourblind mode (FR-ST-02). The most confusable pairs (red and green, blue and purple) always show symbols.

| Index | Colour | Hex | Head symbol |
| --- | --- | --- | --- |
| 0 | Red | #E5484D | Cross |
| 1 | Orange | #F76B15 | Slot |
| 2 | Yellow | #FFC53D | Hexagon |
| 3 | Green | #30A46C | Star (six point) |
| 4 | Teal | #12A594 | Square |
| 5 | Blue | #3E63DD | Ring |
| 6 | Purple | #8E4EC6 | Triangle |
| 7 | Pink | #E93D82 | Diamond |

Matching Boxes use the same colour and show the same symbol on the front label.

### 2.3 UI colour tokens

| Token | Hex | Use |
| --- | --- | --- |
| ink | #2B2118 | Primary text on light surfaces |
| paper | #FFF8EC | Cards, modals |
| cta-primary | #178F5F | Main buttons (pressed #11724C) |
| cta-secondary | #3E63DD | Secondary buttons |
| danger | #D64545 | Fail state, destructive actions |
| coin-gold | #FFC53D | Coin icon and counters |
| scrim | rgba(20,14,8,0.55) | Modal backdrop |
| world-1-bg | #F2D9AE to #D9A86C | Wood Shop gradient |

Verify contrast with a tool before finalising: body text 4.5:1 or better, large text 3:1 or better. White labels on buttons use a 2 dp darker outline for legibility.

### 2.4 Worlds (themes) for launch

Wood Shop, Candy Parlour, Space Station, Toy Garage, Ocean Lab, Desert Market, Snow Cabin, Neon Arcade, Garden Greenhouse, Clock Tower. One backdrop, one plate material set, one music loop and one Toy per world. Ship Wood Shop plus two others polished first for soft launch theme tests.

### 2.5 Typography

- Display and numbers: Fredoka (bold). Body and captions: Nunito. Both are open licence fonts on Google Fonts; bundle them in the app rather than downloading at runtime.
- Fallback for non-Latin scripts: Noto Sans family per language.
- Scale (sp): Display 32, Title 24, Subtitle 18, Body 16, Caption 12. Numbers in HUD use 20 semibold.

### 2.6 Shape, spacing and elevation

4 dp base unit with an 8 dp rhythm. Corner radius: buttons 16, cards 20, modals 28. Drop shadows are soft (blur 8, offset y 4, 20% ink). Icons are 24 dp (HUD) and 32 dp (menus), filled style with rounded joins.

## 3. Layout

Reference device: 360 by 800 dp. All game layouts use proportional zones inside the safe area, so notches and gesture bars are respected.

```
+--------------------------------+
| [II]   Level 12      (coin) 340 |  HUD            ~8%
+--------------------------------+
|  [BOX]  [BOX]  [BOX]  (next)(next) |  Boxes         ~14%
+--------------------------------+
|                                |
|        P L A T E S             |  Board         ~56%
|     with screws on layers      |
|                                |
+--------------------------------+
|  [slot][slot][slot][slot][slot] |  Tray          ~10%
+--------------------------------+
|  [Extra Slot] [Magnet] [Smash]  |  Boosters      ~12%
+--------------------------------+
```

Wide or tall devices: scale the board to fit width, keep zone order, add backdrop art to fill extra height. Banner ads are not used. Board interaction is never covered by system gesture areas.

## 4. Screen inventory and flow

| Screen | Purpose |
| --- | --- |
| Splash | Logo, asset load, consent check; under 2 s |
| Consent (UMP) | Required in applicable regions before ads and analytics |
| Home | Play button, current level, Workshop progress, daily reward, settings, shop |
| Game | The puzzle |
| Pause modal | Resume, restart, settings, home |
| Win modal | Stars, coins earned, double reward ad, next level, share |
| Fail modal | Revive via ad, restart, home |
| Out-of-booster modal | Watch ad or spend coins |
| Workshop | Toy build progress and collection gallery |
| Daily reward | Calendar and daily challenge entry |
| Shop | Remove Interstitials, Starter Pack, booster bundles, restore |
| Settings | Sound, music, haptics, colourblind, reduced motion, language, privacy, consent, restore, credits |
| Rating prompt | Pre-prompt then the system review dialog |

```
Splash -> (Consent) -> Home -> Game -> Win -> Game (next level)
                        |        |-> Fail -> Revive -> Game
                        |        |-> Pause -> Home
                        |-> Workshop / Daily / Shop / Settings
```

Target: from app open to the first screw tapped in under 10 seconds for returning players (Home has a big Play button; level 1 for new players starts automatically after splash).

## 5. Screen specifications

### 5.1 Home

- Centre: large animated Toy silhouette showing build progress, with a Play button below it (primary style, label Level N).
- Top bar: coin chip left, settings gear right.
- Bottom bar: Workshop, Daily (with red dot when claimable), Shop. Maximum 3 items.
- No interstitials on Home. A small animated gift icon appears when a free booster is available.

### 5.2 Game HUD and interaction

- Pause button top left, level number centre (Hard levels show a flame badge, Chill levels show a leaf badge), coin chip right.
- Blocked screws render at 60% brightness with a faint shadow from the covering plate.
- Tap feedback: the screw scales up 1.15 and lifts; the destination highlights.
- Box labels show colour plus symbol. A filling box shows pip dots (0 to 3).
- Tray slots are recessed circles; the first empty slot pulses softly when the tray is nearly full (3 or more of 5 used), turning red-tinted when 1 slot is left.
- Boosters show count badges; a zero count shows a plus icon that opens the out-of-booster modal.
- Idle hint: after 8 seconds without input, one recommended screw wiggles (FR-GP-09).

### 5.3 Win modal

Appears 1.2 s after the last plate falls. Content: 3 stars animate in (0.2 s stagger), coins counted up, button Double (rewarded ad icon) beside primary Next. Secondary icon row: Share clip, Home. No text paragraphs. If an interstitial is due it plays before the modal's Next action, never between win animation and the modal.

### 5.4 Fail and revive modal

Appears 0.6 s after the tray flashes red. Large Revive button with the ad icon and a small label +3 slots. Secondary: Restart. Tertiary: Home. If the player declines revive twice in a row, show Restart as primary. Never auto-play an ad.

### 5.5 Workshop

Grid of Toy cards. The active Toy shows 6 part slots, each lit as unlocked. Tapping a completed Toy replays its reveal animation and offers Share image (FR-ME-05). Locked Toys show a silhouette.

### 5.6 Daily reward and challenge

7-day calendar with the current day highlighted and a streak bonus on day 7. A separate Daily Challenge tile launches today's seeded level.

### 5.7 Shop

Three sections: Remove Interstitials, Starter Pack (one time, highlighted), Booster Bundles. Prices are localised from the store. A Restore Purchases text button sits at the bottom. No timers or countdown pressure in v1.0.

### 5.8 Settings

Toggles for music, sound, haptics, colourblind symbols, reduced motion. Rows for language, privacy policy, terms, manage consent, restore purchases, version, credits and licences.

## 6. Onboarding script (FR-LV-02)

| Level | Layout | Teaching moment | Guidance |
| --- | --- | --- | --- |
| 1 | One plate, 3 red screws, 1 box | Tap a screw and it fills the box | Pointer hand taps each screw; one icon-only prompt |
| 2 | Two plates stacked, 2 colours | Blocked screws and layers | Top plate screws glow; covered screws dim |
| 3 | Two colours, 2 boxes, tray unused | Wrong order goes to the tray | Tray slots highlighted when first used |
| 4 | Mixed colours causing a tray fill | Tray screws auto-move when a box opens (chain reaction) | Slow motion on the first chain |
| 5 | Tray nearly full early | Boosters | A free Extra Slot booster glows and the player is asked to tap it |

Other unlocks: Magnet at level 8, Smash at level 15, Daily Challenge at level 10, Workshop reveal at the end of level 5 (first Part earned). Skipping the tutorial is not offered; steps are fast and the first 5 levels are nearly impossible to fail.

## 7. Components

| Component | Spec |
| --- | --- |
| Primary button | Height 56 dp, radius 16, fill cta-primary, white label (Fredoka 20), 3 dp bottom edge in a darker tone; pressed: scale 0.96 over 80 ms and the edge flattens |
| Secondary button | Height 48 dp, cta-secondary or paper with ink label |
| Icon button | 48 by 48 dp tap area, 24 dp icon |
| Chip (coins) | Height 36 dp, paper fill, gold icon, number in Fredoka |
| Modal | Paper, radius 28, max width 320 dp, scrim behind, enter scale 0.9 to 1.0 with 180 ms ease-out |
| Toast | Bottom above boosters, 2 s, used only for errors such as ad not available |
| Badge | 18 dp circle, count in caption font |

## 8. Motion specification

| Motion | Duration | Notes |
| --- | --- | --- |
| Screw lift and unscrew | 180 ms | Rotate 540 degrees while lifting 8 dp and scaling to 1.15, ease-out |
| Screw flight | 260 ms | Quadratic Bezier arc to the destination, ease-in-out |
| Screw settle | 120 ms | Squash 0.9 then rebound |
| Box fill pop | 160 ms | Scale 1.0 to 1.12 to 1.0 |
| Box clear | 320 ms | Confetti burst, box slides out; next box slides in 240 ms |
| Chain link delay | 90 ms between each auto-move | Pitch rises per link |
| Plate fall | Until off screen | Gravity 2400 dp per second squared, random spin up to 40 degrees per 100 ms; small camera nudge 3 dp for 80 ms on heavy plates |
| Blocked screw tap | 140 ms | Horizontal shake 4 dp, twice |
| Win sequence | 1200 ms | Final plate falls in 0.5 times speed for 400 ms, confetti, then modal |
| Fail sequence | 600 ms | Tray flashes red twice, then modal |
| Modal in and out | 180 ms and 120 ms | Scale and fade |

Reduced motion: shorten flights to 140 ms, remove camera nudge and confetti, keep colour feedback.

## 9. Audio and haptics

| Event | Sound | Haptic |
| --- | --- | --- |
| Screw lift | Short ratchet click | Tick (10 ms light) |
| Screw drop into box | Soft metallic plink | None |
| Screw drop into tray | Dull tock | None |
| Chain link | Plink with pitch up one semitone per link, capped at +8 | Tick |
| Box clear | Bright chime with sparkle | Thud (25 ms medium) |
| Plate fall | Wood or metal clatter, light or heavy variants | Thud on heavy plates |
| Blocked tap | Low muted buzz | Tick |
| Win | Fanfare of about 1.5 s | Pattern 30, 50, 30 ms |
| Fail | Soft descending sting | None |
| Coins | Coin tally ticks | None |
| UI tap | Light pop | None |

Music: one calm loop per World, 60 to 90 seconds, lower than SFX, ducks 50% during win and fail stings. Respect system silent mode and audio focus; never start audio before the first user interaction on any platform where that is restricted.

## 10. Accessibility

- Colour is never the only signal: head symbols, labels and pips all repeat information.
- Tap targets 48 dp or larger; screws may be visually smaller but keep a 48 dp hit area.
- Text scales up to 130% in menus; the game HUD is capped to avoid overlap.
- Reduced motion and haptics toggles; no flashing faster than 3 flashes per second.
- Subtitles are not needed because there is no speech; ensure all essential cues have visual equivalents to sound.

## 11. Store and ad-facing assets

**Icon:** one large glossy screw with a bright colourful head on a warm gradient, tilted 20 degrees, no text. Produce 3 variants for store listing experiments.

**Screenshots (portrait, 5 images):** 1) a mid-level board with a chain reaction caption Unscrew. Sort. Satisfy.; 2) the plates falling; 3) boosters; 4) Toys collection; 5) a Hard level. Keep captions to 4 words or fewer. Plan localised sets for the first translation batch.

**Preview video (15 to 30 s):** open with the most satisfying 3 seconds (plates falling after a chain), then a quick escalation, then the store badge.

**Creative capture mode:** a debug flag that hides HUD elements, fixes the random seed, forces perfect play sequences from the solver and records at 1080 by 1920. This produces unlimited clean ad footage for UA tests (see the Launch plan).

## 12. Copy deck (keep text minimal)

| Key | English |
| --- | --- |
| play\_level | Level {n} |
| double | Double |
| next | Next |
| revive | Revive +3 slots |
| restart | Restart |
| out\_of\_boosters | Get more |
| daily\_title | Daily reward |
| workshop\_title | Workshop |
| rate\_pre | Enjoying Twist Out? |
| remove\_ads | Remove ads |
| restore | Restore purchases |
| no\_ad\_available | No ad available right now |

## 13. Asset list and conventions

- Sprites: SVG masters in /design, exported as PNG at 1x, 2x, 3x then packed into atlases; file names are snake\_case such as screw\_head\_cross.png and plate\_plank\_l.png.
- One layered Figma or Affinity master file in /design (not in the app bundle).
- Audio: WAV masters in /design, shipped as OGG, mono for SFX, under 40 KB each where possible.
- Record every third-party or AI-assisted asset in /docs/asset-licences.md with source and licence, and review before release.
