import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Shift Management System",
  description: "Employee shift management and scheduling system",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.Node;
}>) {
  return (
    <html lang="tr">
      <body>
        {children}
      </body>
    </html>
  );
}
