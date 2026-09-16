import { LoginForm } from "./login-form";

export default function LoginPage() {
  return (
    <main className="flex min-h-screen items-center justify-center bg-slate-100 px-6">
      <div className="w-full max-w-md rounded-2xl border border-slate-200 bg-white p-8 shadow-sm">
        <div className="mb-8">
          <div className="mb-4 inline-flex h-11 w-11 items-center justify-center rounded-xl bg-slate-900 text-lg font-semibold text-white">
            C
          </div>
          <h1 className="text-2xl font-semibold tracking-tight text-slate-900">
            CRM Sign in
          </h1>
          <p className="mt-2 text-sm text-slate-500">
            Sign in with your organisation account to continue.
          </p>
        </div>

        <LoginForm />
      </div>
    </main>
  );
}
