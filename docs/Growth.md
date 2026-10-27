# Twist Out: Launch, Growth and Analytics Plan

**Version:** 0.1 (draft) | **Date:** 25 October 2026 | **Depends on:** SRS v0.1, UI/UX document v0.1

Goal: maximise downloads efficiently. All numbers here are starting hypotheses taken from general industry patterns. Replace them with your own data as soon as soft launch produces it.

## 1. Growth strategy in one page

The market research behind this project points to four levers, in this order of importance:

1. **Creative-led paid acquisition.** Puzzle games gain installs mainly through short video ads, and a large share of casual installs come from ads shown inside other puzzle and hyper-casual games. Winning means producing and testing many short, satisfying videos quickly. Ad fatigue for puzzle creatives is short (often about 5 to 7 days), so supply matters.
2. **Store conversion (ASO).** App stores remain the main discovery channel. A good icon, first two screenshots and short description multiply every other effort.
3. **Creator and organic video.** Micro-creators posting satisfying gameplay on short video platforms reach people with no gaming identity. Spark-style boosting of the best organic posts makes them cheap ads.
4. **In-product loops.** Share clips, daily challenges and Toy collections give people reasons to return and to show the game to others.

Principle: do not scale spend until retention and early return on ad spend pass the gates in section 5.

## 2. Positioning and store listing (ASO)

### 2.1 Positioning statement

For casual players who like satisfying puzzles in short breaks, Twist Out is a screw-sorting puzzle where every tap triggers a clean, satisfying chain reaction. Unlike busy match games, it is instantly understood without reading.

### 2.2 Store text drafts (verify limits and keyword volumes when you publish)

| Field | Draft |
| --- | --- |
| Title (30 characters on Google Play) | Twist Out: Screw Puzzle |
| Short description (80 characters) | Unscrew, sort and clear the board in this satisfying screw puzzle. |
| Long description outline | Hook sentence; 4 to 5 bullets (satisfying chain reactions, short levels, play offline, collect Toys, new levels often); who it is for; light keyword repetition; no claims about rankings |
| Candidate keywords | screw puzzle, sort puzzle, bolts, brain teaser, relaxing puzzle, offline puzzle games, satisfying games |

Check real search volume and difficulty with an ASO tool before finalising keywords. Do not use competitor names or trademarks in your listing.

### 2.3 Listing experiments

- Run store listing experiments on 3 icon variants first, then screenshot order, then short description.
- Create custom listings per ad campaign or country so the landing screenshot matches the ad creative.
- First 2 screenshots must show motion-frozen peak satisfaction: plates mid-fall and a full box clear.
- Localise the title, short description and screenshots for the first translation batch (Hindi, Indonesian, Portuguese Brazil, Spanish, Turkish) after the English version converts well.

### 2.4 Ratings and reviews

- Trigger the in-app review prompt after a high point (for example after level 12 or a 3-star win), at most once per 60 days.
- Answer reviews quickly in the first month, especially bugs; fix top review complaints within a week.
- Target an average rating of 4.5 or higher before scaling paid spend.

## 3. Analytics

### 3.1 Event dictionary (FR-AN-01)

All events carry level\_id, session\_id and app\_version. Events must only be sent after consent allows it.

| Event | Parameters |
| --- | --- |
| tutorial\_step | step |
| tutorial\_complete | duration\_s |
| level\_start | level\_id, kind, attempt |
| level\_win | moves, duration\_s, tray\_peak, stars, boosters\_used, revived |
| level\_fail | reason, screws\_left, duration\_s, attempt |
| level\_restart | source (pause or fail) |
| booster\_use | type, source (inventory, coins, ad) |
| revive\_offer | level\_id |
| revive\_accept | level\_id |
| ad\_request, ad\_loaded, ad\_failed | type, placement, error\_code |
| ad\_impression | type (interstitial or rewarded), placement |
| ad\_reward\_granted | placement, reward |
| iap\_view | product |
| iap\_purchase | product, price, currency |
| toy\_part\_unlocked, toy\_complete | toy\_id, part\_index |
| daily\_claim | day, streak |
| daily\_challenge\_complete | seed\_date, stars |
| share\_tap | target, has\_clip |
| settings\_change | setting, value |
| consent\_result | status, region\_group |

User properties: current level bucket, days since install bucket, payer flag, ad exposure bucket, colourblind mode, language.

Ad revenue: use the AdMob and Firebase integration for impression-level revenue, and keep a single source of truth for revenue in your dashboard.

### 3.2 Dashboards to build first

1. **Funnel:** install, first level started, tutorial complete, level 10, level 30, level 100.
2. **Retention cohorts:** D1, D3, D7, D14, D30 by install date and country.
3. **Level health:** win rate, average attempts, drop-off, and fail rate per level; flag levels where the fail rate is more than 2 standard deviations above neighbours.
4. **Monetisation:** ads per daily active user, rewarded opt-in rate, ARPDAU, payer conversion, ARPPU.
5. **Creative performance:** CTR, hook rate (3-second views), installs per thousand impressions, cost per install and D1 retention per creative.

