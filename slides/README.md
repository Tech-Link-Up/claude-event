# Slides — Claude Code for Beginners, Orange County

Front-of-day deck for **Sat Aug 1, 2026 · 1:00–5:00 PM · The Ticket 500, Newport Beach**.
Working copy for Travis + Danny. Not an attendee link — Travis presents from his own laptop.

## Open it

```bash
open slides/deck.html          # macOS
```

No build step, no server, no dependencies. It's one self-contained HTML file plus assets.

| Key | Does |
|---|---|
| `→` `space` `click-right` | next slide |
| `←` `click-far-left` | back |
| `f` | fullscreen — **use this to check projection** |
| `b` | hide the presenter bar |
| `Home` / `End` | jump to first / last |
| `#12` in the URL | deep-link straight to a slide |

`slides/index.html` is a contact sheet of all 25 slides — quickest way to review without clicking through.


## ⚠ Assets are not in this repo

`deck.html` is the source of truth for structure and copy, but it loads images,
QR codes and the Copernicus font from a `slides/assets/` folder that is **deliberately
kept out of git** to keep the repo light. Same for `slides/video/` and `slides/out/`.

Opening `deck.html` straight from a fresh clone will show the layout and text with
broken images. To see it fully rendered, get the `assets/`, `out/` and `video/`
folders from Travis and drop them in alongside `deck.html`.

## What's here

```
slides/
├── deck.html          the deck (edit this)
├── index.html         contact-sheet overview, clickable
├── assets/            images, QR codes, fonts, logos
├── out/               s00–s24.png — a still of every slide
└── video/
    └── cold-open.mp4  1:17 cold open, plays on slide 02
```

## Running order

| # | Slide | Who |
|---|---|---|
| 00 | Claude OC card + setup QR | doors, 12:30 |
| 01 | Holding — **WiFi ⚠ still blank** + class guide QR | doors |
| 02 | ▶ Cold open video (1:17) | press play to start |
| 03 | Agenda — 1:00 → 4:30 | Travis |
| 04 | Something global — 33 countries / 67 cities | Travis |
| 05 | Claude OC — Conversations LA photos, claudeoc.com, WhatsApp | Travis |
| 06 | I'm Travis | Travis |
| 07 | Tech Link Up thank-you | Travis |
| 08 | Who's in this room — hand-raise polls | Travis |
| 09 | The spectrum — lost ←→ ahead | Travis |
| 10 | This is not about apps — the story | Travis |
| 11 | Today's goal — a full stack app | Travis |
| 12 | What's ahead — LA Impact Lab, Aug 8 | Travis |
| 13 | Anatomy of a full stack app | Travis |
| 14–16 | GitHub · Supabase · Vercel | Travis |
| 17 | This is the thing — the terminal | Travis |
| 18 | Three modes — plan / approve / auto | Travis |
| 19 | `/model` — Fable · Sonnet · Opus | Travis |
| 20 | `/effort` — low → max | Travis |
| 21 | $50 API credits — first 60 | Travis |
| 22 | Set up — **Danny takes over here** | Danny |
| 23 | Done early? Two jobs | Danny |
| 24 | Go build — deck goes dark | Danny |

## Open items

- [ ] **WiFi credentials** — slide 01 has two dashed blanks. Search `class="blank"` in `deck.html`.
- [ ] **Repo README** — every setup QR in the deck points at this repo's root, which currently shows a bare file listing. Two lines linking to `CLASS-GUIDE.md` would fix it.
- [ ] **Headcount vs credits** — 100 RSVPs accepted, the offer link accepts 60.
- [ ] **Projector test** — the deck has only been checked in headless Chrome at 1480×980, never on real hardware. Hit `f` before doors.

## Notes for editing

- Canvas is a fixed **1480×980**, scaled to fit whatever screen it's on. Letterboxes rather than clips.
- Palette and type come from Travis's Claude SoCal design kit — clay `#D97757`, ink `#141413`, Copernicus Medium for display, Helvetica Neue for everything else. The font ships in `assets/`.
- Slide 00 is built to match the cold open's final frame exactly, so the video hands off to it seamlessly.
- Six illustrations were generated to one shared style prompt. If you add more, match it or they'll drift.
- The `$50 credits` slide has two warning cards for a reason — the credits are **API credits**, not Claude Code, and a wrong Org ID submission cannot be undone. Read both aloud before anyone scans.

## Facts, and where they came from

Nothing in the deck is guessed. `33 countries · 67 cities` is live from claude.com/community. The LA Impact Lab date is from Travis's calendar. Event badges are the real Claude Community covers. The terminal screenshot is Travis's actual session. Travis's own attendee numbers were deliberately left out.
