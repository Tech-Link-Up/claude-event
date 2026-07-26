-- Create the ideas table.
-- "if not exists" makes this safe even if the table was already
-- created by hand in the SQL Editor (Step 4 of the class guide).
create table if not exists ideas (
  id bigint primary key generated always as identity,
  title text not null,
  created_at timestamptz default now()
);

-- Lock the table down: Row Level Security on, with NO policies.
-- The public API returns nothing for this table — the only way to
-- the data is our own backend, which uses the secret key.
alter table ideas enable row level security;

-- Seed starter data, but only if the table is empty,
-- so re-running against an existing database never duplicates rows.
insert into ideas (title)
select v.title
from (
  values
    ('An app that rates my coffee'),
    ('AI plant doctor'),
    ('Split the bill without the math')
) as v(title)
where not exists (select 1 from ideas);