### 3.3 Core KPIs (starting targets)

| KPI | Initial target | Notes |
| --- | --- | --- |
| Tutorial completion | 85% or higher | Below 75% means onboarding needs rework |
| Level 10 reached (of installs) | 50% or higher |  |
| D1 retention | 40% or higher | Genre leaders are often higher; below 30% is a warning |
| D7 retention | 15% or higher |  |
| Rewarded opt-in (of players offered) | 25% or higher |  |
| Session length | 6 to 10 minutes |  |
| Sessions per day | 3 or more |  |
| Crash-free sessions | 99.5% or higher |  |
| Average rating | 4.5 or higher |  |

## 4. Creative playbook

### 4.1 Creative principles

- **Show the real game.** Use real gameplay; platforms and users penalise misleading ads. Satisfying edits and well-chosen levels are fine; fake gameplay or false claims are not.
- **Hook in 3 seconds.** The first frame must already show colour and motion. Aim for a high hook rate before optimising anything else.
- **Vertical 9:16**, 6 to 20 seconds, with versions with and without music. Captions of 4 words or fewer. End card with the icon and store badge for about 1 second.
- **One idea per video**, then iterate on the winners.

### 4.2 Starting hook concepts

| Concept | Description |
| --- | --- |
| Chain reaction | One tap triggers boxes clearing and three plates falling in sequence |
| ASMR close-up | Slow-motion unscrew with sound, no UI |
| Pick the right screw | Player-view challenge with a pointer hesitating, then the correct tap |
| Full tray panic | Tray almost full, a clever move saves the level |
| Before and after | Crowded board to empty board in 10 seconds |
| Pro tip | Do this first to avoid a full tray |
| Seamless loop | Final plate falls into the first frame for endless replay |
| Colour sort | Colourful boxes clear with confetti, rhythm cut to music |
| Hands on screen | Creator-style recording with real finger taps |
| Seasonal skin | Same mechanic in a seasonal world theme |

### 4.3 Production pipeline

1. Use the creative capture mode (UI doc section 11) to record clean footage from perfect solver playthroughs on chosen levels.
2. Edit variants in a video editor or template: change the first 3 seconds, music, captions and end card.
3. Produce 10 to 20 variants per week at the start; keep a log of every variant and its metrics in a sheet.
4. Brief 5 to 10 micro-creators per month with a one-page guide: show real hands, one satisfying moment, store link, no scripts. Boost the best organic posts as ads.

### 4.4 Testing rules

- Test on one network first (TikTok is a good starting channel for casual puzzle; Meta and Google App Campaigns follow), Android only for the first weeks.
- Test budget rule of thumb: a daily budget around 20 to 50 times your target cost per install gives enough data per creative group; do not start below what gives a few hundred installs per week per test.
- Kill rule: pause a creative if after roughly 1,000 to 2,000 impressions its click-through rate or installs per thousand impressions is at least 30% below the campaign median.
- Scale rule: increase spend on winners by 20 to 30% every 2 to 3 days while retention and return stay above the gates.
- Refresh: expect each winning creative to decay within about a week; always have the next batch ready.

## 5. Launch phases and go or no-go gates

| Phase | Duration | What happens | Gate to continue |
| --- | --- | --- | --- |
| P0 Internal and closed test | 2 to 3 weeks | Friends and testers, crash fixes, balance. Check the current Play Console closed-testing requirement for new developer accounts and build it into the calendar. | Crash-free 99.5% or higher; the first 30 minutes play without confusion in 5 observed sessions |
| P1 Soft launch | 2 to 4 weeks | Android only in a few lower-cost markets that resemble your target audience in language and device mix (for example the Philippines, Canada, Australia, Brazil; choose with your own research); about 1,000 to 3,000 dollars total test spend as a starting scale | D1 40% or higher and D7 15% or higher (or clear upward trend), tutorial 85% or higher, rating 4.3 or higher |
| P2 Global scale | 4 to 8 weeks | Expand countries, add translations, add iOS (phase 2), add a second ad network or mediation, raise creative volume | Day-7 return on ad spend is rising or at a level your model can recoup by day 30 to 60 |
| P3 Live-ops | Ongoing | New content, events, creative refresh, LTV tuning | Retention steady; content shipped on schedule |

If a gate fails: fix the biggest drop in the funnel first (usually tutorial, then levels 5 to 15, then ad load), re-test, and only then resume paid spend. Do not buy more traffic to fix a retention problem.

### 5.1 Unit economics worked example (illustrative only; replace with real data)

