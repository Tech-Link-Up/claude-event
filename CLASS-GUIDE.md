# Claude Builder Day — Fullstack App from Scratch
### Next.js + Supabase

By the end of this session you'll have a Next.js app running locally that reads live data from a real Postgres database hosted on Supabase.

> **Starter code:** the finished app lives in this repo under [`builder-day-app/`](builder-day-app/). We'll build it from scratch together — but it's there as a working reference, a catch-up point, or a starting place for your own project.

**Who does what — the two tags in this guide:**

- 🧑 **You do it** — accounts, browsers, passwords, approvals. The steps only a human can do.
- 🤖 **Claude does it** — copy the prompt box, paste it into Claude Code, press Enter, and watch. Every prompt has the real commands baked in, so you can always run them yourself instead.

---

## Step 0 — Setup: you make the accounts, Claude installs the tools

> **⚠️ The paid prerequisite:** Claude Code needs a Claude **Pro** plan.

### Step 0A — 🧑 Create your accounts (before class)

These are your identity on each service — nobody (and no AI) can sign up for you:

1. **Claude** — [claude.ai](https://claude.ai), basic paid plan.
2. **GitHub** — [github.com](https://github.com). Free.
3. **Supabase** — [supabase.com](https://supabase.com) Free.
4. **Vercel** — [vercel.com](https://vercel.com).

5. install [VS Code](https://code.visualstudio.com). Claude writes the code, but you'll want a code editor window to read it in, and add secret keys.

### Step 0B — 🧑 Install Claude Code and log in (the last software you install by hand)

Open a terminal — macOS: the **Terminal** app · Windows: **PowerShell** — and run the one-liner for your platform:

**macOS:**

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

**Windows (PowerShell):**

```powershell
irm https://claude.ai/install.ps1 | iex
```

> **Windows only:** Claude Code also needs **Git for Windows** (it uses its bash under the hood). Quickest: `winget install Git.Git`, then close and reopen PowerShell. (Yes — Windows folks install Git by hand. Macs get theirs from Claude in Step 0C.)

Notice what we *didn't* need: Node, Git (on a Mac), or any developer tools. Claude Code installs on a bare machine — then installs everything else for you. That's why it goes first.

Now close and reopen your terminal. Then create a folder for the workshop and start Claude inside it — type these three lines, pressing Enter after each (they're the same in Terminal and PowerShell):

```bash
mkdir builder-day
cd builder-day
claude
```

(`mkdir` makes the folder, `cd` steps into it, and `claude` starts Claude *in* that folder — which matters, because Claude works on whatever folder it's started in.)

The first run opens a browser to log in with your Claude account. Once you're in, here's the entire user manual you need for today:

- **Permission prompts.** Before Claude runs a command or edits a file, it shows you exactly what it wants to do and waits for a yes. *Reading those prompts is the class* — and today the answer is almost always yes.
- **Paste freely.** The multi-line prompt boxes in this guide paste straight into Claude's input as one message.
- **One session.** You just started Claude inside your workshop folder — stay in that same session all day. Every prompt in this guide assumes you're still there.

**✅ You'll know it worked when:** Claude shows its welcome screen and input box, logged in as you, inside your `builder-day` folder.

### Step 0C — 🤖 Your first prompt: Claude checks (and fixes) your machine

This is what every 🤖 step looks like from here on: nothing to install, nothing to type into the terminal — just copy the box and paste it to Claude.

**📋 Paste this into Claude Code:**

```text
Check whether Node.js (v20 or newer) and Git are installed on this machine.

- If either is missing or too old, install it for my platform. Tell me
  what you're about to do before each install, and if an installer needs
  me to click something, walk me through it.
- When everything works, print the versions of node, npm, and git, and
  tell me plainly that I'm ready for Step 1.
```

**✅ You'll know it worked when:** Claude prints three version numbers and says you're ready for Step 1.

> **If Claude asks you to restart your terminal, that's normal** — a program that's already open (Claude included) can't always see software installed a minute ago. Close the terminal, reopen it, then run `cd builder-day` and `claude --continue` — the `--continue` picks your conversation back up where you left it. Still stuck? Restarting the computer fixes the remaining 5%.

<details>
<summary><strong>Prefer to install Node and Git yourself?</strong> The manual route</summary>

**Node.js — macOS:** download the **LTS** installer from [nodejs.org](https://nodejs.org) and click through it (all defaults are fine), or `brew install node` if you use Homebrew. Quit and reopen Terminal afterwards.

**Node.js — Windows:** download the **LTS** `.msi` from [nodejs.org](https://nodejs.org) and click through it (you do **not** need the "tools for native modules" checkbox), or in PowerShell: `winget install OpenJS.NodeJS.LTS`. Close and reopen PowerShell afterwards — an already-open terminal won't see the new install.

**Git — macOS:** run `git --version` in Terminal. A Mac without Git pops up a dialog offering the **Command Line Developer Tools** — click **Install**, wait, then run `git --version` again. (Homebrew alternative: `brew install git`.)

**Git — Windows:** download from [git-scm.com/download/win](https://git-scm.com/download/win) and keep clicking **Next** (the defaults are fine on every screen), or `winget install Git.Git`. Close and reopen PowerShell.

**One-time Git setup (both platforms)** — tell Git who you are; use the same email as your GitHub account:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

**Verify:** in a fresh terminal, `node -v` (v20+), `npm -v` (10+), and `git --version` should all print version numbers. Still "command not found"? Restart your computer — it forces the system to pick up the new PATH.

</details>

---

## Step 1 — 🤖 Create the Next.js app

**Goal:** a brand-new Next.js project in a folder called `builder-day-app`.

**📋 Paste this into Claude Code:**

```text
Create a new Next.js app for me by running exactly this command:

npx create-next-app@latest builder-day-app --ts --eslint --tailwind --app --no-src-dir --import-alias "@/*" --yes

confirm the builder-day-app
folder exists and give me a one-line summary of what was created.
Once created, test out to make sure it is created correctly and able to be run by using npm run dev, fix any issues you encounter if possible
```

**✅ You'll know it worked when:** a new `builder-day-app` folder shows up, and Claude confirms the app was created inside it.

> The flags in that command answer the setup questions in advance (TypeScript ✅, ESLint ✅, Tailwind ✅, App Router ✅) — that's why nobody gets quizzed, Claude included.

<details>
<summary><strong>Prefer to do it yourself?</strong> The command, by hand</summary>

Run the same command in your own terminal:

```bash
npx create-next-app@latest builder-day-app --ts --eslint --tailwind --app --no-src-dir --import-alias "@/*" --yes
```
Then move into the new folder

```bash
cd builder-day-app
```

</details>

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
3. If you're shown **Security** options, make sure **Enable Data API** ✅ and **Automatically expose new tables** ✅ are on (that's the API our app talks to) — and check **automatic RLS** ✅ if it's offered, so every table you ever create in this project starts locked by default. Our own SQL still enables RLS explicitly (Steps 4–5) — doing it twice is harmless, and the checkbox covers any tables you create outside this guide.
4. Click **Create new project** and wait ~1 minute while it provisions. You just got a full Postgres database in the cloud, for free.
5. Now grab your keys: go to **Project Settings → API Keys**. You need two values:
   - **Project URL** (looks like `https://abcdefgh.supabase.co`)
   - **Secret key** (under "Secret keys" — click **Reveal** to copy it; starts with `sb_secret_...`)

   You'll also see a *publishable* key on that page — we're not using it. The difference: the publishable key is meant for browsers and is limited by database policies; the **secret key has full access to your database**, which is why it must only ever exist on the server — never shared, never committed, never in browser code.

6. Give the keys to your app: create a file called `.env` in the root of your next.js folder (`builder-day-app`) with these two lines, pasting in your own values (there's a `.env.example` in the workshop repo with this exact format):

   ```bash
   SUPABASE_URL=https://your-project-id.supabase.co
   SUPABASE_SECRET_KEY=sb_secret_your-key-here
   ```

> **Two things keep this key secret:** `.env` files are covered by `.gitignore`, so they never get committed to GitHub. And because the variable names do **not** start with `NEXT_PUBLIC_`, Next.js never includes them in the code it sends to browsers — they exist only on the server.

---

## Step 4 (Optional to understand SQL) — Create a table by hand, once

This is the only time in this class you'll run SQL by hand — Step 5 automates every future schema change. It's optional, but recommended: seeing what a table and a query look like makes everything after less magical. (If you skip it, Step 5 creates this table for you.)

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

---

## Step 5 — Hand the schema to Claude (your first reusable prompt)

From here on, nobody types schema changes into a dashboard. A **migration** is a SQL file that lives in your repo: you review it before it runs, git keeps its history, and the Supabase CLI tracks which ones have been applied so each runs exactly once. Reviewable, versioned, tracked — that combination is what makes AI-driven database changes safe.

Paste this into Claude Code from inside your app folder. The schema change is described on the first lines — swap that description out for any future change and reuse the rest of the prompt forever:

```text
Schema change I want: create an "ideas" table with id, title, and
created_at, seeded with 3 fun example app ideas.

Make this change with the Supabase CLI and migration files. Check what's
already set up and skip anything that's done:

1. If there's no supabase/ folder, run: npx supabase init
2. Check I'm logged in by running: npx supabase projects list
   If that fails, tell me to run npx supabase login in my own terminal
   (it opens a browser) and wait for me to confirm.
3. Check this folder is linked to my project (npx supabase migration list
   only works when linked). If not, tell me to run npx supabase link in my
   own terminal — I'll pick my project and enter the database password I
   saved when I created it.
4. Make the schema change following these rules:
   - Every change is a new file created with
     npx supabase migration new <short_description>
     Never edit a migration that has already been pushed — write a new one.
   - Every new table gets Row Level Security enabled with NO policies:
     only our backend, using the secret key, can touch the data.
     (My Supabase project may auto-enable RLS on new tables — write the
     enable statement in the migration anyway; enabling twice is harmless.)
   - Write migrations that are safe even if part of the change was already
     done by hand: create table if not exists, and guard seed inserts so
     they only run when the table is empty.
   - Show me the migration file and WAIT for my approval before running
     npx supabase db push.
5. After pushing, verify the change is live, then remind me to commit the
   migration file to git.
```

Two one-time moments where Claude hands control back to you:

- **`npx supabase login`** — run it in your own terminal; it opens a browser to authorize the CLI.
- **`npx supabase link`** — run it from inside `builder-day-app` (the folder with `supabase/migrations/`), then pick your project from the list and enter the **database password** you saved in Step 3. Running it from the wrong folder still prints "Finished supabase link" — but links that folder instead, and `builder-day-app` stays unlinked.

The rules baked into that prompt are the takeaway, and they're worth keeping for life:

- **Review before apply** — Claude shows you the SQL and waits; nothing touches your database until you approve, and the committed file is your audit trail.
- **Append, never edit** — an applied migration is history; you change the database by adding a new file, not rewriting an old one.
- **Every table starts locked** — RLS on, no policies, access only through your backend.

**Verify:** `supabase/migrations/` contains a timestamped SQL file, and the dashboard's Table Editor shows `ideas` with 3 rows (exactly 3 even if you also did Step 4 — the guarded seed doesn't double up).

---

## Step 6 — Connect the app to Supabase (another reusable prompt)

Everything left is app code. Paste this prompt into Claude Code — same shape as Step 5: check state first, automate what's automatable, hand the manual steps back to the human:

```text
I'm in a Next.js app. Connect it to my Supabase database with ALL database
access on the server — we use the secret key, which must never reach the
browser. Check the current state before acting, and if something is already
done, verify it instead of redoing it:

1. Confirm you can see the folder is a Next.js app.
2. Check .env or .env.local exists in the app root and has SUPABASE_URL and
   SUPABASE_SECRET_KEY with real-looking values
   (https://<project-id>.supabase.co and sb_secret_...).
   Never print the values. If they're missing or still placeholders, stop,
   give me exact instructions to get them (Supabase dashboard → Project
   Settings → API Keys), and wait for my confirmation.
3. Install @supabase/supabase-js and server-only if not already installed.
4. Create lib/supabase.ts exporting a Supabase client built from those env
   vars, with import "server-only" as its first line so browser code can
   never bundle it.
5. Replace app/page.tsx with an async server component that selects all rows
   from the "ideas" table and renders the titles as a simple styled list.
   Include export const dynamic = "force-dynamic" so every request fetches
   fresh data.
6. Restart the dev server and verify the page really shows rows from my
   database. If the query errors or returns nothing, diagnose it — and if
   the "ideas" table doesn't exist, don't create it ad-hoc: stop and tell
   me to run my schema migration prompt first.
7. Finish with a short summary of every file you created or changed and why.
```


### What Claude will build

Two files. `lib/supabase.ts` — the one object your backend uses to talk to the database:

```ts
import "server-only";
import { createClient } from "@supabase/supabase-js";

export const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SECRET_KEY!
);
```

The `import "server-only"` line is a safety guard: if anyone ever imports this file into browser code (a client component), the build fails immediately instead of leaking the key.

And `app/page.tsx` — a server component that queries the table and sends the browser finished HTML:

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

🎉 **You're fullstack.** The page runs only on Next.js's server — it queries Postgres with the secret key, the browser never sees anything but HTML, and the database rejects anyone who isn't your backend.

**Prove it:** add a new row in the Supabase Table Editor, refresh your browser, and watch it appear.

---

# Part 2 — Build your own app

The class app proved the loop: describe → review → verify. Now you point that loop at your own idea, with three reusable prompts — one to shape the idea, one to plan it, one to build it.

**Build it right where you are.** Your `builder-day-app` is already connected to your database, and your Supabase CLI is already linked — so your app takes over this project. Claude adds new tables (through migrations, same as always) and new pages; the ideas list just becomes a leftover souvenir.

**The real skill in Part 2 is scope management.** Bring an ambitious idea — the workshop and planning prompts exist to carve a *version 1* out of it that you can watch working today, with everything else parked on a "later" list, not thrown away. For most ideas the fastest version 1 is a single-user tool — something for *you*, no sign-up — and it's already secure that way, because the database only talks to your backend (that's what the RLS work bought you). Multi-user accounts make a great later phase: the **Auth** stretch goal below is the door.

## Step 7 — 🤖 Workshop the idea (Claude interviews you)

Don't start by writing a spec — let Claude interview you into one.

**📋 Paste this into Claude Code:**

```text
I want to build my own app now. Interview me to figure out what it
should be.

- Ask me what you need to know in small batches I can answer in one
  reply, with a quick follow-up round if my answers change the picture.
- Cover: the problem I'm solving for myself, the one thing the app must
  do well, and the data it stores.
- Treat scope as a design tool: keep my ambitious version as the
  destination, and carve out a version 1 I can watch working in my
  browser today. For most ideas the fastest version 1 is a single-user
  tool with no accounts — recommend that shape when it fits.
- Then write a brief in IDEA.md with three sections: what we're
  building, version 1 (the 2-4 screens or actions and the data they
  store), and a Later list holding everything we deferred. Keep it
  under a page.
```

Stuck for an idea? Steal one of these — each is a proven one-afternoon build:

| Starter idea | What it does |
|---|---|
| **Personal CRM** | People you've met, a note about them, and a "last talked to" date — never lose touch again |
| **Habit tracker** | Tick off daily habits, watch the streaks grow |
| **Coffee journal** | Log each cup — beans, brew method, rating — and find your favorites |
| **Bill splitter** | Log who paid what on a trip, see who owes whom |
| **Reading list** | Books and articles with a status, a rating, and a one-line takeaway |

**✅ You'll know it worked when:** `IDEA.md` exists and describes something you'd actually use.

## Step 8 — 🤖 Turn the idea into a phased plan

**📋 Paste this into Claude Code:**

```text
Read IDEA.md and turn it into a build plan, saved as PLAN.md.

- Break the work into 2-4 small phases. Phase 1 is the smallest version
  I can see working in my browser — usually one table and one page.
- Every phase ends with something visible I can check myself.
- For each phase list: what we build, any schema changes, and how I
  verify it in the browser.
- All schema changes go through my migration workflow (the Step 5
  prompt): new migration file, RLS on with no policies, show me the SQL
  and wait for approval before pushing.
- Carry IDEA.md's Later list into the plan, so deferred ideas stay
  visible as future phases.
- This step is planning only: show me the plan and stop there.
```

Read the plan the way you read migrations — this is your review-before-apply moment for the whole app. If phase 1 sounds almost too small, it's right.

**✅ You'll know it worked when:** `PLAN.md` exists and phase 1 is something you could imagine finished within the hour.

## Step 9 — 🤖 Build it, one phase at a time

**📋 Paste this into Claude Code:**

```text
Read PLAN.md and build PHASE 1 ONLY.

- If the phase needs schema changes, make them with my migration
  workflow (the Step 5 prompt rules) before writing app code.
- Same rules as the class app: all database access on the server, the
  secret key never reaches the browser.
- When the phase works, tell me exactly how to verify it in my browser,
  then stop and wait for my go-ahead before the next phase.
```

When phase 1 checks out in your browser, the rest of the day is one sentence at a time: *"Great — build phase 2."*

**✅ You'll know it worked when:** phase 1 of *your* app is live at localhost:3000 — your data model, your page, and you reviewed every change that got it there.

---

## Stretch goals (if you finish early — or keep going after)

- **Insert from the app** — add a [Server Action](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations) with a form that calls `supabase.from("ideas").insert(...)`. Because inserts also go through the backend with the secret key, no database policy changes are needed.
- **Deploy** — push to GitHub, import the repo into [Vercel](https://vercel.com), and add `SUPABASE_URL` and `SUPABASE_SECRET_KEY` under **Settings → Environment Variables**. Vercel stores them encrypted and only your server code can read them — same rules as `.env`.
- **Auth** — when you want each user to have *their own* data, add sign-up/login with `@supabase/ssr` ([docs](https://supabase.com/docs/guides/auth/server-side/nextjs)), so your backend knows who's asking before it queries.

---

## If you get stuck

Your first move is always the same: paste the exact error (or describe what you expected vs. what happened) into Claude Code and say which step you're on — most problems here are a one-line fix, and Claude is sitting in your project with full context. In the workshop room, the instructor is your second opinion.

There's also a safety net: the finished app lives in this repo under `builder-day-app/` (its README explains how to run it). It's the exact code this guide builds, so you can compare your files against it or continue from it at any point — you'll still need your own Supabase project and `.env` file (Step 3), and the Step 5 prompt can then rebuild the schema from the repo's migration files.

## Troubleshooting

| Symptom | Fix |
|---|---|
| **Anything not in this table** | Paste the exact error into Claude Code and say which step you're on — that's the fastest fix for everything below, too |
| `command not found: npx` | Node.js isn't installed (or terminal needs restarting) — see Step 0 |
| Git says "Please tell me who you are" | Git wants a name/email to stamp on commits (no account involved). Tell Claude — it'll set them with `git config --global`. Use the same email as your GitHub account |
| Page shows no ideas, no error | Check `.env` values, then restart the dev server (`Ctrl+C`, `npm run dev`) |
| Empty list but the table has rows | You're probably using the *publishable* key — Step 3 needs the **secret** key (`sb_secret_...`). Fix `.env` and restart the dev server |
| Build error mentioning `server-only` | You imported `lib/supabase.ts` into a client component — that's the guard working. Query in a server component and pass data down as props |
| Supabase CLI says you're not logged in | Run `npx supabase login` in your own terminal (it opens a browser), then re-run the prompt |
| `supabase link` / `db push` asks for a password | That's the **database password** from Step 3, not an API key. Forgot it? Reset it in the dashboard under **Project Settings → Database** |
| `supabase link` says "Finished" but `migration list` / `db push` still says not linked | You ran it from the wrong folder. `cd builder-day-app` (the folder with `supabase/migrations/`) and run `npx supabase link` again there |
| `db push` prints a Docker daemon connection error | Harmless if Docker Desktop isn't running — that only affects local migration-catalog caching. Your migration still pushed; confirm with `npx supabase migration list` |
| `fetch failed` / network error | Project URL is wrong, or the Supabase project is still provisioning |
