<!-- copilot-builder:start -->
# AGENTS.md — EnterpriseProject

Univerzální instrukce pro AI coding agenty (Copilot, Codex, Cursor, Claude Code, Gemini CLI, Aider).
Soubor leží v kořeni repozitáře; agent použije nejbližší `AGENTS.md` v adresářovém stromu.

## Přehled projektu
* **Architektura:** Standardní (jedna aplikace) — Monolit (jedna aplikace)
* **Cílové platformy:** neuvedeno
* **Frontend:** neuvedeno + Tailwind CSS + Shadcn/UI
* **Backend:** Next.js API Routes / Server Actions
* **Databáze:** Neon (serverless Postgres, vlastní Auth)
* **Doména:** Portfolio / Prezentační web
* **Nasazení:** Vercel (BaaS + Edge)

## Příkazy
- Instalace závislostí: `npm install`
- Vývojový server: `npm run dev`
- Produkční build: `npm run build`
- Testy: `npm test`
- Lint a formát: `npm run lint`
- Typová kontrola: `npm run typecheck`

> Ověř názvy skriptů ve `package.json` a tento seznam uprav podle skutečnosti.

## Konvence kódu
- Striktní typy, žádné `any`.
- Validuj vstup na serveru, nikdy nedůvěřuj klientu.
- Texty nepatří do komponent, ale do i18n slovníků.
- Nikdy necommituj tajemství ani soubory `.env`.
- Nové chování vždy doplň testem.

## Kde jsou instrukce
* `.github/copilot-instructions.md` — plný kontext projektu (vždy aktivní pro Copilot)
* `AGENTS.md` — tento soubor, společný pro všechny agenty
<!-- copilot-builder:end -->
