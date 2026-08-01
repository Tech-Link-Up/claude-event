# Workshop rules (Claude Builder Day)

These apply to every change in this app, including work that goes beyond the class guide:

- **Database changes go through migration files.** Create each change with `npx supabase migration new <short_description>`; append a new migration rather than editing one that's been pushed, and show the SQL for approval before running `npx supabase db push`.
- **Every new table gets Row Level Security enabled, with no policies.** The app reads data on the server using the secret key; the public Data API stays locked.
- **Secrets stay server-side.** `SUPABASE_SECRET_KEY` lives in `.env`: keep it out of output and logs, out of git, and out of client components — `lib/supabase.ts` enforces this with `import "server-only"`, so route all database access through it.

## Frontend conventions

- **UI components come from shadcn/ui.** If `components.json` doesn't exist yet, run `npx shadcn@latest init` first. Add components on demand with `npx shadcn@latest add <component>` rather than pre-installing the whole set. Prefer a shadcn component over a hand-rolled equivalent when one exists (button, input, dialog, card, etc.).
- **Icons come from `lucide-react`** (shadcn's default — installed by `shadcn init`).
- **Forms use `react-hook-form` + `zod`** (+ `@hookform/resolvers`), wired through shadcn's `<Form>` component. Validate with a zod schema rather than ad-hoc checks.
- **Action feedback uses `sonner`** for toasts (e.g. "Saved", "Something went wrong") instead of `alert()` or silent failures.


<!-- BEGIN:nextjs-agent-rules -->
# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` before writing any code. Heed deprecation notices.
<!-- END:nextjs-agent-rules -->