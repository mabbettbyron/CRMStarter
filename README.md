# CRM Starter

Milestone 1 for a CRM built with:

- Next.js 16
- TypeScript
- Tailwind CSS
- Supabase PostgreSQL
- Supabase Auth
- Next.js App Router

## 1. Install

```bash
npm install
```

## 2. Create Supabase project

Create a Supabase project and copy:

- Project URL
- Publishable key

Copy `.env.example` to `.env.local`:

```bash
cp .env.example .env.local
```

On Windows PowerShell:

```powershell
Copy-Item .env.example .env.local
```

Then replace the placeholders in `.env.local`.

Do not commit `.env.local`.

## 3. Create database

Open the Supabase SQL Editor and run:

`supabase/migrations/001_initial_schema.sql`

## 4. Create a test user

In Supabase Authentication, create a user with an email and password.

## 5. Run locally

```bash
npm run dev
```

Open:

http://localhost:3000

Unauthenticated users are redirected to `/login`.

## 6. GitHub

```bash
git init
git add .
git commit -m "CRM milestone 1 - schema and authentication"
git branch -M main
git remote add origin https://github.com/YOUR-ORG/YOUR-REPO.git
git push -u origin main
```

## 7. Vercel

Import the GitHub repository into Vercel.

Add these environment variables in the Vercel project settings:

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`

Then deploy.

## Scope of milestone 1

Included:
- Data model
- Supabase migration
- Supabase SSR auth setup
- Login page
- Protected CRM layout
- Left navigation
- Placeholder pages

Not included yet:
- CRUD screens
- Search
- Contact forms
- Interaction timeline
- Task management
- Role-based permissions
