export default function DashboardPage() {
  return (
    <div>
      <h1 className="text-3xl font-semibold tracking-tight text-slate-900">
        Dashboard
      </h1>
      <p className="mt-2 text-slate-500">
        CRM foundation is ready. Data screens will be added in the next stage.
      </p>

      <div className="mt-8 grid gap-5 md:grid-cols-2 xl:grid-cols-4">
        {["Individuals", "Companies", "Interactions", "Tasks"].map((label) => (
          <div
            key={label}
            className="rounded-xl border border-slate-200 bg-white p-5 shadow-sm"
          >
            <div className="text-sm font-medium text-slate-500">{label}</div>
            <div className="mt-3 text-3xl font-semibold text-slate-900">—</div>
          </div>
        ))}
      </div>
    </div>
  );
}
