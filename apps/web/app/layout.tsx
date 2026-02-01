import "./globals.css";

export const metadata = {
  title: "MetaNetOps Console",
  description: "NPE Lab Console deployed on Vercel",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
