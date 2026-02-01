export default function Home() {
  return (
    <main style={{ fontFamily: "system-ui", padding: 24, maxWidth: 900, margin: "0 auto" }}>
      <h1>MetaNetOps Console</h1>
      <p>Deployed on Vercel. Repo runbooks + NPE lab docs live here.</p>
      <ul>
        <li><a href="/api/health">/api/health</a></li>
      </ul>
      <p style={{ opacity: 0.7 }}>
        Next step: add Runbooks browser + “Demo Triage” UI + Run History (stored client-side or via external API).
      </p>
    </main>
  );
}
