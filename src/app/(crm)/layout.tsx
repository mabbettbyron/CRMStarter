import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";

const navigation = [
  { href: "/dashboard", label: "Dashboard" },
  { href: "/individuals", label: "Individuals" },
  { href: "/companies", label: "Companies" },
  { href: "/interactions", label: "Interactions" },
  { href: "/tasks", label: "Tasks" },
];

export default async function CrmLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const { data } = await supabase.auth.getClaims();

  if (!data?.claims) {
    redirect("/login");
  }

  return (
    <div className="min-h-screen bg-slate-100">
      <aside className="fixed inset-y-0 left-0 w-64 border-r border-slate-200 bg-slate-950 px-4 py-6 text-white">
        <div className="px-3">
          <div className="text-xl font-semibold">CRM</div>
          <div className="mt-1 text-xs text-slate-400">Customer relationships</div>
        </div>

        <nav className="mt-8 space-y-1">
          {navigation.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="block rounded-lg px-3 py-2.5 text-sm text-slate-300 transition hover:bg-slate-800 hover:text-white"
            >
              {item.label}
            </Link>
          ))}
        </nav>
      </aside>

      <div className="ml-64 min-h-screen">
        <header className="flex h-16 items-center border-b border-slate-200 bg-white px-8">
          <div className="text-sm text-slate-500">CRM</div>
        </header>
        <main className="p-8">{children}</main>
      </div>
    </div>
  );
}
