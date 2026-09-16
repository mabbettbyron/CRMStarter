-- CRM initial schema
-- Run this in Supabase SQL Editor for the first prototype,
-- or use it as the first migration when you adopt the Supabase CLI.

create extension if not exists pgcrypto;

create table public.individuals (
  id uuid primary key default gen_random_uuid(),
  first_name text not null,
  last_name text not null,
  email text,
  phone text,
  mobile text,
  address_line_1 text,
  address_line_2 text,
  city text,
  postcode text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.companies (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  trading_name text,
  website text,
  email text,
  phone text,
  address_line_1 text,
  address_line_2 text,
  city text,
  postcode text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.contacts (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  first_name text not null,
  last_name text not null,
  job_title text,
  email text,
  phone text,
  mobile text,
  is_primary boolean not null default false,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create type public.party_type as enum ('individual', 'contact');

create table public.interactions (
  id uuid primary key default gen_random_uuid(),
  party_type public.party_type not null,
  individual_id uuid references public.individuals(id) on delete cascade,
  contact_id uuid references public.contacts(id) on delete cascade,
  interaction_type text not null,
  subject text not null,
  notes text,
  occurred_at timestamptz not null default now(),
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now(),
  constraint interactions_exactly_one_party check (
    (party_type = 'individual' and individual_id is not null and contact_id is null)
    or
    (party_type = 'contact' and contact_id is not null and individual_id is null)
  )
);

create type public.task_status as enum ('open', 'in_progress', 'completed', 'cancelled');
create type public.task_priority as enum ('low', 'normal', 'high');

create table public.tasks (
  id uuid primary key default gen_random_uuid(),
  party_type public.party_type not null,
  individual_id uuid references public.individuals(id) on delete cascade,
  contact_id uuid references public.contacts(id) on delete cascade,
  title text not null,
  description text,
  due_at timestamptz,
  status public.task_status not null default 'open',
  priority public.task_priority not null default 'normal',
  assigned_to uuid references auth.users(id),
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint tasks_exactly_one_party check (
    (party_type = 'individual' and individual_id is not null and contact_id is null)
    or
    (party_type = 'contact' and contact_id is not null and individual_id is null)
  )
);

create index contacts_company_id_idx on public.contacts(company_id);
create index interactions_individual_id_idx on public.interactions(individual_id);
create index interactions_contact_id_idx on public.interactions(contact_id);
create index tasks_individual_id_idx on public.tasks(individual_id);
create index tasks_contact_id_idx on public.tasks(contact_id);
create index tasks_assigned_to_idx on public.tasks(assigned_to);

-- Enable RLS immediately. Policies are intentionally conservative:
-- an authenticated user may access CRM records; anonymous users may not.
alter table public.individuals enable row level security;
alter table public.companies enable row level security;
alter table public.contacts enable row level security;
alter table public.interactions enable row level security;
alter table public.tasks enable row level security;

create policy "authenticated users can access individuals"
on public.individuals for all
to authenticated
using (true)
with check (true);

create policy "authenticated users can access companies"
on public.companies for all
to authenticated
using (true)
with check (true);

create policy "authenticated users can access contacts"
on public.contacts for all
to authenticated
using (true)
with check (true);

create policy "authenticated users can access interactions"
on public.interactions for all
to authenticated
using (true)
with check (true);

create policy "authenticated users can access tasks"
on public.tasks for all
to authenticated
using (true)
with check (true);
