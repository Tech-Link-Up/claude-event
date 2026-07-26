# Claude Builder Day — Fullstack App from Scratch
### Next.js + Supabase

By the end of this session you'll have a Next.js app running locally that reads live data from a real Postgres database hosted on Supabase.

> **Starter code:** the finished app lives in this repo under [`builder-day-app/`](builder-day-app/). We'll build it from scratch together — but it's there as a working reference, a catch-up point, or a starting place for your own project.

---

## Step 0 — Prerequisites (do this before the workshop if possible)

You need five things installed/created:

1. **Node.js** (v20 or newer) — this is the JavaScript runtime everything runs on. Install instructions below.
2. **Git** — the version-control tool we'll use to save our code and ship it. Install instructions below.
3. **A code editor** — [VS Code](https://code.visualstudio.com) recommended.
4. **A free GitHub account** — sign up at [github.com](https://github.com) if you don't have one.
5. **Free Supabase and Vercel accounts** — sign up at [supabase.com](https://supabase.com) and [vercel.com](https://vercel.com). On both, choose **"Continue with GitHub"** — it's one less password and it makes deploying easier later.

### Installing Node.js

**First, check if you already have it.** Open a terminal (macOS: **Terminal** app · Windows: **PowerShell**) and run:

```bash
node -v
```

If it prints `v20.x` or higher, skip ahead — you're done with this step. If it says "command not found" (or prints an older version), install it:

#### macOS

**Option A — Installer (easiest):**
1. Go to [nodejs.org](https://nodejs.org) and download the **LTS** version for macOS.
2. Open the downloaded `.pkg` file and click through the installer (all defaults are fine).
3. Quit and reopen Terminal.

**Option B — Homebrew (if you already use it):**

```bash
brew install node
```

#### Windows

**Option A — Installer (easiest):**
1. Go to [nodejs.org](https://nodejs.org) and download the **LTS** version for Windows (`.msi` file).
2. Run the installer and click through it (all defaults are fine — you do **not** need the "tools for native modules" checkbox).
3. Close and reopen PowerShell. **This matters** — an already-open terminal won't see the new install.

**Option B — winget (in PowerShell):**

```powershell
winget install OpenJS.NodeJS.LTS
```

Then close and reopen PowerShell.

### Installing Git

**First, check if you already have it.** In your terminal, run:

```bash
git --version
```

If it prints a version number (e.g. `git version 2.45.0`), you're done — skip ahead.

#### macOS

Running `git --version` on a Mac without Git pops up a dialog offering to install the **Command Line Developer Tools** — click **Install**, wait for it to finish, then run `git --version` again. That's it.

(Alternative if you use Homebrew: `brew install git`)

#### Windows

**Option A — Installer (easiest):**
1. Go to [git-scm.com/download/win](https://git-scm.com/download/win) and download the installer.
2. Run it. The installer has *a lot* of option screens — the defaults are fine on every single one, so just keep clicking **Next**.
3. Close and reopen PowerShell.

**Option B — winget (in PowerShell):**

```powershell
winget install Git.Git
```

Then close and reopen PowerShell.

#### One-time Git setup (both platforms)

Tell Git who you are — this gets stamped on the code you save:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Use the same email as your GitHub account.

### Verify your setup

In a fresh terminal, run:

```bash
node -v          # should print v20.x or higher
npm -v           # should print 10.x or higher
git --version    # should print a version number
```

If all three print version numbers, you're ready. If a command still isn't found after installing, restart your computer — that fixes it 95% of the time (it forces the system to pick up the updated PATH).

---

## Step 1 — Create the Next.js app

```bash
npx create-next-app@latest builder-day-app
```

It will ask a series of questions — accept the defaults (just press Enter through them: TypeScript ✅, ESLint ✅, Tailwind ✅, App Router ✅).

Then:

```bash
cd builder-day-app
```

---

## Step 2 — Run it

```bash
npm run dev
```

Open **http://localhost:3000** in your browser. You should see the Next.js welcome page. This is your frontend, running locally. Keep this terminal running — it auto-reloads as you edit code.

---

## Step 3 — Create a Supabase project

1. Go to [supabase.com/dashboard](https://supabase.com/dashboard) and click **New project**.
2. Name it `builder-day`, set a database password (save it somewhere), pick the region closest to you.
3. If you're shown **Security** options, keep the defaults: **Enable Data API** ✅ and **Automatically expose new tables** ✅ (that's the API our app talks to), and leave **Enable automatic RLS** unchecked — we'll enable RLS ourselves in Step 4.
4. Click **Create new project** and wait ~1 minute while it provisions. You just got a full Postgres database in the cloud, for free.

---

## Step 4 — Create a table with some data

In the Supabase dashboard, open the **SQL Editor** (left sidebar) and run:
- RLS ON with no policies means the public Data API is locked — anyone with the publishable key gets nothing. This is what we want.

```sql
-- Create a table
create table ideas (
  id bigint primary key generated always as identity,
  title text not null,
  created_at timestamptz default now()
);

-- Add some starter data
insert into ideas (title) values
  ('An app that rates my coffee'),
  ('AI plant doctor'),
  ('Split the bill without the math');

select * from ideas;

-- Lock the table down: Row Level Security on, with NO policies.
-- The public API now returns nothing for this table — the only
-- way to the data is our own backend, which uses the secret key.
alter table ideas enable row level security;
```

If a **"Potential issue detected"** popup asks about Row Level Security, click **Run and enable RLS**. (Our SQL already enables it on the last line — the popup is Supabase being cautious. The rule for this class: the answer to any RLS prompt is always *enable*. RLS locks out the public API keys, never our backend — the secret key bypasses it.)

Check the **Table Editor** (left sidebar) — you should see your 3 rows.

---

## Step 5 — Connect Next.js to Supabase

Install the Supabase client library (in your project folder, in a second terminal), plus a tiny helper we'll use as a safety guard:

```bash
npm install @supabase/supabase-js server-only
```

Get your keys: in the Supabase dashboard go to **Project Settings → API Keys**. You need two values:

- **Project URL** (looks like `https://abcdefgh.supabase.co`)
- **Secret key** (under "Secret keys" — click **Reveal** to copy it; starts with `sb_secret_...`)

You'll also see a *publishable* key on that page — we're not using it. The difference: the publishable key is meant for browsers and is limited by database policies; the **secret key has full access to your database**, which is why it must only ever exist on the server.

Create a file called `.env.local` in the root of your project (there's a `.env.example` in the workshop repo with this exact format — copy it into your app as `.env.local` and fill in your values):

```bash
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_SECRET_KEY=sb_secret_your-key-here
```

> **Two things keep this key secret:** `.env.local` is in `.gitignore`, so it never gets committed to GitHub. And because the variable names do **not** start with `NEXT_PUBLIC_`, Next.js never includes them in the code it sends to browsers — they exist only on the server.

---

## Step 6 — Create the Supabase client

Create a file `lib/supabase.ts`:

```ts
import "server-only";
import { createClient } from "@supabase/supabase-js";

export const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SECRET_KEY!
);
```

This is the one object your backend uses to talk to the database. The `import "server-only"` line is our safety guard: if anyone ever imports this file into browser code (a client component), the build fails immediately instead of leaking the key.

---

## Step 7 — Show real data on the page

Replace the contents of `app/page.tsx` with:

```tsx
import { supabase } from "@/lib/supabase";

// Render on the server for every request, so new rows show up on refresh.
// Without this, the deployed page would be a frozen snapshot from build time.
export const dynamic = "force-dynamic";

export default async function Home() {
  const { data: ideas } = await supabase.from("ideas").select();

  return (
    <main className="mx-auto max-w-xl p-8">
      <h1 className="text-2xl font-bold mb-4">💡 App Ideas</h1>
      <ul className="space-y-2">
        {ideas?.map((idea) => (
          <li key={idea.id} className="rounded border p-3">
            {idea.title}
          </li>
        ))}
      </ul>
    </main>
  );
}
```

Restart the dev server (`Ctrl+C`, then `npm run dev` — needed so it picks up `.env.local`), and refresh **http://localhost:3000**.

🎉 **You're fullstack.** This component runs only on Next.js's server — it queries Postgres with the secret key and sends the browser finished HTML. The key never leaves the server, and the database itself rejects anyone who isn't your backend.

**Prove it:** add a new row in the Supabase Table Editor, refresh your browser, and watch it appear.

---

## Stretch goals (if we have time)

- **Insert from the app** — add a [Server Action](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations) with a form that calls `supabase.from("ideas").insert(...)`. Because inserts also go through the backend with the secret key, no database policy changes are needed.
- **Deploy** — push to GitHub, import the repo into [Vercel](https://vercel.com), and add `SUPABASE_URL` and `SUPABASE_SECRET_KEY` under **Settings → Environment Variables**. Vercel stores them encrypted and only your server code can read them — same rules as `.env.local`.
- **Auth** — when you want each user to have *their own* data, add sign-up/login with `@supabase/ssr` ([docs](https://supabase.com/docs/guides/auth/server-side/nextjs)), so your backend knows who's asking before it queries.

---

## If you fall behind

Flag the instructor — most problems here are a one-line fix. The finished app also lives in this repo under `builder-day-app/` (its README explains how to run it). It's the exact code this guide builds, so you can compare your files against it or continue from it at any point — you'll still need your own Supabase project and `.env.local` (Steps 3–5).

## Troubleshooting

| Symptom | Fix |
|---|---|
| `command not found: npx` | Node.js isn't installed (or terminal needs restarting) — see Step 0 |
| Page shows no ideas, no error | Check `.env.local` values, then restart the dev server (`Ctrl+C`, `npm run dev`) |
| Empty list but the table has rows | You're probably using the *publishable* key — Step 5 needs the **secret** key (`sb_secret_...`). Fix `.env.local` and restart the dev server |
| Build error mentioning `server-only` | You imported `lib/supabase.ts` into a client component — that's the guard working. Query in a server component and pass data down as props |
| `fetch failed` / network error | Project URL is wrong, or the Supabase project is still provisioning |
