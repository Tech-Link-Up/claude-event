# Claude Builder Day — Starter App

The finished version of the app we build in the workshop: a Next.js app that reads live data from a Supabase Postgres database, with all database access locked behind the server.

You can either **build it yourself from scratch** by following [`CLASS-GUIDE.md`](../CLASS-GUIDE.md) (recommended — that's the whole point of the day), or use this folder as a working reference / catch-up point.

## Run it locally

1. Install dependencies:

   ```bash
   npm install
   ```

2. Create a Supabase project and the `ideas` table (Steps 3–4 of the class guide).

3. Copy `.env.example` to `.env.local` and fill in your own values from the Supabase dashboard (**Project Settings → API Keys**):

   ```bash
   cp .env.example .env.local
   ```

4. Start the dev server:

   ```bash
   npm run dev
   ```

Open [http://localhost:3000](http://localhost:3000) — you should see the ideas from your database. Add a row in the Supabase Table Editor, refresh, and watch it appear.

## How it's wired

- `lib/supabase.ts` — the Supabase client, created with the **secret key**. `import "server-only"` makes it a build error to load this file in browser code.
- `app/page.tsx` — a server component that queries the `ideas` table and renders HTML. The browser never talks to Supabase and never sees the key.
- The database has Row Level Security enabled with **no policies**, so the public Supabase API returns nothing — this backend is the only way in.

## Deploy

Push to GitHub, import the repo into [Vercel](https://vercel.com), and add `SUPABASE_URL` and `SUPABASE_SECRET_KEY` under **Settings → Environment Variables**.
