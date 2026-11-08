# DeFit

PWA for a personal gym + fat-loss routine: 2 full-body workouts a week (Day A / Day B), rest timer, weight and waist tracking, steps, meals and water checklist. UI in Ukrainian. Style = DeSave / deweb.studio.

## Stack
- Static site, no build step, deployed on Vercel. `index.html` holds the whole app (HTML + CSS + JS).
- Local copy: `localStorage` key `defit-v1` (works signed out / offline).
- Sync: Supabase project shared with DeFin and DeSave (`kaiishbdzmpeojnverve`), email + password login (same accounts). Publishable key is in `index.html`.
- Tables from `supabase/defit.sql`: `defit_state` (one row per user, `data` jsonb = whole state without sessions/active) and `defit_sessions` (one row per finished workout, `data` jsonb). RLS: own rows only.
- Merge on open: newer `updated` wins for state; sessions are a union by id minus `S.deleted`.
- `sw.js`: offline shell. Bump `VERSION` whenever shipped files change. Supabase requests are never cached.
- `manifest.webmanifest`, `icons/` (white "D" with a pulse line on the blue→violet gradient).

## Product decisions
- Program: Day A (squat/leg press, lat pulldown, DB bench, RDL, plank), Day B (lunges, DB row, seated DB press, back extension, hanging leg raise); 3×8–12; edit in Profile.
- Weights prefill from the last session; if all sets hit the top of the rep range, +2.5 kg is suggested.
- Rest timer starts when a set is checked (default 90 s, +15 / skip, vibrates at the end).
- Meals: 7:30 / 13:00 / 16:00 / 19:00 (owner's workday schedule).
- Mobile rules: inputs ≥16px, no horizontal scroll, `overscroll-behavior:none`.

## Owner
Andrii Deleniv · deweb.studio