- Suppose average ad revenue per daily active user is 0.08 dollars and a typical new player is active on 4 distinct days in the first 30 days: LTV at day 30 is about 0.32 dollars.
- If the blended cost per install is 0.30 dollars and some installs are organic (a multiplier of 1.5 organic per paid install reduces blended cost to about 0.12), paid acquisition looks profitable on a day-30 basis.
- If actual numbers differ (higher cost, lower retention), adjust the target cost per install by this formula: Max CPI = LTV at the horizon you can afford to wait, divided by 1 plus the required margin. Measure return on ad spend by cohort at day 1, 3, 7 and 30 and project forward with a retention curve fitted to your data.

## 6. Monetisation tuning

Experiments to run in soft launch (use Remote Config and A/B testing):

| Test | Variants |
| --- | --- |
| Interstitial start level | 4, 6, 10 |
| Interstitial interval | 60 s, 90 s, 120 s |
| Revive offer | Rewarded ad only versus rewarded ad or 150 coins |
| Starter Pack timing | After level 10, after first fail, after 24 hours |
| Booster price | 80, 100, 150 coins |
| Daily reward size | Small, medium, large |

Rules: optimise for D7 retention first, ARPDAU second. Never show two interstitials in a row without gameplay, never show one right after a fail, and keep rewarded ads clearly optional. Watch the share of players who stop playing within one session after an interstitial.

## 7. Virality and community

- **Share clip (FR-SH-01):** auto-recorded 8 to 12 second clip of the best chain of the level with a watermark and store link; test whether prompting share only on 3-star wins beats prompting on every win.
- **Daily Challenge:** same level for everyone each day; show the percentage of players who solved it in 3 stars. Add a share card.
- **Official short-video account:** post 3 to 5 satisfying clips per week made from capture mode; reuse for ads.
- **Community:** a simple Discord or social page is optional at first; ask for feedback in the settings menu and reply to every review in the first month.
- **Cross-promotion:** if you build more games later, each one should link to the others in a gentle in-game placement.

## 8. Live-ops calendar

| Cadence | Content |
| --- | --- |
| Every 2 weeks | 30 new levels forming a new Toy |
| Weekly | A limited-time Daily Challenge streak bonus |
| Monthly | New world theme or new plate shapes |
| Seasonal | Themed skins for major festivals and holidays across your target countries |
| Always | Level health report; patch the 5 worst-performing levels weekly via level pack updates |

## 9. Legal and compliance checklist

- [ ] Play Console developer account verified and payments profile set up; check current requirements for new accounts and testing before production release.
- [ ] Privacy policy hosted on a public URL and linked in the app and store listing.
- [ ] Consent flow (UMP) tested in EEA and UK settings; iOS ATT prompt configured for phase 2.
- [ ] Play Data Safety form matches the real SDK inventory (docs/sdk-inventory.md).
- [ ] Content rating questionnaire completed; target audience and age settings consistent with SRS decision D1.
- [ ] Ads configured with correct content rating and no child-directed treatment unless you deliberately choose it.
- [ ] Trademark and store-name search for the final name and icon concept.
- [ ] Licences for all fonts, music, sound effects, art and AI-assisted assets recorded.
- [ ] Release signing keys backed up securely (Play App Signing enabled).
- [ ] Terms of use and refund process described for purchases.

## 10. Risk register

| Risk | Likelihood | Impact | Response |
| --- | --- | --- | --- |
| Genre is crowded; creatives look like competitors | High | High | Distinct worlds and Toy collection; test 3 themes; keep gameplay honest but cut a unique opening |
| Creative fatigue | High | Medium | Weekly batches, capture mode, creator pipeline |
| D1 retention below target | Medium | High | Rework onboarding and early difficulty; ad cadence test |
| High ad load causes churn | Medium | Medium | Start at level 6, remote config, rewarded-first design |
| Policy rejection (ads, privacy, content) | Medium | High | Pre-launch checklist, truthful store text, accurate Data Safety form |
| Low-end device performance | Medium | High | Performance gate at M4, device lab test, quality tiers |
| Clone or lookalike enters with bigger budget | Medium | Medium | Ship content faster, differentiate through live-ops and themes |
| Solo capacity bottleneck | High | Medium | Agent-driven development, tight scope, defer iOS and social features |

## 11. 90-day roadmap

| Days | Focus |
| --- | --- |
| 1 to 14 | Rules engine, solver, playable prototype; record first prototype footage; start icon and creative tests on organic channels |
| 15 to 30 | Juice, audio, app shell, economy; performance gate; first creator outreach |
| 31 to 45 | Services (consent, ads, analytics), 300 levels, balance; build release candidate |
| 46 to 60 | Closed test, fix crashes and tutorial friction, store assets and ASO drafts |
| 61 to 75 | Soft launch in test markets; daily review of funnel and creatives; first live-ops patch |
| 76 to 90 | Decision: iterate, scale in more countries, or pivot theme; plan iOS and translations |

## 12. Weekly operating rhythm

1. Monday: review last week's retention, level health and creative results; choose the week's 3 experiments.
2. Tuesday to Thursday: ship fixes and new creatives; run agent tasks for level and bug work.
3. Friday: release a patch or level pack; write a short note of what you learned and the next hypothesis.
