-- DeFit tables in the shared DeFin/DeSave Supabase project. Run once in SQL Editor.
create table if not exists public.defit_state (
  user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
create table if not exists public.defit_sessions (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  id text not null,
  data jsonb not null,
  started_at timestamptz not null default now(),
  primary key (user_id, id)
);
create index if not exists defit_sessions_user_started on public.defit_sessions (user_id, started_at);

alter table public.defit_state enable row level security;
alter table public.defit_sessions enable row level security;

drop policy if exists "defit_state own" on public.defit_state;
create policy "defit_state own" on public.defit_state
  for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
drop policy if exists "defit_sessions own" on public.defit_sessions;
create policy "defit_sessions own" on public.defit_sessions
  for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

grant select, insert, update, delete on public.defit_state, public.defit_sessions to authenticated;
