-- ============================================================
--  HOTEL NUEVA EUROPA · Limpieza  |  Supabase setup
--  1) Crea el proyecto en supabase.com
--  2) SQL Editor -> pega todo esto -> RUN
--  3) Settings -> API: copia Project URL + anon key
--  4) En la app: Ajustes -> Nube -> pega los dos datos -> Conectar
-- ============================================================

create table if not exists public.hne_limpieza (
  id         text primary key,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.hne_limpieza enable row level security;

drop policy if exists "hne_limpieza_all" on public.hne_limpieza;
create policy "hne_limpieza_all"
  on public.hne_limpieza
  for all
  to anon, authenticated
  using (true)
  with check (true);

-- fila inicial (la app la crea sola si no existe)
insert into public.hne_limpieza (id, data)
values ('main', '{}'::jsonb)
on conflict (id) do nothing;
