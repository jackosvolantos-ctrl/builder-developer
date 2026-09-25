<#
.SYNOPSIS
  TypeScript Master Architect Generator pro Copilot Workspace
  Verze 4.0 - Emerald Dark Theme (podle reference)
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# ==========================================
# BAREVNÁ PALETA (Emerald Dark Theme)
# ==========================================
$script:colors = @{
    Background      = [System.Drawing.Color]::FromArgb(10, 10, 10)      # #0A0A0A
    Surface         = [System.Drawing.Color]::FromArgb(19, 19, 19)      # #131313
    SurfaceHover    = [System.Drawing.Color]::FromArgb(26, 26, 26)      # #1A1A1A
    Border          = [System.Drawing.Color]::FromArgb(31, 31, 31)      # #1F1F1F
    BorderStrong    = [System.Drawing.Color]::FromArgb(58, 58, 58)      # #3A3A3A
    TitleBar        = [System.Drawing.Color]::FromArgb(0, 0, 0)         # #000000
    TextPrimary     = [System.Drawing.Color]::FromArgb(245, 245, 245)   # #F5F5F5
    TextSecondary   = [System.Drawing.Color]::FromArgb(160, 160, 160)   # #A0A0A0
    TextMuted       = [System.Drawing.Color]::FromArgb(107, 114, 128)   # #6B7280
    Emerald         = [System.Drawing.Color]::FromArgb(0, 229, 160)     # #00E5A0
    EmeraldDark     = [System.Drawing.Color]::FromArgb(0, 200, 138)     # #00C88A
    EmeraldLight    = [System.Drawing.Color]::FromArgb(31, 255, 184)    # #1FFFB8
    EmeraldGlow     = [System.Drawing.Color]::FromArgb(15, 40, 32)      # glow bg
    Black           = [System.Drawing.Color]::FromArgb(0, 0, 0)
}

# --- Tooltip (tmavý styl) ---
$script:tooltip = New-Object System.Windows.Forms.ToolTip
$script:tooltip.AutoPopDelay = 30000
$script:tooltip.InitialDelay = 350
$script:tooltip.ReshowDelay = 100
$script:tooltip.ShowAlways = $true
$script:tooltip.IsBalloon = $false
$script:tooltip.BackColor = $script:colors.Surface
$script:tooltip.ForeColor = $script:colors.TextPrimary
$script:tooltip.OwnerDraw = $false

# --- Slovník nápovědy ---
$script:helpText = @{
    "Standardní (jedna aplikace)" = "Jedna Next.js/Vue aplikace v rootu. Nejjednodušší pro malé projekty a MVP."
    "pnpm workspaces + apps/ (monorepo)" = "Monorepo s pnpm. Web + admin + mobil v samostatných složkách apps/. Sdílené balíčky v packages/."
    "Turborepo (pnpm workspaces)" = "Monorepo s Turborepem pro cachované buildy. Vhodné pro větší týmy, které chtějí rychlé CI."
    "Modulární monolit (čisté hranice)" = "Jeden deploy, ale moduly s vlastními hranicemi (features/ složky). Umožňuje budoucí extrakci do služeb."
    "Hybridní (monolit + extrahované služby)" = "Jádro v monolitu, výpočetně náročné části (např. AI, video) jako samostatné služby."
    "Monorepo s Nx" = "Nx workspace s generátory a pokročilou grafu závislostí. Pro enterprise týmy."
    "SSR (Server-Side Rendering)" = "HTML generováno na serveru pro každý request. Nejlepší SEO, vždy fresh data, ale pomalejší TTFB."
    "SPA (Single Page App)" = "Vše běží v prohlížeči. Rychlé interakce, ale horší SEO a pomalejší první načtení."
    "SSG (Static Site Generation)" = "HTML generováno při buildu. Nejrychlejší a nejlevnější, ale obsah je statický."
    "ISR (Incremental Static Regeneration)" = "Statické stránky s automatickou revalidací na pozadí."
    "PPR (Partial Prerendering)" = "Next.js 15+ funkce - statická skořápka + streamované dynamické části."
    "Hybridní per-route (routeRules)" = "Různé strategie pro různé routy (např. homepage SSG, dashboard SSR)."
    "Moderní & Minimalistický (Shadcn styl)" = "Čistý design s hodně bílým prostorem, jemné hranice."
    "Enterprise (Korporátní data)" = "Husté tabulky, filtry, grafy. Datově orientovaný design."
    "Dark Mode orientovaný" = "Tmavý režim jako výchozí. Vhodné pro dev nástroje."
    "Hravý / Barevný" = "Výrazné barvy, zaoblené rohy, animace."
    "Material Design 3" = "Google Material You s dynamickými barvami."
    "Glassmorphism / Neumorphism" = "Moderní trendy - sklo nebo měkké 3D stíny."
    "Monolit (jedna aplikace)" = "Vše v jedné codebase. Nejjednodušší na vývoj a deploy."
    "Modulární monolit (moduly s vlastními hranicemi)" = "Jeden deploy, ale jasně oddělené moduly."
    "Mikroservisy (nezávislé služby)" = "Každá služba samostatně nasaditelná."
    "Serverless / Edge funkce" = "Funkce běží per-request, škálují automaticky."
    "Hybridní (modulární monolit + extrahované služby)" = "Základ v monolitu, kritické části extrahované."
    "Pouze web (desktop + mobil)" = "Responzivní web bez admin sekce."
    "Web + Administrace" = "Veřejný web + chráněná admin sekce."
    "Web + Administrace + Mobilní aplikace" = "Full-stack: web, admin, nativní mobil."
    "Web + Mobilní aplikace (bez adminu)" = "Web bez admin sekce + nativní mobil."
    "PWA (Progressive Web App)" = "Web instalovatelný na plochu, offline podpora."
    "Next.js (App Router)" = "React framework od Vercelu. RSC, Server Actions, streaming."
    "React + Vite" = "Čistý React bez frameworku. Rychlý dev server."
    "Vue 3 + Vite" = "Vue s Composition API. Lehčí než React."
    "Nuxt 3/4" = "Vue framework podobný Next.js."
    "SvelteKit" = "Svelte framework s nejmenším bundle."
    "Astro (Islands Architecture)" = "Content-first framework. Statické HTML + interaktivní ostrovy."
    "Angular 22" = "Enterprise framework od Googlu."
    "React Router v8 (framework mode)" = "React Router jako plnohodnotný framework."
    "Tailwind CSS + Shadcn/UI" = "Utility-first CSS + kopírovatelné komponenty."
    "Tailwind CSS (čistý)" = "Jen Tailwind bez komponentové knihovny."
    "MUI" = "Material Design komponenty pro React."
    "Mantine / Chakra UI" = "Moderní komponentové knihovny."
    "CSS Modules + Vanilla Extract" = "Lokální CSS s typovou bezpečností."
    "Panda CSS" = "CSS-in-JS s build-time kompilací."
    "Bez i18n (jednojazyčná aplikace)" = "Žádná podpora více jazyků."
    "next-intl (Next.js App Router)" = "Nejlepší i18n pro Next.js App Router."
    "next-i18next / i18next" = "Zavedená knihovna s bohatým ekosystémem."
    "Vlastní JSON slovník" = "Ruční správa překladů v JSON souborech."
    "Vue I18n / SvelteKit i18n" = "Nativní i18n řešení pro Vue/Svelte."
    "Zustand / Pinia" = "Lehký state management."
    "Redux Toolkit" = "Zavedený Redux s menším boilerplate."
    "Context API" = "Nativní React Context."
    "Bez globálního stavu" = "Stav pouze lokální."
    "React Hook Form + Zod" = "Nejlepší kombinace pro React formuláře."
    "VeeValidate + Zod" = "Ekvivalent pro Vue."
    "Server Actions (Nativní)" = "Formuláře odesílané přímo na server."
    "Čistý state" = "Ruční správa formulářů."
    "Žádná (minimalistické)" = "Bez animací. Nejrychlejší, nejpřístupnější."
    "Framer Motion" = "Nejpopulárnější React animační knihovna."
    "GSAP" = "Profesionální animace, timeline, scroll triggers."
    "CSS Animations (nativní)" = "Čisté CSS keyframes."
    "Auto-Animate" = "Automatické animace při změně DOM."
    "Next.js API Routes / Server Actions" = "Backend přímo v Next.js."
    "Oddělený Node.js (Express / NestJS)" = "Samostatný Node.js server."
    "Hono" = "Ultra-lehký web framework."
    "BaaS (Supabase / Firebase)" = "Backend jako služba."
    "Go (Gin / Echo / Fiber)" = "Kompilovaný jazyk. Rychlý, nízká spotřeba paměti."
    "Python (FastAPI / Django)" = "AI/ML ekosystém, rychlý prototyping."
    "Rust (Axum / Actix)" = "Maximální výkon a bezpečnost paměti."
    "Edge Functions (Cloudflare Workers)" = "Kód běží na edge (blízko uživatele)."
    "Neon (serverless Postgres, vlastní Auth)" = "Serverless Postgres s databázovými větvemi."
    "Supabase (kompletní backend: DB + Auth + Storage)" = "Open-source Firebase alternativa."
    "Neon (preview DB) + Supabase (produkční backend)" = "Preview na Neon branches, produkce na Supabase."
    "PlanetScale (MySQL)" = "Serverless MySQL s databázovými větvemi."
    "Turso (SQLite edge)" = "SQLite replikované na edge."
    "Vlastní PostgreSQL (VPS)" = "Plná kontrola, ale musíš řešit zálohy sám."
    "Nativní integrace Neon (auto ENV inject)" = "Vercel automaticky injektuje connection stringy."
    "Supabase Marketplace (one-click)" = "Připojení Supabase přes Vercel Marketplace."
    "Manuální správa ENV" = "Ruční nastavení ENV proměnných."
    "Nepoužívám Vercel" = "Jiný hosting."
    "Prisma" = "Nejpopulárnější ORM pro TS."
    "Drizzle ORM" = "Lehčí, SQL-first ORM."
    "Mongoose" = "ODM pro MongoDB."
    "Supabase Client" = "Přímý přístup k Supabase z frontendu."
    "Kysely (typovaný SQL builder)" = "Type-safe SQL builder bez ORM magic."
    "Raw SQL + prepared statements" = "Přímé SQL dotazy."
    "TanStack Query" = "Server state management."
    "SWR" = "Lehčí alternativa k TanStack Query."
    "tRPC" = "End-to-end type-safe API."
    "Nativní fetch()" = "Přímé HTTP volání."
    "GraphQL (Apollo / urql)" = "Deklarativní dotazy, jeden endpoint."
    "Server Actions + useOptimistic" = "Next.js Server Actions s optimistickým UI."
    "Žádná (REST only)" = "Pouze request-response."
    "WebSockets (Socket.io / nativní)" = "Plně duplexní spojení."
    "Server-Sent Events (SSE)" = "Jednosměrný stream server → klient."
    "GraphQL Subscriptions" = "Live data přes GraphQL."
    "Supabase Realtime / Firebase" = "Managed realtime."
    "Neon serverless driver (HTTP, žádný pool)" = "HTTP-based driver."
    "Supabase Supavisor (transaction mode)" = "Connection pooler pro serverless."
    "Prisma Accelerate" = "Managed connection pool + cache."
    "Vlastní konfigurace poolu" = "Ruční nastavení pg.Pool."
    "Nepotřebné (trvalé připojení)" = "Pro trvale běžící server."
    "Žádná (fresh data)" = "Vždy fresh data z DB/API."
    "Vercel KV / Upstash Redis" = "Managed Redis pro cache, rate limiting."
    "Next.js unstable_cache / Data Cache" = "Nativní Next.js cache."
    "React Query cache (client-side)" = "Cache na klientu."
    "CDN + ISR kombinace" = "Statické stránky na CDN."
    "REST + OpenAPI spec" = "REST API s OpenAPI dokumentací."
    "REST + Zod validace" = "REST s runtime validací."
    "GraphQL (Cursor Connections)" = "GraphQL s Relay-style pagination."
    "tRPC (end-to-end typesafe)" = "Bez REST/GraphQL."
    "Vercel (BaaS + Edge)" = "Nejlepší DX pro Next.js."
    "Netlify" = "Alternativa k Vercelu."
    "Docker Container (VPS/AWS)" = "Kontejnerizovaná aplikace."
    "Container PaaS (Fly.io / Render)" = "Managed Docker hosting."
    "VM Compose (DigitalOcean / GCP)" = "Docker Compose na VPS."
    "AWS ECS / Fargate (Enterprise)" = "Enterprise kontejnerová platforma."
    "Coolify (self-hosted PaaS)" = "Open-source alternativa k Vercelu."
    "ESLint" = "Statická analýza JS/TS."
    "Prettier" = "Automatický formátovač kódu."
    "Biome" = "All-in-one nástroj (lint + format)."
    "Striktní TS (no implicit any)" = "Přísný režim TypeScriptu."
    "Knip (detekce nepoužívaného kódu)" = "Najde nepoužívané soubory, exporty."
    "Husky + lint-staged (pre-commit)" = "Spouští lint/formát před commitem."
    "Commitlint (konvence commitů)" = "Vynutí konvenci commit zpráv."
    "Vitest" = "Rychlý unit test runner."
    "Playwright (E2E)" = "End-to-end testy v prohlížeči."
    "Jest" = "Zavedený test runner."
    "Testing Library (React/Vue)" = "Testování z pohledu uživatele."
    "MSW (Mock Service Worker)" = "Mock API na úrovni sítě."
    "k6 / Artillery (load testing)" = "Zátěžové testy."
    "GitHub Actions" = "CI/CD přímo v GitHubu."
    "Build APK (Android)" = "Automatický build Android APK."
    "Build IPA (iOS)" = "Automatický build iOS IPA."
    "Automatické testy na PR" = "Spustí testy při každém pull requestu."
    "Preview deployment (Vercel)" = "Každý PR dostane vlastní URL."
    "Databázové migrace v CI" = "Migrace se aplikují automaticky."
    "Semantic Release (auto-versioning)" = "Automatické verzování podle commit zpráv."
    "Preview Deployment na PR" = "Každý PR má vlastní URL."
    "Edge Functions" = "Funkce běží na edge."
    "Vercel Blob (soubory)" = "Managed object storage."
    "Vercel KV (cache)" = "Managed Redis."
    "Vercel Postgres (Neon)" = "Postgres od Neonu."
    "Concurrent Builds" = "Více buildů paralelně."
    "Cron Jobs" = "Plánované úlohy."
    "Žádné (manuální správa)" = "Infrastruktura se nastavuje ručně."
    "Terraform" = "Declarative IaC."
    "Pulumi" = "IaC v TypeScriptu."
    "AWS CDK" = "AWS infrastruktura v TypeScriptu."
    "Vercel CLI + vercel.json" = "Konfigurace Vercelu přes vercel.json."
    "Vlastní JWT + bearer tokeny" = "Vlastní auth s JWT."
    "NextAuth v5 / Auth.js" = "Standardní auth pro Next.js."
    "Clerk (hosted)" = "Hosted auth s hotovým UI."
    "Lucia (self-hosted)" = "Self-hosted auth bez závislostí."
    "Supabase Auth" = "Auth od Supabase."
    "Kombinace (web: NextAuth, mobil: bearer)" = "NextAuth pro web, bearer pro mobil."
    "RBAC (Admin/User/Moderator)" = "Role-based access control."
    "OAuth (Google, GitHub)" = "Přihlášení přes třetí strany."
    "Magic Links (bez hesla)" = "Přihlášení přes email odkaz."
    "2FA / TOTP" = "Dvoufázové ověření."
    "Session management" = "Správa aktivních sessions."
    "Refresh tokeny" = "Long-lived token."
    "Device tracking" = "Evidence přihlášených zařízení."
    "T3 Env (Validace .env přes Zod)" = "Typová validace environment proměnných."
    "Rate Limiting" = "Omezení počtu requestů."
    "Helmet hlavičky" = "Bezpečnostní HTTP hlavičky."
    "CORS konfigurace" = "Kontrola, které domény mohou volat API."
    "CSRF ochrana (SameSite)" = "Ochrana proti cross-site request forgery."
    "Content Security Policy (CSP)" = "Whitelist zdrojů."
    "Audit log (historie změn)" = "Immutable záznam operací."
    "Password hashing (argon2/bcrypt)" = "Bezpečné hashování hesel."
    "Vercel Analytics" = "Nativní analytics Vercelu."
    "Vercel Speed Insights" = "Core Web Vitals."
    "Google Analytics 4" = "Komplexní analytics od Googlu."
    "Sentry (chyby)" = "Sledování chyb."
    "PostHog (product analytics)" = "Open-source alternativa Amplitude."
    "OpenTelemetry (tracing)" = "Vendor-neutral distributed tracing."
    "Pino (JSON logy)" = "Nejrychlejší logger pro Node.js."
    "Winston" = "Zavedený logger."
    "Grafana / Prometheus (metriky)" = "Časové řady metrik."
    "Axiom / Logtail (aggregation)" = "Centrální sběr logů."
    "Datadog" = "Enterprise observability."
    "Loki" = "Grafana Loki pro logy."
    "GDPR (cookie consent, RLS)" = "Soulad s GDPR."
    "Audit trail (kdo co změnil)" = "Kdo, kdy, co změnil."
    "Data retention policy" = "Automatické mazání starých dat."
    "Backup & disaster recovery" = "Pravidelné zálohy + plán obnovy."
    "SOC2 ready" = "Připraveno pro SOC2 audit."
    "AI cost tracking" = "Sledování nákladů na LLM volání."
    "Vlastní DB + Administrace" = "Vlastní admin sekce s CRUD."
    "Lokální soubory (MDX / Markdown)" = "Obsah v .mdx souborech."
    "Headless CMS (Sanity / Strapi / Payload)" = "Oddělené CMS."
    "JSON Slovníky (i18n pro UI texty)" = "Texty v JSON souborech."
    "Git-based CMS (TinaCMS / Decap)" = "CMS ukládá obsah do gitu."
    "Hardcoded (neřešit)" = "Texty přímo v kódu."
    "TipTap (headless, vlastní UI)" = "Headless WYSIWYG editor."
    "Lexical (Meta)" = "Editor od Meta."
    "Slate.js" = "Framework pro vlastní editory."
    "Quill" = "Zavedený WYSIWYG editor."
    "Žádný (pouze MDX)" = "Bez WYSIWYG editoru."
    "Vlastní admin-kit (custom)" = "Vlastní admin komponenty."
    "Refine.dev" = "React framework pro admin panely."
    "React Admin" = "Zavedený admin framework."
    "AdminJS" = "Auto-generovaný admin z DB schématu."
    "Payload CMS (admin v ceně)" = "Headless CMS s admin panelem."
    "Nativní (Next.js metadata / Nuxt useHead)" = "Vestavěné API frameworku."
    "Unhead (deduplikace + async aware)" = "Deduplikuje meta tagy."
    "next-seo / vue-seo" = "Komponenta pro SEO tagy."
    "Ruční správa (vlastní komponenta)" = "Vlastní komponenta pro head."
    "Dashboard (Statistiky, grafy)" = "Přehledová stránka s grafy."
    "Správa uživatelů (Tabulky)" = "CRUD nad uživateli."
    "Auditní Log (Historie změn)" = "Kdo co kdy změnil."
    "Import/Export dat (CSV/Excel)" = "Hromadný import/export."
    "Feature flags (LaunchDarkly / vlastní)" = "Zapínání funkcí bez deploy."
    "Upload souborů (S3/Supabase/Blob)" = "Nahrávání souborů do object storage."
    "Platby (Stripe)" = "Platební brána Stripe."
    "E-maily (Resend / Postmark)" = "Transakční e-maily."
    "PDF generování" = "Generování PDF."
    "Notifikace (push/email/SMS)" = "Multi-channel notifikace."
    "Full-text vyhledávání (Meilisearch)" = "Rychlé fulltextové vyhledávání."
    "Vercel AI SDK" = "SDK od Vercelu pro AI streaming."
    "OpenAI API" = "GPT-4, GPT-4o, o1."
    "Anthropic Claude API" = "Claude 3.5 Sonnet/Opus."
    "RAG (Vektorová databáze)" = "Retrieval-Augmented Generation."
    "Ollama (lokální modely)" = "Lokální LLM."
    "LangChain / LangGraph" = "Framework pro AI agenty."
    "MCP Server (Model Context Protocol)" = "Standard pro připojení AI k nástrojům."
    "Žádné" = "Bez A/B testování."
    "PostHog (feature flags + experiments)" = "A/B testy + feature flags."
    "GrowthBook (self-hosted)" = "Self-hosted A/B platforma."
    "Statsig" = "Moderní A/B platforma."
    "Vlastní (DB + middleware)" = "Vlastní A/B test."
    "Žádná (pouze web)" = "Bez mobilní aplikace."
    "React Native + Expo (SDK 57+)" = "Doporučená kombinace."
    "React Native (bare, bez Expo)" = "Čistý React Native."
    "Flutter" = "Dart framework od Googlu."
    "Capacitor (web → nativní)" = "Zabalí web do nativního shellu."
    "Offline drafty (AsyncStorage)" = "Ukládání neuložených dat."
    "SecureStore pro tokeny" = "Šifrované úložiště pro tokeny."
    "Push notifikace (Expo Notifications)" = "Push notifikace přes Expo."
    "Sdílené API s webem" = "Stejné API endpointy pro web i mobil."
    "Dark/Light/System téma" = "Podpora světlého/tmavého/systémového tématu."
    "Biometrické přihlášení" = "Face ID, Touch ID, fingerprint."
    "Deep linking" = "Otevření konkrétní obrazovky přes odkaz."
    "Photo picker / Camera" = "Přístup k fotoaparátu a galerii."
    "Expo EAS Build (cloud)" = "Cloud build v Expo."
    "GitHub Actions + prebuild (APK)" = "Build APK v GitHub Actions."
    "App Store / Google Play" = "Veřejná distribuce."
    "Interní distribuce (Firebase)" = "Interní testování."
    "Expo Router (file-based)" = "Routing podle souborové struktury."
    "React Navigation" = "Zavedený navigation library."
    "Vlastní stack" = "Vlastní navigační logika."
    "Tabs + Stack kombinace" = "Taby + stack pro vnořené obrazovky."
    "React Native Paper" = "Material Design komponenty."
    "NativeBase" = "Komponenty s přístupností."
    "Tamagui" = "Výkonné UI pro RN + web."
    "Vlastní komponenty" = "Vlastní design systém."
    "Gluestack UI" = "Utility-first UI komponenty."
    "Zustand + TanStack Query" = "Zustand + TanStack Query."
    "Redux Toolkit + RTK Query" = "Redux + RTK Query."
    "Jotai + SWR" = "Atomický state + SWR."
    "Context + vlastní fetch" = "Nativní React Context + fetch."
    "Bearer tokeny (vlastní JWT)" = "Vlastní JWT v Authorization hlavičce."
    "Expo AuthSession (OAuth)" = "OAuth flow přes Expo."
    "Supabase Auth (shared)" = "Sdílená auth se Supabase."
    "Biometrické + PIN" = "Biometrika jako primární, PIN fallback."
    "Obecná / Univerzální" = "Nespecifikovaná doména."
    "E-shop / E-commerce" = "Prodej produktů. Aktivují se e-commerce pravidla."
    "Rezervační systém (salon, lékař, restaurace)" = "Booking systém."
    "SaaS platforma" = "Multi-tenant aplikace s předplatným."
    "LMS (Learning Management System)" = "Vzdělávací platforma."
    "Sociální síť / Komunita" = "Uživatelé generovaný obsah."
    "Blog / Magazín / Média" = "Obsahový web."
    "Marketplace (více prodejců)" = "Multi-vendor e-shop."
    "CRM / Interní nástroj" = "Interní aplikace pro tým."
    "Portfolio / Prezentační web" = "Osobní nebo firemní prezentace."
    "Booking + platby (kombinace)" = "Rezervace s online platbou."
    "Product catalog (varianty, SKU)" = "Katalog produktů s variantami."
    "Košík + checkout flow" = "Nákupní košík s persistencí."
    "Platební brána (Stripe / GoPay)" = "Integrace platební brány."
    "Doprava (Packeta / DPD / PPL)" = "Výběr dopravce s cenou a tracking."
    "Skladové hospodářství" = "Evidence skladu."
    "Fakturace (Fakturoid / iDoklad)" = "Automatické generování faktur."
    "Slevové kódy a akce" = "Kupóny, slevy, sezónní akce."
    "Recenze produktů" = "Hodnocení od zákazníků."
    "Wishlist / oblíbené" = "Uložení produktů na později."
    "Porovnání produktů" = "Srovnání parametrů."
    "Doporučovací engine" = "Personalizovaná doporučení."
    "Abandoned cart recovery" = "E-maily zákazníkům, kteří opustili košík."
    "Kalendář s časovými sloty" = "Výběr termínu a času."
    "Správa zaměstnanců / specialistů" = "Přiřazení rezervací konkrétním osobám."
    "Rezervace + platba (deposit)" = "Vyžádání zálohy při rezervaci."
    "Přesuny a storna" = "Změna termínu a zrušení."
    "SMS / Email reminder" = "Připomínky před termínem."
    "Google Calendar sync" = "Synchronizace s Google Kalendářem."
    "Opakované rezervace" = "Pravidelné termíny."
    "Waitlist (fronta čekajících)" = "Automatické uvolnění místa při stornu."
    "Dárkové vouchery" = "Prodej a uplatnění dárkových poukazů."
    "Věrnostní program" = "Body, slevy pro věrné zákazníky."
    "Multi-tenant architektura" = "Jeden deploy, izolovaná data."
    "Subscription billing (Stripe Billing)" = "Pravidelné platby."
    "Plány + feature gating" = "Různé úrovně služeb."
    "Trial + upgrade/downgrade" = "Zkušební období + změna plánu."
    "Usage-based billing" = "Platba podle spotřeby."
    "Invoice generování" = "Automatické měsíční faktury."
    "Dunning management" = "Retry logika při selhání platby."
    "Team / organizace" = "Skupiny uživatelů."
    "Invite systém" = "Pozvánky do týmu emailem."
    "RBAC per tenant" = "Role definované pro každý tenant."
    "White-label možnost" = "Vlastní branding."
    "Kurzy + lekce" = "Struktura kurzů s lekcemi."
    "Video streaming (Mux / Cloudflare)" = "Video hosting se signed URLs."
    "Kvízy a testy" = "Znalostní testy."
    "Certifikáty (PDF generování)" = "Generování PDF certifikátů."
    "Progress tracking" = "Sledování pokroku studenta."
    "Diskusní fórum" = "Diskuse pod lekcemi."
    "Live sessions (Zoom / Daily.co)" = "Živé lekce."
    "Předplatné kurzu" = "Přístup ke všem kurzům."
    "Drip content" = "Postupné odemykání obsahu."
    "Kontakty + firmy" = "Evidence kontaktů a firem."
    "Pipeline / deals" = "Kanban board pro deals."
    "Úkoly a aktivity" = "Task management."
    "Reporty a dashboardy" = "Analytika prodeje."
    "Import/Export dat" = "Hromadný import/export kontaktů."
    "Email sekvence" = "Automatické follow-up e-maily."
    "Lead scoring" = "Automatické hodnocení leadů."
    "Ticket systém" = "Zákaznická podpora."
    "Platby: Stripe" = "Globální platební brána."
    "Platby: GoPay" = "Česká platební brána."
    "Platby: PayPal" = "Globální. Pro zákazníky bez karty."
    "Doprava: Packeta / Zásilkovna" = "Výdejní místa + kurýr."
    "Doprava: DPD / PPL" = "Kurýrní služby."
    "Fakturace: Fakturoid" = "Automatická fakturace."
    "Fakturace: iDoklad" = "Alternativa k Fakturoidu."
    "Email: Resend / Postmark" = "Transakční e-maily."
    "SMS: Twilio / SMS.cz" = "SMS notifikace."
    "Účetnictví: Pohoda / Money S3" = "Export dat do účetních systémů."
    "Marketing: Mailchimp / Klaviyo" = "E-mail marketing."
    "Analytics: GA4 / Meta Pixel" = "Sledování konverzí."
    "Newsletter" = "Odběr novinek emailem."
    "Blog s MDX" = "Blog s MDX soubory."
    "Landing pages builder" = "Vlastní builder pro landing pages."
    "Referral systém" = "Odměny za doporučení."
    "Affiliate program" = "Partnerský program s provizemi."
    "Structured data (JSON-LD)" = "Schema.org data."
    "Open Graph optimalizace" = "Náhledy při sdílení."
    "Sitemap + robots.txt" = "Automaticky generovaná sitemap."
    "RSS feed" = "RSS kanál."
    "Push notifikace (web)" = "Web push notifikace."
    "GDPR (souhlasy, výmaz)" = "Cookie consent, právo na výmaz."
    "Obchodní podmínky" = "Verzované OP."
    "Cookies consent (Cookiebot)" = "Správa souhlasů s cookies."
    "Reklamační systém" = "Stavový automat pro reklamace."
    "14 dní na vrácení (spotřebitel)" = "Zákonné právo na vrácení."
    "Ochrana osobních údajů" = "Evidence zpracování OÚ."
    "Autorská práva a licence" = "Potvrzení o vlastnictví."
    "VAT / DPH kalkulace" = "DPH, reverse charge, OSS."
    "Nikdy neinstalujte nedeklarované závislosti" = "Zabraň agentovi tiše přidávat npm/pip/atd. balíčky, které nejsou v manifestu."
    "Spusťte testovací sadu" = "Před odevzdáním změn spusť celou (nebo relevantní) testovací sadu."
    "Spusťte linter a formátovač" = "Automaticky spusť lint/formátovací nástroje před dokončením úlohy."
    "Kontrola typů" = "Spusť typovou kontrolu (tsc/mypy/atd.) a oprav nahlášené chyby."
    "Replikujte CI kontroly lokálně" = "Před odevzdáním ověř stejné kroky, jaké spouští CI pipeline."
    "Dodržujte stávající strukturu" = "Neprováděj reorganizaci složek/architektury bez explicitního zadání."
    "Společné umístění testů" = "Umísťuj nové testy podle stávající konvence (vedle kódu nebo v tests/)."
    "Vyhněte se novým závislostem" = "Preferuj existující knihovny před přidáváním nových balíčků."
    "Respektujte konfigurační soubory" = "Dodržuj nastavení v tsconfig, eslint, .editorconfig a pyproject."
    "Preferujte konst" = "Používej const/immutable proměnné, kde je to možné, místo let/var."
    "Předsazené výrazy (early returns)" = "Používej early return a vyhýbej se hlubokému zanoření podmínek."
    "Popisné pojmenování" = "Volí jednoznačné, popisné názvy proměnných a funkcí."
    "Malé funkce" = "Udržuj funkce krátké a zaměřené na jednu odpovědnost."
    "Autodokumentační kód" = "Piš samovysvětlující kód; komentáře jen pro vysvětlení 'proč', ne 'co'."
    "Pokrytí pro nové kódy" = "Ke každé nové/změněné funkcionalitě přidej odpovídající testy."
    "Jednotkové testy" = "Pokrývej novou logiku jednotkovými testy."
    "Okrajové případy" = "Testuj i hraniční a chybové stavy, ne jen 'happy path'."
    "Testovací názvy" = "Používej popisné názvy testů vysvětlující očekávané chování."
    "AAA vzor" = "Strukturuj testy podle vzoru Arrange-Act-Assert."
    "JSDoc/Docstringy" = "Dokumentuj veřejné funkce/třídy pomocí JSDoc nebo docstringů."
    "Aktualizace README" = "Aktualizuj README při přidání nové funkce nebo změně chování."
    "Složitá logika" = "Přidej inline komentáře u netriviálních algoritmů."
    "Dokumentace API" = "Dokumentuj API endpointy, request/response tvary a chybové kódy."
    "Ověřujte vstupy" = "Validuj a sanitizuj veškerý uživatelský vstup na serveru."
    "Žádná tvrdá tajemství" = "Nikdy nevkládej API klíče/hesla/tokeny do kódu; používej ENV proměnné."
    "Parametrizované dotazy" = "Používej parametrizované dotazy/ORM, nikdy string-konkatenaci SQL."
    "Prevence XSS" = "Escapuj/sanitizuj výstupy do HTML, aby ses vyhnul XSS."
    "Sémantické HTML" = "Používej sémantické značky (nav, main, button) místo obecných div/span."
    "Alternativní text u obrázků" = "Ke každému obrázku doplň smysluplný alt text."
    "Navigace klávesnicí" = "Zajisti, že všechny interaktivní prvky jsou ovladatelné klávesnicí."
    "Štítky ARIA" = "Doplň ARIA atributy u vlastních/netriviálních UI komponent."
    "Lint pravidla pro výkon" = "Dodržuj výkonnostní lint pravidla (např. exhaustive-deps, no-unused-vars)."
    "Memoizace" = "Používej memoizaci (useMemo/useCallback apod.) u nákladných výpočtů a renderů."
    "Vyhněte se N+1 dotazům" = "Používej eager loading / JOIN místo N+1 dotazů do databáze."
    "Velikost svazku" = "Sleduj velikost výsledného JS bundlu, vyhýbej se zbytečným závislostem."
}

# ==========================================
# ROZŠÍŘENÉ NÁPOVĚDY
# Ke krátkému popisu se při startu připojí strukturovaný detail
# (Co to je / Kdy zvolit / Plus / Pozor), který se zobrazí v tooltipu
# i v záložce Slovník.
# ==========================================
$script:helpDetailSets = @()

# ---- Architektura: struktura repozitáře, rendering, design, typ, platformy ----
$script:helpDetailSets += @{
    'Standardní (jedna aplikace)' = @(
        'Co to je: Jeden projekt v kořeni repozitáře, jedna sada závislostí.'
        'Kdy zvolit: MVP, malý až střední web, prototyp, jednostranný projekt.'
        'Plus: Nejrychlejší setup, jednoduchý build i deploy, minimální režie.'
        'Pozor: Web + admin + mobil se hůř oddělují. Pozdější dělení na balíčky bolí.'
    ) -join "`n"
    'pnpm workspaces + apps/ (monorepo)' = @(
        'Co to je: Jeden repozitář, více aplikací ve apps/ a sdílené balíčky v packages/.'
        'Kdy zvolit: Máš web + admin + mobil, které sdílejí typy a UI komponenty.'
        'Plus: Sdílený kód a typy, jedna verze závislostí, atomické commity napříč aplikacemi.'
        'Pozor: Složitější CI, delší instalace, nutnost hlídat hranice mezi balíčky.'
    ) -join "`n"
    'Turborepo (pnpm workspaces)' = @(
        'Co to je: Monorepo s pnpm workspaces a Turborepem pro cachované a paralelní buildy.'
        'Kdy zvolit: Větší tým, hodně balíčků, pomalé CI, které chceš zrychlit.'
        'Plus: Remote cache, správné pořadí tasků podle grafu závislostí, méně zbytečné práce.'
        'Pozor: Vyšší vstupní složitost konfigurace, nutné pochopit pipeline a cache klíče.'
    ) -join "`n"
    'Modulární monolit (čisté hranice)' = @(
        'Co to je: Jeden deploy, ale moduly s vlastními hranicemi a veřejným rozhraním.'
        'Kdy zvolit: Doména už je složitá, ale nechceš řešit provoz více služeb.'
        'Plus: Umožňuje pozdější extrakci do služeb, dobrá testovatelnost hranic.'
        'Pozor: Hranice se musí vynucovat (lint, code review), jinak se rozpadnou.'
    ) -join "`n"
    'Hybridní (monolit + extrahované služby)' = @(
        'Co to je: Jádro běží v monolitu, výpočetně náročné části jako samostatné služby.'
        'Kdy zvolit: Web + AI, video, generování PDF nebo dávkové zpracování.'
        'Plus: Náročné části škáluješ zvlášť, jádro zůstává jednoduché.'
        'Pozor: Dvě infrastruktury, dva režimy nasazení, nutnost sledovat latenci mezi nimi.'
    ) -join "`n"
    'Monorepo s Nx' = @(
        'Co to je: Nx workspace s generátory, plugin ekosystémem a grafem závislostí.'
        'Kdy zvolit: Enterprise tým, mnoho týmů a aplikací, důraz na konvence a nástroje.'
        'Plus: Generátory, ovlivněné projekty (affected), silný graf i vizualizace.'
        'Pozor: Nejstrmější křivka učení, Nx si vynucuje vlastní způsob práce.'
    ) -join "`n"

    'SSR (Server-Side Rendering)' = @(
        'Co to je: HTML se generuje na serveru při každém požadavku.'
        'Kdy zvolit: Obsah se často mění, potřebuješ SEO a personalizaci.'
        'Plus: Vždy čerstvá data, nejlepší SEO, funkční i bez JavaScriptu.'
        'Pozor: Vyšší TTFB a zátěž serveru, dražší hosting, nutné řešit cache.'
    ) -join "`n"
    'SPA (Single Page App)' = @(
        'Co to je: Veškerý rendering probíhá v prohlížeči, server posílá jen data.'
        'Kdy zvolit: Interní nástroj, dashboard za přihlášením, bez potřeby SEO.'
        'Plus: Nejrychlejší interakce po načtení, jednoduché nasazení statických souborů.'
        'Pozor: Pomalé první načtení, slabé SEO, bez JavaScriptu se nezobrazí nic.'
    ) -join "`n"
    'SSG (Static Site Generation)' = @(
        'Co to je: HTML se vygeneruje při buildu a servíruje se jako statický soubor.'
        'Kdy zvolit: Blog, dokumentace, marketingový web, obsah měněný při deployi.'
        'Plus: Nejrychlejší odezva, nejnižší náklady, dá se hostovat i na CDN zdarma.'
        'Pozor: Obsah je statický, změna vyžaduje nový build a deploy.'
    ) -join "`n"
    'ISR (Incremental Static Regeneration)' = @(
        'Co to je: Statické stránky, které se na pozadí automaticky revalidují.'
        'Kdy zvolit: E-shop katalog, magazín, obsah měněný v řádu minut.'
        'Plus: Rychlost statického webu plus relativně čerstvá data.'
        'Pozor: Uživatel může krátce vidět starší verzi, nutné řešit invalidaci.'
    ) -join "`n"
    'PPR (Partial Prerendering)' = @(
        'Co to je: Next.js 15+ kombinuje statickou skořápku se streamovanými dynamickými částmi.'
        'Kdy zvolit: Stránky, kde většina obsahu je statická a jen malá část osobní.'
        'Plus: Okamžitá statická odezva a zároveň dynamická personalizace.'
        'Pozor: Experimentální funkce, složitější debugging a omezená podpora knihoven.'
    ) -join "`n"
    'Hybridní per-route (routeRules)' = @(
        'Co to je: Pro každou routu zvolíš jinou strategii (SSG, SSR, ISR, SPA).'
        'Kdy zvolit: Různé části aplikace mají různé nároky, například blog a dashboard.'
        'Plus: Optimální kompromis pro každou stránku zvlášť.'
        'Pozor: Vyšší mentální zátěž, snadno vzniknou nekonzistence.'
    ) -join "`n"

    'Moderní & Minimalistický (Shadcn styl)' = @(
        'Co to je: Čistý design s hodně prostorem, jemnými hranicemi a minimem barev.'
        'Kdy zvolit: SaaS, nástroje, marketing, cokoli kde má vyniknout obsah.'
        'Plus: Působí profesionálně a nadčasově, snadno se udržuje.'
        'Pozor: Bez výrazných akcentů se hůř zvýrazňují důležité akce, potřebuje dobrý spacing.'
    ) -join "`n"
    'Enterprise (Korporátní data)' = @(
        'Co to je: Husté tabulky, filtry, grafy a důraz na práci s daty.'
        'Kdy zvolit: CRM, ERP, admin panely, reporty pro interní týmy.'
        'Plus: Vysoká informační hustota, efektivní práce pro power usery.'
        'Pozor: Náročné na návrh, snadno přehlcené; začátečníci se hůř orientují.'
    ) -join "`n"
    'Dark Mode orientovaný' = @(
        'Co to je: Tmavý režim je výchozí, světlý je doplněk.'
        'Kdy zvolit: Dev nástroje, aplikace pro dlouhou práci, monitoring.'
        'Plus: Menší únava očí v tmavém prostředí, oblíbené u technických uživatelů.'
        'Pozor: Vyžaduje pečlivý kontrast, problém s tiskem a s přesluněnými displeji.'
    ) -join "`n"
    'Hravý / Barevný' = @(
        'Co to je: Výrazné barvy, zaoblené rohy, animace a ilustrace.'
        'Kdy zvolit: B2C produkty, vzdělávací platformy, komunitní aplikace.'
        'Plus: Silná vizuální identita, vyšší zapojení uživatelů.'
        'Pozor: Hůř se udržuje konzistence, může působit nedůvěryhodně v enterprise.'
    ) -join "`n"
    'Material Design 3' = @(
        'Co to je: Google Material You s dynamickými barvami založenými na seed barvě.'
        'Kdy zvolit: Android aplikace, týmy, které chtějí hotový a známý systém.'
        'Plus: Detailně promyšlené komponenty i přístupnost, známé uživatelům.'
        'Pozor: Snadno rozpoznatelné jako Google, méně originální, těžkopádné na custom brand.'
    ) -join "`n"
    'Glassmorphism / Neumorphism' = @(
        'Co to je: Moderní trendy postavené na rozostřeném skle nebo měkkých 3D stínech.'
        'Kdy zvolit: Prezentační web, produktové microsites, experimentální UI.'
        'Plus: Vizuálně poutavé, dobře vypadá na gradientních pozadích.'
        'Pozor: Špatný kontrast a čitelnost, slabá přístupnost, hůř se udržuje.'
    ) -join "`n"

    'Monolit (jedna aplikace)' = @(
        'Co to je: Veškerá logika v jednom nasaditelném celku.'
        'Kdy zvolit: Malý tým, raná fáze produktu, neznámé požadavky.'
        'Plus: Nejjednodušší vývoj, ladění i nasazení; jeden proces ke sledování.'
        'Pozor: Hůř se škáluje po částech, riziko propojení nesouvisejících částí.'
    ) -join "`n"
    'Modulární monolit (moduly s vlastními hranicemi)' = @(
        'Co to je: Jeden deploy, ale moduly komunikují jen přes veřejné rozhraní.'
        'Kdy zvolit: Roste ti doména, ale nechceš provozní nároky mikroservis.'
        'Plus: Přechod na služby je později jednodušší, lepší testovatelnost.'
        'Pozor: Hranice je nutné vynutit nástroji, jinak se z modulů stane velký chaos.'
    ) -join "`n"
    'Mikroservisy (nezávislé služby)' = @(
        'Co to je: Každá služba je samostatně nasaditelná a má vlastní datová data.'
        'Kdy zvolit: Více týmů, jasně oddělené domény, odlišné nároky na škálování.'
        'Plus: Nezávislé nasazení a škálování, izolace poruch.'
        'Pozor: Provozní a ladící složitost, distribuované transakce, latence mezi službami.'
    ) -join "`n"
    'Serverless / Edge funkce' = @(
        'Co to je: Kód běží jako jednotlivé funkce bez správy serveru.'
        'Kdy zvolit: Nepravidelný provoz, webhooky, jednoduchá API, globální čtení.'
        'Plus: Platíš za použití, automatické škálování, žádná údržba strojů.'
        'Pozor: Cold start, limity doby běhu, nutné řešit connection pooling.'
    ) -join "`n"
    'Hybridní (modulární monolit + extrahované služby)' = @(
        'Co to je: Jádro v monolitu, jen výpočetně náročné části jako služby.'
        'Kdy zvolit: Chceš výhody obojího bez plného přechodu na mikroservisy.'
        'Plus: Pragmatický kompromis, náročné části lze škálovat zvlášť.'
        'Pozor: Dvě infrastruktury, nutné sledovat, kde co běží, a hlídat duplicitu logiky.'
    ) -join "`n"

    'Pouze web (desktop + mobil)' = @(
        'Co to je: Responzivní web bez administrace a bez nativní aplikace.'
        'Kdy zvolit: Prezentace, blog, jednoduchý produkt nebo MVP.'
        'Plus: Nejrychlejší dodání, jedna codebase, nejnižší náklady.'
        'Pozor: Bez admin sekce se obsah upravuje v kódu nebo v CMS.'
    ) -join "`n"
    'Web + Administrace' = @(
        'Co to je: Veřejná část plus chráněná sekce pro správu dat.'
        'Kdy zvolit: E-shop, rezervační systém, katalog, interní evidence.'
        'Plus: Umožňuje provoz bez zásahu do kódu, jasné oddělení práv.'
        'Pozor: Admin je nutné navrhnout a zabezpečit, jinak vzniká bezpečnostní riziko.'
    ) -join "`n"
    'Web + Administrace + Mobilní aplikace' = @(
        'Co to je: Plný rozsah - veřejný web, admin sekce a nativní mobil.'
        'Kdy zvolit: Produkt pro koncové uživatele na mobilu i webu, se správou.'
        'Plus: Nejlepší pokrytí kanálů, mobil může využívat push notifikace.'
        'Pozor: Nejvyšší náklady a čas, nutná sdílená API vrstva a typy.'
    ) -join "`n"
    'Web + Mobilní aplikace (bez adminu)' = @(
        'Co to je: Veřejný web a mobil, správa obsahu řešena vně (CMS, DB nástroj).'
        'Kdy zvolit: Obsah se mění zřídka, admin by byl zbytečná investice.'
        'Plus: Nižší náklady než plný rozsah, méně kódu k údržbě.'
        'Pozor: Bez admin rozhraní je správa nepohodlná a náchylná k chybám.'
    ) -join "`n"
    'PWA (Progressive Web App)' = @(
        'Co to je: Web, který lze nainstalovat na plochu a částečně funguje offline.'
        'Kdy zvolit: Chceš mobilní zážitek bez vývoje nativní aplikace.'
        'Plus: Jedna codebase, žádný obchod s aplikacemi, snadné aktualizace.'
        'Pozor: Omezený přístup k hardwaru, na iOS slabší podpora a horší UX.'
    ) -join "`n"
}

# ---- Frontend: framework, styling, i18n, stav, formuláře, animace ----
$script:helpDetailSets += @{
    'Next.js (App Router)' = @(
        'Co to je: React framework od Vercelu s React Server Components, Server Actions a streamingem.'
        'Kdy zvolit: SEO web, e-shop, SaaS, cokoli s veřejnými stránkami a backendem v jednom.'
        'Plus: Nejlepší DX, hotové SEO, obrázky, routing i backend v jednom; obrovská komunita.'
        'Pozor: Nutné pochopit hranici server a klient, silná vazba na Vercel při edge funkcích.'
    ) -join "`n"
    'React + Vite' = @(
        'Co to je: Čistý React bez frameworku, sestavený Vite.'
        'Kdy zvolit: Interní aplikace, dashboard za přihlášením, kde neřešíš SEO.'
        'Plus: Velmi rychlý dev server, minimální magie, svoboda v architektuře.'
        'Pozor: Routing, data fetching i SEO si řešíš sám; více ruční práce.'
    ) -join "`n"
    'Vue 3 + Vite' = @(
        'Co to je: Vue s Composition API a Vite jako build nástrojem.'
        'Kdy zvolit: Tým zná Vue, chceš nižší vstupní bariéru než React.'
        'Plus: Lehčí než React, výborná dokumentace, SFC soubory drží logiku pohromadě.'
        'Pozor: Menší ekosystém než React, méně hotových enterprise komponent.'
    ) -join "`n"
    'Nuxt 3/4' = @(
        'Co to je: Vue framework odpovídající Next.js - SSR, auto-importy, server routes.'
        'Kdy zvolit: Chceš Vue a zároveň SEO web s backendem.'
        'Plus: Skvělá konvence a auto-importy, Nitro server, méně boilerplate než Next.js.'
        'Pozor: Menší trh práce, některé integrace jsou méně hotové než u Next.js.'
    ) -join "`n"
    'SvelteKit' = @(
        'Co to je: Framework nad Svelte s nejmenším výsledným bundlem.'
        'Kdy zvolit: Výkonnostně citlivé aplikace, menší týmy, nový zelený projekt.'
        'Plus: Nejméně kódu, žádný virtuální DOM, velmi dobrý výkon na mobilu.'
        'Pozor: Menší komunita a nabídka komponent, méně vývojářů na trhu.'
    ) -join "`n"
    'Astro (Islands Architecture)' = @(
        'Co to je: Content-first framework - statické HTML s interaktivními ostrovy.'
        'Kdy zvolit: Blog, dokumentace, marketing, obsah s minimem interaktivity.'
        'Plus: Vynikající Core Web Vitals, posílá minimum JavaScriptu, umí více frameworků.'
        'Pozor: Nevhodné pro silně interaktivní aplikace, ostrovy mají svá pravidla.'
    ) -join "`n"
    'Angular 22' = @(
        'Co to je: Kompletní enterprise framework od Googlu s DI, RxJS a vlastním CLI.'
        'Kdy zvolit: Velký korporátní tým, dlouhodobý projekt, přísné konvence.'
        'Plus: Vše v jednom balíku, silná typovost, výborné nástroje pro velké týmy.'
        'Pozor: Strmá křivka učení, těžkopádnější, delší build a větší bundle.'
    ) -join "`n"
    'React Router v8 (framework mode)' = @(
        'Co to je: React Router používaný jako plnohodnotný framework se SSR a loadery.'
        'Kdy zvolit: Chceš React bez Next.js, ale se serverovým renderingem a datovými loadery.'
        'Plus: Menší abstrakce než Next.js, data fetching svázaný s routou.'
        'Pozor: Menší ekosystém a méně hotových integrací, více rozhodnutí na tobě.'
    ) -join "`n"

    'Tailwind CSS + Shadcn/UI' = @(
        'Co to je: Utility-first CSS a zkopírované přístupné komponenty postavené nad Radixem.'
        'Kdy zvolit: Většina moderních projektů - rychlý start a plná kontrola nad vzhledem.'
        'Plus: Komponenty vlastníš v repozitáři, snadné úpravy, konzistentní spacing.'
        'Pozor: Dlouhé class stringy, nutnost vlastních variant, pozor na duplikaci komponent.'
    ) -join "`n"
    'Tailwind CSS (čistý)' = @(
        'Co to je: Jen Tailwind bez komponentové knihovny.'
        'Kdy zvolit: Máš vlastní design systém, nebo potřebuješ minimální závislosti.'
        'Plus: Nejmenší bundle, plná svoboda, žádné cizí komponenty k přebíjení.'
        'Pozor: Vše od tlačítek po modaly si napíšeš sám, včetně přístupnosti.'
    ) -join "`n"
    'MUI' = @(
        'Co to je: Material Design komponenty pro React s bohatým API.'
        'Kdy zvolit: Enterprise admin, kde rychle potřebuješ hotové tabulky a formuláře.'
        'Plus: Obrovská nabídka komponent, promyšlená přístupnost, dobrá dokumentace.'
        'Pozor: Výrazný material vzhled, obtížné přizpůsobení vlastnímu brandu, větší bundle.'
    ) -join "`n"
    'Mantine / Chakra UI' = @(
        'Co to je: Moderní komponentové knihovny s důrazem na DX a přístupnost.'
        'Kdy zvolit: Chceš hotové komponenty, ale ne material vzhled.'
        'Plus: Příjemná API, dobrá podpora tmavého režimu, aktivní komunita.'
        'Pozor: Vlastní design vyžaduje přepis témat, menší ekosystém než MUI.'
    ) -join "`n"
    'CSS Modules + Vanilla Extract' = @(
        'Co to je: Lokálně scopované CSS soubory s typovou bezpečností při buildu.'
        'Kdy zvolit: Preferuješ klasické CSS a chceš typovou kontrolu nad třídami.'
        'Plus: Žádné runtime náklady, plná síla CSS, jasné oddělení stylů.'
        'Pozor: Více souborů, méně rychlé prototypování než utility třídy.'
    ) -join "`n"
    'Panda CSS' = @(
        'Co to je: CSS-in-JS s kompilací při buildu a typovanými stylovými props.'
        'Kdy zvolit: Chceš typové stylování bez runtime režie a bez dlouhých class stringů.'
        'Plus: Typová bezpečnost, žádný runtime, dobrý výkon i DX.'
        'Pozor: Menší komunita, vlastní koncepty k naučení, méně příkladů na internetu.'
    ) -join "`n"

    'Bez i18n (jednojazyčná aplikace)' = @(
        'Co to je: Aplikace s jedním jazykem, texty přímo v kódu nebo v jednom slovníku.'
        'Kdy zvolit: Interní nástroj, MVP, projekt s jasně jedním trhem.'
        'Plus: Nejméně práce, žádná režie s překlady a formátováním.'
        'Pozor: Dodatečné přidání i18n je drahé - texty je nutné vytáhnout z komponent.'
    ) -join "`n"
    'next-intl (Next.js App Router)' = @(
        'Co to je: i18n knihovna navržená pro Next.js App Router se serverovými komponentami.'
        'Kdy zvolit: Vícejazyk web na Next.js s dobrým SEO.'
        'Plus: Funguje na serveru, typované klíče, locale v URL, podpora pluralizace.'
        'Pozor: Vázané na Next.js, netriviální nastavení s middlewarem.'
    ) -join "`n"
    'next-i18next / i18next' = @(
        'Co to je: Zavedený i18next ekosystém s bohatými pluginy a formátováním.'
        'Kdy zvolit: Potřebuješ pokročilé funkce - plurály, interpolaci, načítání překladů.'
        'Plus: Velmi flexibilní, obrovský ekosystém, funguje i mimo Next.js.'
        'Pozor: Více konfigurace, u App Routeru je next-intl obvykle lepší volba.'
    ) -join "`n"
    'Vlastní JSON slovník' = @(
        'Co to je: Ručně spravované JSON soubory s překlady a vlastní přístupová funkce.'
        'Kdy zvolit: Malý projekt, málo textů, nechceš další závislost.'
        'Plus: Nulové závislosti, plná kontrola, snadno čitelné pro překladatele.'
        'Pozor: Chybí pluralizace, formátování čísel a datumů, kontrola klíčů.'
    ) -join "`n"
    'Vue I18n / SvelteKit i18n' = @(
        'Co to je: Nativní i18n řešení pro Vue a SvelteKit.'
        'Kdy zvolit: Vícejazyk aplikace ve Vue nebo Svelte.'
        'Plus: Dobře integrované s frameworkem, malá režie.'
        'Pozor: Menší ekosystém než i18next, méně hotových nástrojů pro překladatele.'
    ) -join "`n"

    'Zustand / Pinia' = @(
        'Co to je: Lehké knihovny pro globální stav s minimem boilerplate.'
        'Kdy zvolit: UI stav, košík, filtry, téma - cokoli malého a sdíleného.'
        'Plus: Velmi malé API, žádné providery, snadné testování.'
        'Pozor: Není určeno pro serverová data; ta řeš TanStack Query.'
    ) -join "`n"
    'Redux Toolkit' = @(
        'Co to je: Zavedený Redux se zjednodušeným API, slices a DevTools.'
        'Kdy zvolit: Velká aplikace, mnoho vývojářů, potřeba striktně předvídatelného stavu.'
        'Plus: Výborné DevTools a časová osa, jasná konvence, snadné ladění.'
        'Pozor: Více boilerplate, pro malé aplikace zbytečně těžkopádné.'
    ) -join "`n"
    'Context API' = @(
        'Co to je: Nativní React mechanismus pro sdílení hodnot bez předávání props.'
        'Kdy zvolit: Téma, jazyk, přihlášený uživatel - málo často se měnících hodnot.'
        'Plus: Nulové závislosti, součást Reactu, jednoduché na pochopení.'
        'Pozor: Změna hodnoty překreslí všechny konzumenty - nevhodné pro častý stav.'
    ) -join "`n"
    'Bez globálního stavu' = @(
        'Co to je: Veškerý stav zůstává lokální v komponentách nebo v URL.'
        'Kdy zvolit: Jednoduché aplikace, hodně serverového stavu, převážně statický obsah.'
        'Plus: Nejjednodušší na pochopení, žádné synchronizační chyby.'
        'Pozor: Při růstu začneš props předávat hluboko - pak je čas stav zavést.'
    ) -join "`n"

    'React Hook Form + Zod' = @(
        'Co to je: Nekontrolované formuláře s validací schématem Zod.'
        'Kdy zvolit: Prakticky každý React formulář - je to nejlepší kombinace.'
        'Plus: Minimální překreslování a velmi dobrý výkon, sdílené schéma se serverem.'
        'Pozor: Nutné pochopit register a resolver, u netriviálních polí delší zápis.'
    ) -join "`n"
    'VeeValidate + Zod' = @(
        'Co to je: Ekvivalent React Hook Form pro Vue se stejnou validací přes Zod.'
        'Kdy zvolit: Formuláře ve Vue projektu se sdíleným schématem.'
        'Plus: Dobrá integrace s Vue, typová bezpečnost, sdílená schémata.'
        'Pozor: Menší komunita, méně příkladů než u React ekosystému.'
    ) -join "`n"
    'Server Actions (Nativní)' = @(
        'Co to je: Formuláře odesílané funkcí na serveru bez ručního API endpointu.'
        'Kdy zvolit: Jednoduché mutace v Next.js nebo Nuxtu, méně kódu.'
        'Plus: Méně boilerplate, funguje i bez JavaScriptu, typová bezpečnost.'
        'Pozor: Nutné ošetřit opakované odeslání a validaci na serveru, hůř se testuje.'
    ) -join "`n"
    'Čistý state' = @(
        'Co to je: Ruční správa formulářových hodnot přes useState nebo ref.'
        'Kdy zvolit: Formulář o jednom až dvou polích, nebo specifický případ.'
        'Plus: Žádná závislost, plná kontrola nad chováním.'
        'Pozor: Validace, chyby i výkon si řešíš sám - u větších formulářů to bolí.'
    ) -join "`n"

    'Žádná (minimalistické)' = @(
        'Co to je: Bez animací, jen okamžité změny stavu.'
        'Kdy zvolit: Enterprise nástroje, přístupnostní priorita, slabší zařízení.'
        'Plus: Nejrychlejší a nejpřístupnější, žádná režie, žádné rušení uživatele.'
        'Pozor: Změny mohou působit náhle a uživatel nemusí postřehnout, co se stalo.'
    ) -join "`n"
    'Framer Motion' = @(
        'Co to je: Nejpopulárnější React animační knihovna s deklarativním API.'
        'Kdy zvolit: Přechody stránek, rozbalování, gesta, layout animace.'
        'Plus: Skvělé API, layout animace řeší i přesuny mezi seznamy.'
        'Pozor: Přidává do bundlu, nutné hlídat výkon a respektovat prefers-reduced-motion.'
    ) -join "`n"
    'GSAP' = @(
        'Co to je: Profesionální animační engine s timelines a scroll triggery.'
        'Kdy zvolit: Marketingové weby, scrollytelling, složité sekvence.'
        'Plus: Nejlepší kontrola nad časováním, výkonný i při mnoha prvcích.'
        'Pozor: Imperativní API, licence u některých pluginů, snadno se přežene.'
    ) -join "`n"
    'CSS Animations (nativní)' = @(
        'Co to je: Čisté CSS keyframes a transitions.'
        'Kdy zvolit: Jednoduché hover a vstupní animace bez závislosti.'
        'Plus: Nulová režie, běží mimo hlavní vlákno, funguje i bez JavaScriptu.'
        'Pozor: Obtížné řízení stavu, složité sekvence se píšou nepohodlně.'
    ) -join "`n"
    'Auto-Animate' = @(
        'Co to je: Knihovna, která automaticky animuje změny v DOM.'
        'Kdy zvolit: Seznamy, tabulky a řazení, kde nechceš psát animace ručně.'
        'Plus: Velmi jednoduché použití, dobré výsledky bez práce.'
        'Pozor: Omezená kontrola nad detaily, méně vhodné pro komplexní choreografii.'
    ) -join "`n"
}

# ---- Backend: jádro, databáze, ORM, fetching, realtime, pooling, cache, API ----
$script:helpDetailSets += @{
    'Next.js API Routes / Server Actions' = @(
        'Co to je: Backend žije přímo v Next.js - route handlers a serverové akce.'
        'Kdy zvolit: Když web a API mají jeden deploy a společnou logiku.'
        'Plus: Jeden projekt, sdílené typy i validace, nejrychlejší start.'
        'Pozor: Obtížné škálovat odděleně, dlouhé úlohy se do requestu nevejdou.'
    ) -join "`n"
    'Oddělený Node.js (Express / NestJS)' = @(
        'Co to je: Samostatný Node.js server s vlastním životním cyklem.'
        'Kdy zvolit: Backend slouží více klientům, roste tým, potřebuješ oddělené škálování.'
        'Plus: Jasné hranice, nezávislý deploy, vhodné pro složitou doménu.'
        'Pozor: Dvě codebase, nutné sdílet typy a řešit CORS a autentizaci zvlášť.'
    ) -join "`n"
    'Hono' = @(
        'Co to je: Ultra lehký web framework běžící na Node, Deno, Bun i edge.'
        'Kdy zvolit: Malé API, webhooky, edge funkce, kde záleží na velikosti a rychlosti.'
        'Plus: Minimální režie, přenositelný mezi runtimes, čisté API.'
        'Pozor: Menší ekosystém, pokročilé enterprise funkce si dodáš sám.'
    ) -join "`n"
    'BaaS (Supabase / Firebase)' = @(
        'Co to je: Backend jako služba - hotová databáze, autentizace, storage i realtime.'
        'Kdy zvolit: MVP, malý tým, chceš rychle dodat produkt bez provozu backendu.'
        'Plus: Rychlý start, minimum infrastruktury, hotová autentizace a práva.'
        'Pozor: Vendor lock-in, složitější business logika se hůř umisťuje, limity cen.'
    ) -join "`n"
    'Go (Gin / Echo / Fiber)' = @(
        'Co to je: Kompilovaný jazyk s routery Gin, Echo nebo Fiber.'
        'Kdy zvolit: Vysoký výkon, nízká spotřeba paměti, souběžné zpracování.'
        'Plus: Velmi rychlý a úsporný, snadný deploy jednoho binárního souboru.'
        'Pozor: Delší vývoj, nutné psát více kódu, méně hotových knihoven než v Node.'
    ) -join "`n"
    'Python (FastAPI / Django)' = @(
        'Co to je: Python backend s moderním API (FastAPI) nebo bateriemi v ceně (Django).'
        'Kdy zvolit: AI a ML, datová analytika, rychlý prototyping, interní nástroje.'
        'Plus: Nejlepší AI a datový ekosystém, čitelný kód, rychlý vývoj.'
        'Pozor: Nižší výkon než Go nebo Rust, nasazení a závislosti náročnější.'
    ) -join "`n"
    'Rust (Axum / Actix)' = @(
        'Co to je: Systémový jazyk s frameworky Axum nebo Actix.'
        'Kdy zvolit: Extrémní nároky na výkon a bezpečnost paměti, dlouhodobý základ.'
        'Plus: Maximální výkon, žádné GC pauzy, bezpečnost paměti garantovaná překladačem.'
        'Pozor: Nejstrmější křivka učení a nejdelší vývoj, méně vývojářů na trhu.'
    ) -join "`n"
    'Edge Functions (Cloudflare Workers)' = @(
        'Co to je: Kód běžící v datacentrech blízko uživatele.'
        'Kdy zvolit: Redirecty, geolokace, A/B na edge, autorizace, cache na okraji.'
        'Plus: Minimální latence globálně, vysoká propustnost, nízké náklady.'
        'Pozor: Omezené API a doba běhu, obtížné ladění, není pro náročné výpočty.'
    ) -join "`n"

    'Neon (serverless Postgres, vlastní Auth)' = @(
        'Co to je: Serverless Postgres s databázovými větvemi a scale-to-zero.'
        'Kdy zvolit: Next.js nebo serverless aplikace, kde chceš Postgres bez správy.'
        'Plus: Větev databáze na každý pull request, rychlý start, dobrý free tier.'
        'Pozor: Vlastní autentizaci si řešíš sám, cold start u neaktivních větví.'
    ) -join "`n"
    'Supabase (kompletní backend: DB + Auth + Storage)' = @(
        'Co to je: Open-source alternativa Firebase nad Postgresem.'
        'Kdy zvolit: Chceš rychle produkt s autentizací, právy na řádky a storage.'
        'Plus: Vše v jednom, RLS pro bezpečnost dat, realtime, velkorysý free tier.'
        'Pozor: Silnější vazba na platformu, složitější migrace, RLS je nutné dobře navrhnout.'
    ) -join "`n"
    'Neon (preview DB) + Supabase (produkční backend)' = @(
        'Co to je: Větve databáze pro náhledy na Neonu, produkce na Supabase.'
        'Kdy zvolit: Chceš izolované náhledy u pull requestů a zároveň plný BaaS v produkci.'
        'Plus: Levné a bezpečné preview bez dopadu na produkční data.'
        'Pozor: Dvě platformy a dva dialekty konfigurace, riziko rozdílného chování.'
    ) -join "`n"
    'PlanetScale (MySQL)' = @(
        'Co to je: Serverless MySQL s databázovými větvemi a nerušivými migracemi.'
        'Kdy zvolit: Tým zná MySQL, potřebuješ bezpečné změny schématu bez výpadku.'
        'Plus: Netriviální migrace bez výpadku, větve schématu, výborné škálování čtení.'
        'Pozor: Cizí klíče mají omezení, cena roste u velkých projektů.'
    ) -join "`n"
    'Turso (SQLite edge)' = @(
        'Co to je: SQLite replikované na edge s lokálními čtenářskými replikami.'
        'Kdy zvolit: Čtecí zátěž s minimální latencí, menší datové sady, edge aplikace.'
        'Plus: Extrémně nízká latence čtení, jednoduchý model, nízké náklady.'
        'Pozor: Omezení SQLite u zápisů, méně vhodné pro složité relační dotazy.'
    ) -join "`n"
    'Vlastní PostgreSQL (VPS)' = @(
        'Co to je: Vlastní Postgres na serveru nebo v kontejneru.'
        'Kdy zvolit: Specifické rozšíření, přísná data residency, plná kontrola.'
        'Plus: Plná kontrola a rozšíření, žádný vendor lock-in, předvídatelné náklady.'
        'Pozor: Zálohy, aktualizace, monitoring a HA si řešíš sám - vysoká odpovědnost.'
    ) -join "`n"

    'Nativní integrace Neon (auto ENV inject)' = @(
        'Co to je: Vercel automaticky vloží connection stringy do prostředí.'
        'Kdy zvolit: Používáš Neon i Vercel - je to nejméně práce.'
        'Plus: Nulová konfigurace, správné proměnné pro náhledy i produkci.'
        'Pozor: Váže tě to na kombinaci platforem, hůř se přenáší jinam.'
    ) -join "`n"
    'Supabase Marketplace (one-click)' = @(
        'Co to je: Připojení Supabase přes Vercel Marketplace.'
        'Kdy zvolit: Kombinuješ Vercel a Supabase a chceš rychlé nastavení.'
        'Plus: Rychlé propojení, proměnné se nastaví automaticky.'
        'Pozor: Nutné ověřit, které proměnné se opravdu vložily, a nastavit RLS.'
    ) -join "`n"
    'Manuální správa ENV' = @(
        'Co to je: Proměnné nastavuješ ručně v cílovém prostředí.'
        'Kdy zvolit: Kombinace platforem bez hotové integrace nebo přísná bezpečnostní politika.'
        'Plus: Plná kontrola, žádné skryté vazby, jasný přehled o hodnotách.'
        'Pozor: Snadno zapomeneš proměnnou u náhledového prostředí, nutná dokumentace.'
    ) -join "`n"
    'Nepoužívám Vercel' = @(
        'Co to je: Nasazení mimo Vercel, takže integrace databáze neplatí.'
        'Kdy zvolit: Vlastní hosting, EU hosting, Kubernetes nebo jiný PaaS.'
        'Plus: Volnost v infrastruktuře, kontrola nad daty i náklady.'
        'Pozor: Veškeré nastavení prostředí i náhledů si řešíš sám.'
    ) -join "`n"

    'Prisma' = @(
        'Co to je: Nejpopulárnější ORM pro TypeScript se schématem a generovanými klienty.'
        'Kdy zvolit: Chceš typovou bezpečnost a pohodlné migrace bez psaní SQL.'
        'Plus: Výborný DX, čitelné schéma, kvalitní migrace a Studio.'
        'Pozor: Vlastní dotazy mohou být neefektivní, historicky těžší v serverless.'
    ) -join "`n"
    'Drizzle ORM' = @(
        'Co to je: Lehčí SQL-first ORM s typovou bezpečností a blízkostí k SQL.'
        'Kdy zvolit: Serverless a edge, kde záleží na velikosti a kontrole nad dotazem.'
        'Plus: Malý bundle, předvídatelné SQL, výborný v serverless prostředí.'
        'Pozor: Méně pohodlí než Prisma, více SQL znalostí je potřeba.'
    ) -join "`n"
    'Mongoose' = @(
        'Co to je: ODM pro MongoDB se schématy a validací nad dokumentovým modelem.'
        'Kdy zvolit: Dokumentová data, kdy struktura není pevná.'
        'Plus: Přirozené pro MongoDB, pluginy, middleware hooky, validace.'
        'Pozor: Dokumentový model se hůř spojuje, pozor na nekonzistence dat.'
    ) -join "`n"
    'Supabase Client' = @(
        'Co to je: Přímý přístup k Supabase z frontendu nebo serveru s respektem k RLS.'
        'Kdy zvolit: Jednoduché čtení a zápis, kde práva hlídá RLS.'
        'Plus: Méně kódu, realtime a storage zdarma k tomu, rychlý vývoj.'
        'Pozor: Složitější logiku musíš schovat do funkcí, jinak ji obchází klient.'
    ) -join "`n"
    'Kysely (typovaný SQL builder)' = @(
        'Co to je: Type-safe SQL builder bez magie a bez generovaného klienta.'
        'Kdy zvolit: Chceš plnou kontrolu nad SQL a zároveň typovou bezpečnost.'
        'Plus: Píšeš SQL, dostáváš typy; žádné skryté dotazy.'
        'Pozor: Migrace a schéma si řešíš zvlášť, více ruční práce.'
    ) -join "`n"
    'Raw SQL + prepared statements' = @(
        'Co to je: Přímé parametrizované SQL dotazy bez ORM.'
        'Kdy zvolit: Výkonnostně kritické dotazy, složité agregace, optimalizace.'
        'Plus: Maximální výkon a kontrola, žádná abstrakce navíc.'
        'Pozor: Ruční mapování, riziko SQL injection při nepozornosti, hůř se refaktoruje.'
    ) -join "`n"

    'TanStack Query' = @(
        'Co to je: Knihovna pro serverový stav - cache, refetch, mutace a optimistické UI.'
        'Kdy zvolit: Jakákoli aplikace načítající data z API.'
        'Plus: Řeší cache, deduplikaci, retry i invalidaci; výrazně méně kódu.'
        'Pozor: Duplikuje stav, pokud ho zároveň držíš v globálním storu.'
    ) -join "`n"
    'SWR' = @(
        'Co to je: Lehčí alternativa k TanStack Query od Vercelu.'
        'Kdy zvolit: Jednoduché načítání a cache, menší nároky na mutace.'
        'Plus: Velmi malé a jednoduché API, rychlý start.'
        'Pozor: Méně funkcí u mutací, invalidace a pokročilých scénářů.'
    ) -join "`n"
    'tRPC' = @(
        'Co to je: End-to-end typově bezpečné volání serverových funkcí bez REST nebo GraphQL.'
        'Kdy zvolit: Monorepo nebo Next.js, kde klient i server znají typy.'
        'Plus: Nulové ruční typování API, okamžitá zpětná vazba při změně kontraktu.'
        'Pozor: Funguje jen pro vlastní TypeScript klienty, nevhodné pro veřejné API.'
    ) -join "`n"
    'Nativní fetch()' = @(
        'Co to je: Přímé HTTP volání bez datové knihovny.'
        'Kdy zvolit: Málo endpointů, jednorázové načtení, serverové komponenty.'
        'Plus: Žádná závislost, plná kontrola, funguje všude.'
        'Pozor: Cache, retry, deduplikaci a stav si řešíš sám.'
    ) -join "`n"
    'GraphQL (Apollo / urql)' = @(
        'Co to je: Jeden endpoint s deklarativními dotazy a klientem pro cache.'
        'Kdy zvolit: Mnoho klientů s různými nároky na data, složitý datový graf.'
        'Plus: Klient si vyžádá jen to, co potřebuje; silné schéma a typy.'
        'Pozor: Vyšší komplexita, riziko N+1, těžší cache a monitoring.'
    ) -join "`n"
    'Server Actions + useOptimistic' = @(
        'Co to je: Mutace přes serverové akce s okamžitým optimistickým zobrazením.'
        'Kdy zvolit: Formuláře a jednoduché akce, kde chceš okamžitou odezvu.'
        'Plus: Velmi dobrý dojem z rychlosti, méně kódu, funguje i bez JavaScriptu.'
        'Pozor: Nutné řešit návrat při chybě, duplicitní odeslání a revalidaci.'
    ) -join "`n"
    'Žádná (REST only)' = @(
        'Co to je: Pouze klasické request-response bez živého spojení.'
        'Kdy zvolit: Data se nemění v reálném čase, stačí obnovení po akci.'
        'Plus: Nejjednodušší na provoz i škálování, snadno se cachuje.'
        'Pozor: Uživatel nevidí změny od ostatních, nutné obnovovat ručně.'
    ) -join "`n"

    'WebSockets (Socket.io / nativní)' = @(
        'Co to je: Plně duplexní spojení mezi klientem a serverem.'
        'Kdy zvolit: Chat, notifikace v reálném čase, kolaborativní editace, hry.'
        'Plus: Obousměrná komunikace s minimální latencí.'
        'Pozor: Nutné řešit reconnect, stav spojení a škálování (sticky sessions, pub/sub).'
    ) -join "`n"
    'Server-Sent Events (SSE)' = @(
        'Co to je: Jednosměrný stream ze serveru k klientovi po HTTP.'
        'Kdy zvolit: Streaming odpovědí AI, průběh úlohy, live feed jen pro čtení.'
        'Plus: Jednodušší než WebSockets, funguje přes běžné HTTP, automatický reconnect.'
        'Pozor: Jen od serveru, omezený počet spojení v HTTP/1.1.'
    ) -join "`n"
    'GraphQL Subscriptions' = @(
        'Co to je: Živé aktualizace přes GraphQL subscription.'
        'Kdy zvolit: Už používáš GraphQL a potřebuješ live data.'
        'Plus: Konzistentní model s dotazy, typované události.'
        'Pozor: Provozně náročné, obvykle potřebuje WebSockets a pub/sub infrastrukturu.'
    ) -join "`n"
    'Supabase Realtime / Firebase' = @(
        'Co to je: Managed realtime - změny v datech se samy rozešlou klientům.'
        'Kdy zvolit: Chceš realtime bez vlastní infrastruktury.'
        'Plus: Nulové provozní náklady, integrováno s databází a právy.'
        'Pozor: Limity počtu spojení a zpráv, nutné hlídat náklady a řádově omezit data.'
    ) -join "`n"

    'Neon serverless driver (HTTP, žádný pool)' = @(
        'Co to je: Dotazy přes HTTP bez držení databázového spojení.'
        'Kdy zvolit: Serverless a edge funkce, kde spojení vznikají a zanikají.'
        'Plus: Žádné vyčerpání poolu, nízká latence přes HTTP, ideální pro serverless.'
        'Pozor: Jen pro krátké dotazy, nevhodné pro dlouhé transakce.'
    ) -join "`n"
    'Supabase Supavisor (transaction mode)' = @(
        'Co to je: Connection pooler, který přiřazuje spojení po dobu transakce.'
        'Kdy zvolit: Serverless funkce připojené k Supabase nebo Postgresu.'
        'Plus: Zvládne mnoho krátkých spojení, chrání databázi před vyčerpáním.'
        'Pozor: Session funkce a prepared statements mají omezení, migrace spouštěj mimo pooler.'
    ) -join "`n"
    'Prisma Accelerate' = @(
        'Co to je: Managed connection pool a globální cache pro Prisma.'
        'Kdy zvolit: Serverless s Prismou, kde narážíš na limity spojení a latenci.'
        'Plus: Vyřeší pooling i cache bez vlastní infrastruktury, globálně blízko uživateli.'
        'Pozor: Placená služba, cache je nutné správně invalidovat.'
    ) -join "`n"
    'Vlastní konfigurace poolu' = @(
        'Co to je: Ruční nastavení velikosti a chování poolu (například pg.Pool).'
        'Kdy zvolit: Dlouho běžící server, kde máš kontrolu nad počtem instancí.'
        'Plus: Plná kontrola, možnost sladit velikost poolu s kapacitou databáze.'
        'Pozor: V serverless vede na vyčerpání spojení - tam použij pooler.'
    ) -join "`n"
    'Nepotřebné (trvalé připojení)' = @(
        'Co to je: Dlouho běžící proces drží spojení a pooling nepotřebuje.'
        'Kdy zvolit: Kontejner nebo VM s trvale běžícím serverem.'
        'Plus: Žádná další vrstva, minimální latence, jednoduché ladění.'
        'Pozor: U serverless nebo více instancí tento předpoklad neplatí.'
    ) -join "`n"

    'Žádná (fresh data)' = @(
        'Co to je: Data se načítají vždy aktuální, bez cache.'
        'Kdy zvolit: Finanční data, stav objednávky, cokoli, kde je zastaralost nepřípustná.'
        'Plus: Vždy správná data, žádné problémy s invalidací.'
        'Pozor: Vyšší zátěž databáze a delší odezva.'
    ) -join "`n"
    'Vercel KV / Upstash Redis' = @(
        'Co to je: Managed Redis pro cache, rate limiting a fronty.'
        'Kdy zvolit: Potřebuješ cache nebo počítadla sdílená mezi instancemi.'
        'Plus: Serverless-friendly, trvanlivé, podporuje TTL i atomické operace.'
        'Pozor: Další služba k provozu a placení, nutné řešit invalidaci a klíče.'
    ) -join "`n"
    'Next.js unstable_cache / Data Cache' = @(
        'Co to je: Nativní cache Next.js pro serverová data s revalidací.'
        'Kdy zvolit: Next.js aplikace, kde chceš cache bez další služby.'
        'Plus: Zdarma, integrovaná s revalidací a tagy, méně infrastruktury.'
        'Pozor: Jen v Next.js, chování se mezi verzemi mění, hůř se ladí.'
    ) -join "`n"
    'React Query cache (client-side)' = @(
        'Co to je: Cache dat přímo v prohlížeči spravovaná TanStack Query.'
        'Kdy zvolit: Zrychlení navigace mezi obrazovkami u jednoho uživatele.'
        'Plus: Okamžitá odezva při návratu na stránku, méně požadavků.'
        'Pozor: Data mohou být zastaralá, nutné nastavit staleTime a invalidaci.'
    ) -join "`n"
    'CDN + ISR kombinace' = @(
        'Co to je: Statické stránky na CDN, které se na pozadí revalidují.'
        'Kdy zvolit: Veřejný obsah s vysokou návštěvností - katalog, magazín.'
        'Plus: Nejnižší náklady na požadavek, velmi rychlé i při špičce.'
        'Pozor: Krátce může být vidět starší verze, nutné plánovat revalidaci.'
    ) -join "`n"

    'REST + OpenAPI spec' = @(
        'Co to je: REST API s popisem ve strojově čitelné OpenAPI specifikaci.'
        'Kdy zvolit: Veřejné API, více klientů, generování SDK a dokumentace.'
        'Plus: Standard, klienti i dokumentace se generují, snadná integrace.'
        'Pozor: Spec musíš udržovat v souladu s kódem, jinak vzniká rozdíl.'
    ) -join "`n"
    'REST + Zod validace' = @(
        'Co to je: REST s runtime validací vstupů schématem Zod.'
        'Kdy zvolit: Interní API a menší projekty, kde stačí sdílené schéma.'
        'Plus: Sdílené typy i validace mezi klientem a serverem, méně kódu.'
        'Pozor: Bez OpenAPI nemáš strojově čitelný kontrakt pro cizí klienty.'
    ) -join "`n"
    'GraphQL (Cursor Connections)' = @(
        'Co to je: GraphQL se stránkováním podle kurzorů (Relay-style).'
        'Kdy zvolit: Velké seznamy a feedy, kde potřebuješ stabilní stránkování.'
        'Plus: Stabilní stránkování i při změnách dat, dobré pro nekonečné scrollování.'
        'Pozor: Složitější implementace i klient, více kódu než offset stránkování.'
    ) -join "`n"
    'tRPC (end-to-end typesafe)' = @(
        'Co to je: Volání serverové logiky s automatickou typovou bezpečností.'
        'Kdy zvolit: Monorepo nebo Next.js, kde klient je v TypeScriptu.'
        'Plus: Žádné ruční typy API, refaktoring je bezpečný a rychlý.'
        'Pozor: Nelze použít pro cizí klienty ani mobil v jiném jazyce.'
    ) -join "`n"
}

# ---- DevOps: nastavení, lint, testy, CI/CD, Vercel, IaC ----
$script:helpDetailSets += @{
    'ESLint' = @(
        'Co to je: Statická analýza JavaScriptu a TypeScriptu podle sad pravidel.'
        'Kdy zvolit: Prakticky vždy - chytá chyby dřív, než se dostanou do produkce.'
        'Plus: Záchyt skutečných chyb, vynucení týmových konvencí, integrace s editorem.'
        'Pozor: Pravidla je nutné průběžně ladit, jinak vzniká šum a vývojáři je vypínají.'
    ) -join "`n"
    'Prettier' = @(
        'Co to je: Automatický formátovač kódu s minimem konfigurace.'
        'Kdy zvolit: Chceš ukončit diskuze o formátování v code review.'
        'Plus: Konzistentní vzhled kódu, žádné ruční formátování, rychlé.'
        'Pozor: Může kolidovat s ESLint pravidly - použij konfiguraci, která je sladí.'
    ) -join "`n"
    'Biome' = @(
        'Co to je: All-in-one nástroj nahrazující ESLint i Prettier, napsaný v Rustu.'
        'Kdy zvolit: Nový projekt, kde chceš jeden rychlý nástroj místo dvou.'
        'Plus: Výrazně rychlejší než ESLint, jedna konfigurace, formátuje i lintuje.'
        'Pozor: Menší nabídka pluginů a pravidel, migrace existujících pravidel není 1:1.'
    ) -join "`n"
    'Striktní TS (no implicit any)' = @(
        'Co to je: Přísný režim TypeScriptu - žádné implicitní any, přísné null kontroly.'
        'Kdy zvolit: Vždy u nového projektu; u staršího postupná migrace po částech.'
        'Plus: Chytá celou třídu chyb při překladu, lepší našeptávání v editoru.'
        'Pozor: U staršího kódu vznikne mnoho chyb najednou - migruj postupně.'
    ) -join "`n"
    'Knip (detekce nepoužívaného kódu)' = @(
        'Co to je: Nástroj, který najde nepoužívané soubory, exporty a závislosti.'
        'Kdy zvolit: Projekt roste a začíná mít mrtvý kód a nepotřebné balíčky.'
        'Plus: Zmenšuje bundle, odhaluje zapomenutý kód, zpřehledňuje repozitář.'
        'Pozor: Občas označí dynamicky používaný kód - nutné konfigurovat výjimky.'
    ) -join "`n"
    'Husky + lint-staged (pre-commit)' = @(
        'Co to je: Git hook, který před commitem spustí lint a formát jen na změněné soubory.'
        'Kdy zvolit: Nechceš, aby se neformátovaný nebo chybný kód dostal do repozitáře.'
        'Plus: Rychlé díky lint-staged, konzistentní historie commitů.'
        'Pozor: Zdržuje commit, občas je nutné použít přeskakování při naléhavé opravě.'
    ) -join "`n"
    'Commitlint (konvence commitů)' = @(
        'Co to je: Kontrola formátu commit zpráv podle Conventional Commits.'
        'Kdy zvolit: Chceš automatické verzování a generovaný changelog.'
        'Plus: Umožňuje semantic release, čitelná historie, snadné hledání změn.'
        'Pozor: Vyžaduje disciplínu týmu, u malých projektů může zdržovat.'
    ) -join "`n"

    'Vitest' = @(
        'Co to je: Rychlý unit test runner navržený pro Vite a moderní projekty.'
        'Kdy zvolit: Nový projekt, TypeScript a ESM, rychlá zpětná vazba.'
        'Plus: Velmi rychlý, kompatibilní s Jest API, skvělý watch režim.'
        'Pozor: Některé starší pluginy a mocky vyžadují úpravu.'
    ) -join "`n"
    'Playwright (E2E)' = @(
        'Co to je: Nástroj pro end-to-end testy ve skutečných prohlížečích.'
        'Kdy zvolit: Kritické toky - přihlášení, platba, dokončení objednávky.'
        'Plus: Spolehlivé selektory, více prohlížečů, výborné ladění a trace.'
        'Pozor: Pomalejší a křehčí než unit testy, nutná stabilní testovací data.'
    ) -join "`n"
    'Jest' = @(
        'Co to je: Zavedený testovací framework s bohatým ekosystémem.'
        'Kdy zvolit: Existující projekt nebo potřeba konkrétních pluginů.'
        'Plus: Obrovská komunita, hodně příkladů, vyspělé mockování.'
        'Pozor: Pomalejší než Vitest, horší podpora nativního ESM.'
    ) -join "`n"
    'Testing Library (React/Vue)' = @(
        'Co to je: Sada nástrojů pro testování z pohledu uživatele.'
        'Kdy zvolit: Testy komponent - chceš testovat chování, ne implementaci.'
        'Plus: Testy přežijí refaktoring, odrazují od testování interních detailů.'
        'Pozor: Někdy je obtížné simulovat složité interakce, nutné doplnit E2E.'
    ) -join "`n"
    'MSW (Mock Service Worker)' = @(
        'Co to je: Mock API na úrovni sítě pomocí service workeru.'
        'Kdy zvolit: Testy a vývoj bez závislosti na skutečném backendu.'
        'Plus: Stejné mocky pro testy i pro vývoj, žádné obcházení kódu.'
        'Pozor: Nutné udržovat mocky v souladu s reálným API.'
    ) -join "`n"
    'k6 / Artillery (load testing)' = @(
        'Co to je: Nástroje pro zátěžové testy scénářů.'
        'Kdy zvolit: Před spuštěním kampaně, po změně cache nebo databáze.'
        'Plus: Odhalí limity dřív než uživatelé, umožní plánovat kapacitu.'
        'Pozor: Náročné na interpretaci, testy proti produkci mohou škodit.'
    ) -join "`n"

    'GitHub Actions' = @(
        'Co to je: CI/CD přímo v GitHubu bez další infrastruktury.'
        'Kdy zvolit: Repozitář je na GitHubu - je to nejpřirozenější volba.'
        'Plus: Zdarma pro veřejné repozitáře, obrovská nabídka hotových akcí.'
        'Pozor: Minutes se platí u soukromých, delší fronty, nutné cachovat závislosti.'
    ) -join "`n"
    'Build APK (Android)' = @(
        'Co to je: Automatický build Android balíčku v pipeline.'
        'Kdy zvolit: Chceš testovací APK z každého pull requestu nebo tagu.'
        'Plus: Testeři dostanou build bez ruční práce, reprodukovatelné prostředí.'
        'Pozor: Vyžaduje keystore a signing secrets, build je časově náročný.'
    ) -join "`n"
    'Build IPA (iOS)' = @(
        'Co to je: Automatický build iOS balíčku, obvykle přes EAS nebo macOS runner.'
        'Kdy zvolit: Distribuce pro testery nebo do TestFlight.'
        'Plus: Automatizace jinak ručního a pomalého procesu.'
        'Pozor: Nutný Apple Developer účet, certifikáty a provisioning profily.'
    ) -join "`n"
    'Automatické testy na PR' = @(
        'Co to je: Spuštění testů při každém pull requestu.'
        'Kdy zvolit: Vždy - je to základ ochrany hlavní větve.'
        'Plus: Chybu odhalíš před mergem, méně regresí v produkci.'
        'Pozor: Pomalé testy zdržují vývoj - děl je a pouštěj jen dotčené části.'
    ) -join "`n"
    'Preview deployment (Vercel)' = @(
        'Co to je: Každý pull request dostane vlastní veřejnou URL.'
        'Kdy zvolit: Chceš ukázat změny recenzentům nebo klientovi.'
        'Plus: Rychlá vizuální kontrola, testování na reálném buildu.'
        'Pozor: Náhledy nesmí sahat na produkční data - použij oddělené větve databáze.'
    ) -join "`n"
    'Databázové migrace v CI' = @(
        'Co to je: Automatické aplikování migrací během nasazení.'
        'Kdy zvolit: Změny schématu jsou součástí vývoje, chceš vyloučit zapomenutí.'
        'Plus: Konzistentní stav databáze, žádné ruční kroky při nasazení.'
        'Pozor: Migrace musí být zpětně kompatibilní, jinak vznikne výpadek.'
    ) -join "`n"
    'Semantic Release (auto-versioning)' = @(
        'Co to je: Automatické verzování a vydávání podle commit zpráv.'
        'Kdy zvolit: Publikuješ balíček nebo potřebuješ přehledné changelogy.'
        'Plus: Verze i changelog vznikají samy, žádné lidské chyby v číslování.'
        'Pozor: Vyžaduje přísnou konvenci commitů, méně vhodné pro aplikace bez releasů.'
    ) -join "`n"

    'Preview Deployment na PR' = @(
        'Co to je: Náhledové prostředí pro každý pull request na Vercelu.'
        'Kdy zvolit: Tým chce vidět změny v reálném buildu před mergem.'
        'Plus: Zrychlí review, umožní testování designu i chování.'
        'Pozor: Pozor na proměnné prostředí a přístup k datům u náhledů.'
    ) -join "`n"
    'Edge Functions' = @(
        'Co to je: Funkce běžící na edge síti Vercelu.'
        'Kdy zvolit: Redirecty podle geografie, autorizace, A/B testy, cache.'
        'Plus: Minimální latence globálně, velmi rychlé studené starty.'
        'Pozor: Omezené API, jen pro krátké úlohy, není pro databázové operace v Node.'
    ) -join "`n"
    'Vercel Blob (soubory)' = @(
        'Co to je: Managed úložiště souborů na Vercelu.'
        'Kdy zvolit: Nahrávání obrázků, příloh a exportů bez správy S3.'
        'Plus: Jednoduché API, přímé nahrávání z prohlížeče, CDN v ceně.'
        'Pozor: Větší soubory a vyšší provoz jsou dražší než vlastní S3.'
    ) -join "`n"
    'Vercel KV (cache)' = @(
        'Co to je: Managed Redis od Vercelu pro cache a počítadla.'
        'Kdy zvolit: Rate limiting, cache drahých dotazů, sdílený stav mezi instancemi.'
        'Plus: Bez správy infrastruktury, serverless-friendly, TTL podporované.'
        'Pozor: Placené podle objemu, nutné řešit invalidaci a pojmenování klíčů.'
    ) -join "`n"
    'Vercel Postgres (Neon)' = @(
        'Co to je: Postgres od Neonu integrovaný přímo do Vercelu.'
        'Kdy zvolit: Chceš Postgres bez nastavování a s automatickými proměnnými.'
        'Plus: Nulová konfigurace, větve pro náhledy, funkce i databáze na jednom místě.'
        'Pozor: Silnější vazba na Vercel, při změně hostingu je migrace pracnější.'
    ) -join "`n"
    'Concurrent Builds' = @(
        'Co to je: Více souběžných buildů Vercelu najednou.'
        'Kdy zvolit: Monorepo nebo časté pull requesty, kde buildy čekají ve frontě.'
        'Plus: Rychlejší zpětná vazba, žádné zdržení při paralelní práci týmu.'
        'Pozor: Vyšší spotřeba placeného plánu, zbytečné u malého týmu.'
    ) -join "`n"
    'Cron Jobs' = @(
        'Co to je: Plánované úlohy spouštěné Verculem podle cron výrazu.'
        'Kdy zvolit: Úklid dat, odesílání e-mailů, reporty, obnovení cache.'
        'Plus: Bez vlastního scheduleru, snadné nastavení, monitorování běhů.'
        'Pozor: Omezená doba běhu, přesnost v minutách, nutné ošetřit opakované spuštění.'
    ) -join "`n"

    'Žádné (manuální správa)' = @(
        'Co to je: Infrastruktura se nastavuje ručně v konzoli poskytovatele.'
        'Kdy zvolit: Malý projekt, jednorázový prototyp, žádné další prostředí.'
        'Plus: Nejrychlejší start, žádné další nástroje k učení.'
        'Pozor: Změny nejsou reprodukovatelné ani verzované, vzniká rozdíl mezi prostředími.'
    ) -join "`n"
    'Terraform' = @(
        'Co to je: Deklarativní Infrastructure as Code s podporou stovek poskytovatelů.'
        'Kdy zvolit: Více prostředí, cloudové zdroje, auditovatelné změny infrastruktury.'
        'Plus: Průmyslový standard, plán před aplikací, snadná reprodukce prostředí.'
        'Pozor: Nutná správa stavu a jeho uzamčení, vlastní jazyk HCL k naučení.'
    ) -join "`n"
    'Pulumi' = @(
        'Co to je: Infrastructure as Code v TypeScriptu, Pythonu nebo Go.'
        'Kdy zvolit: Tým chce IaC v jazyce, který už zná, s testy a typy.'
        'Plus: Programovací jazyk místo DSL, testovatelnost, sdílení kódu.'
        'Pozor: Menší komunita než Terraform, méně hotových modulů.'
    ) -join "`n"
    'AWS CDK' = @(
        'Co to je: Definice AWS infrastruktury v TypeScriptu nebo Pythonu.'
        'Kdy zvolit: Projekt je silně na AWS a chceš typované konstrukty.'
        'Plus: Silné typy a abstrakce nad CloudFormation, dobré pro složité stacky.'
        'Pozor: Váže tě na AWS, abstrakce občas skryjí důležité detaily.'
    ) -join "`n"
    'Vercel CLI + vercel.json' = @(
        'Co to je: Konfigurace projektů Vercelu souborem vercel.json a CLI.'
        'Kdy zvolit: Potřebuješ rewrite pravidla, hlavičky nebo nastavení prostředí.'
        'Plus: Jednodušší než plné IaC, deklarativní a verzované v repozitáři.'
        'Pozor: Netýká se databází ani externích služeb, jen Vercelu.'
    ) -join "`n"
}

# ---- Bezpečnost: autentizace, oprávnění, moduly, observability, compliance ----
$script:helpDetailSets += @{
    'Vlastní JWT + bearer tokeny' = @(
        'Co to je: Vlastní implementace autentizace s JWT v hlavičce Authorization.'
        'Kdy zvolit: Potřebuješ plnou kontrolu, podporu mobilu i webu, specifické požadavky.'
        'Plus: Maximální flexibilita, jedno API pro více klientů.'
        'Pozor: Snadno se udělá bezpečnostní chyba - rotace klíčů, odvolání tokenu, expirace.'
    ) -join "`n"
    'NextAuth v5 / Auth.js' = @(
        'Co to je: Standardní autentizace pro Next.js s řadou poskytovatelů.'
        'Kdy zvolit: Web na Next.js bez specifických požadavků na auth.'
        'Plus: Hotové providery, správa session, snadné přidání OAuth.'
        'Pozor: Konfigurace je netriviální, u mobilu je potřeba bearer token navíc.'
    ) -join "`n"
    'Clerk (hosted)' = @(
        'Co to je: Hostovaná autentizace s hotovým UI a správou uživatelů.'
        'Kdy zvolit: Chceš přihlašování vyřešit během hodin, ne týdnů.'
        'Plus: Hotové komponenty včetně MFA a správy účtu, minimální kód.'
        'Pozor: Placené podle počtu uživatelů, uživatelská data jsou u třetí strany.'
    ) -join "`n"
    'Lucia (self-hosted)' = @(
        'Co to je: Lehká autentizace bez závislostí, session uložíš do vlastní databáze.'
        'Kdy zvolit: Chceš kontrolu a žádný vendor lock-in, ale nechceš psát vše ručně.'
        'Plus: Malá a čitelná, plná kontrola nad daty, dobrá dokumentace.'
        'Pozor: Více ruční práce než u hotových služeb, méně hotových funkcí.'
    ) -join "`n"
    'Supabase Auth' = @(
        'Co to je: Autentizace od Supabase s integrací na práva na úrovni řádků.'
        'Kdy zvolit: Používáš Supabase a chceš auth i autorizaci v jednom.'
        'Plus: Propojení s RLS, řada poskytovatelů, realtime bez další práce.'
        'Pozor: Silná vazba na Supabase, migrace uživatelů jinam je pracná.'
    ) -join "`n"
    'Kombinace (web: NextAuth, mobil: bearer)' = @(
        'Co to je: NextAuth pro web a bearer tokeny pro mobilní aplikaci.'
        'Kdy zvolit: Máš web s Next.js a zároveň nativní mobilní aplikaci.'
        'Plus: Každý klient používá to, co mu sedí; jedno zdrojové úložiště uživatelů.'
        'Pozor: Dvě auth cesty je nutné udržovat v souladu a správně testovat.'
    ) -join "`n"

    'RBAC (Admin/User/Moderator)' = @(
        'Co to je: Řízení přístupu podle rolí uživatele.'
        'Kdy zvolit: Různé typy uživatelů s odlišnými právy (admin, uživatel, moderátor).'
        'Plus: Jednoduché na pochopení i audit, stačí pro většinu aplikací.'
        'Pozor: Při mnoha výjimkách se role množí - pak zvaž ABAC nebo oprávnění na úrovni zdroje.'
    ) -join "`n"
    'OAuth (Google, GitHub)' = @(
        'Co to je: Přihlášení přes cizí poskytovatele identity.'
        'Kdy zvolit: Chceš snížit tření při registraci a nemít odpovědnost za hesla.'
        'Plus: Rychlé přihlášení, žádná hesla k ukládání, důvěra uživatelů.'
        'Pozor: Závislost na dostupnosti poskytovatele, nutné sladit účty u více metod.'
    ) -join "`n"
    'Magic Links (bez hesla)' = @(
        'Co to je: Přihlášení odkazem zaslaným e-mailem, bez hesla.'
        'Kdy zvolit: B2C aplikace, příležitostné přihlašování, nižší nároky na bezpečnost.'
        'Plus: Žádná hesla, méně zapomenutých přihlášení, jednoduchá implementace.'
        'Pozor: Závisí na doručení e-mailu, odkaz může být přeposlán, přidává tření.'
    ) -join "`n"
    '2FA / TOTP' = @(
        'Co to je: Druhý faktor při přihlášení přes aplikaci generující kódy.'
        'Kdy zvolit: Administrace, citlivá data, soulad s požadavky na bezpečnost.'
        'Plus: Výrazně snižuje riziko zneužití odcizeného hesla.'
        'Pozor: Komplikuje obnovu účtu, nutné řešit záložní kódy.'
    ) -join "`n"
    'Session management' = @(
        'Co to je: Evidence aktivních přihlášení a jejich platnosti.'
        'Kdy zvolit: Aplikace s účty, kde chceš uživatele odhlásit nebo omezit dobu přihlášení.'
        'Plus: Možnost odhlášení všech zařízení, přehled o přihlášeních, vyšší bezpečnost.'
        'Pozor: Nutné řešit vypršení a obnovení session, jinak uživatele obtěžuješ.'
    ) -join "`n"
    'Refresh tokeny' = @(
        'Co to je: Dlouho platný token pro obnovení krátkodobého přístupového tokenu.'
        'Kdy zvolit: Mobilní a SPA klienti, kde nechceš časté přihlašování.'
        'Plus: Lepší uživatelský zážitek, kratší platnost přístupových tokenů.'
        'Pozor: Musí být bezpečně uložen a odvolatelný, jinak jde o riziko.'
    ) -join "`n"
    'Device tracking' = @(
        'Co to je: Evidence zařízení, ze kterých se uživatel přihlásil.'
        'Kdy zvolit: Chceš uživateli ukázat aktivní zařízení a umožnit odhlášení.'
        'Plus: Rychlé odhalení zneužití účtu, transparentnost pro uživatele.'
        'Pozor: Ukládá další osobní údaje - nutné řešit retenci a souhlas.'
    ) -join "`n"

    'T3 Env (Validace .env přes Zod)' = @(
        'Co to je: Typová validace proměnných prostředí při startu aplikace.'
        'Kdy zvolit: Vždy u projektů, které mají více než dvě proměnné prostředí.'
        'Plus: Chybějící nebo špatná proměnná se odhalí okamžitě, ne v produkci.'
        'Pozor: Nutné udržovat schéma v souladu s reálným prostředím a dokumentací.'
    ) -join "`n"
    'Rate Limiting' = @(
        'Co to je: Omezení počtu požadavků za čas podle klienta nebo IP.'
        'Kdy zvolit: Veřejné endpointy, přihlašování, odesílání e-mailů, AI volání.'
        'Plus: Ochrana proti zneužití i nákladovým útokům, vyšší stabilita.'
        'Pozor: Nesmí blokovat legitimní provoz - nastav limity podle reálného chování.'
    ) -join "`n"
    'Helmet hlavičky' = @(
        'Co to je: Sada bezpečnostních HTTP hlaviček pro Node servery.'
        'Kdy zvolit: Vlastní server, kde chceš rychle přidat základní ochranu.'
        'Plus: Jednořádkové zapnutí řady doporučení, nízké riziko.'
        'Pozor: Netýká se Next.js a podobných frameworků, ty řeší hlavičky jinde.'
    ) -join "`n"
    'CORS konfigurace' = @(
        'Co to je: Nastavení, které domény mohou volat tvoje API.'
        'Kdy zvolit: API volají cizí weby, mobilní aplikace nebo nástroje třetích stran.'
        'Plus: Chrání před zneužitím z cizích stránek, ale zároveň umožní integrace.'
        'Pozor: Chybně nastavené CORS je častá příčina nefunkčního API v prohlížeči.'
    ) -join "`n"
    'CSRF ochrana (SameSite)' = @(
        'Co to je: Ochrana proti podvržení požadavku z cizího webu.'
        'Kdy zvolit: Aplikace s cookie session, kde se provádějí změny dat.'
        'Plus: Zabraňuje jednomu z nejstarších a stále častých útoků.'
        'Pozor: Příliš striktní nastavení může rozbít přihlášení přes cizí domény.'
    ) -join "`n"
    'Content Security Policy (CSP)' = @(
        'Co to je: Whitelist zdrojů, ze kterých se může načítat skript, styl nebo obrázek.'
        'Kdy zvolit: Aplikace zpracovávající citlivá data nebo zobrazující cizí obsah.'
        'Plus: Nejúčinnější obrana proti XSS, odhalí nechtěné skripty.'
        'Pozor: Náročné na nasazení - nejprve report-only, jinak rozbiješ aplikaci.'
    ) -join "`n"
    'Audit log (historie změn)' = @(
        'Co to je: Neměnný záznam o tom, kdo co a kdy změnil.'
        'Kdy zvolit: Administrace, finanční data, sdílené účty, compliance.'
        'Plus: Umožní dohledat příčinu, splňuje požadavky auditů, odrazuje od zneužití.'
        'Pozor: Roste objem dat, ukládá osobní údaje - řeš retenci a přístup.'
    ) -join "`n"
    'Password hashing (argon2/bcrypt)' = @(
        'Co to je: Bezpečné jednosměrné hashování hesel.'
        'Kdy zvolit: Vždy, když ukládáš heslo - bez výjimky.'
        'Plus: I při úniku databáze jsou hesla nepoužitelná.'
        'Pozor: Argon2 nebo bcrypt, nikdy SHA256; nutné správně nastavit parametry.'
    ) -join "`n"

    'Vercel Analytics' = @(
        'Co to je: Nativní analytika Vercelu bez cookies.'
        'Kdy zvolit: Chceš rychlý přehled o návštěvnosti bez složitého nastavení.'
        'Plus: Bez cookies, tedy méně problémů s GDPR, nulová konfigurace.'
        'Pozor: Méně detailů než GA4, žádné pokročilé konverzní analýzy.'
    ) -join "`n"
    'Vercel Speed Insights' = @(
        'Co to je: Měření Core Web Vitals v reálném provozu.'
        'Kdy zvolit: Chceš vědět, jak rychlost vnímají skuteční uživatelé.'
        'Plus: Zaměřené na to, co má dopad na SEO i konverze.'
        'Pozor: Je to metrika, ne řešení - nutné pak optimalizovat.'
    ) -join "`n"
    'Google Analytics 4' = @(
        'Co to je: Komplexní analytika s událostmi a konverzemi.'
        'Kdy zvolit: Marketing potřebuje detailní data, kampaně a atribuci.'
        'Plus: Nejhlubší analytika zdarma, integrace s reklamními systémy.'
        'Pozor: Nutný souhlas podle GDPR, složitější UI, datová kvalita vyžaduje péči.'
    ) -join "`n"
    'Sentry (chyby)' = @(
        'Co to je: Sledování chyb a výjimek včetně kontextu a stack trace.'
        'Kdy zvolit: Vždy v produkci - bez toho ladíš naslepo.'
        'Plus: Okamžité upozornění na chybu, source maps, seskupení stejných chyb.'
        'Pozor: Pozor na odesílání osobních údajů, nutné filtrovat citlivá data.'
    ) -join "`n"
    'PostHog (product analytics)' = @(
        'Co to je: Produktová analytika, lepší alternativa k Amplitude.'
        'Kdy zvolit: Chceš sledovat chování v produktu a vyhodnocovat funkce.'
        'Plus: Session replay, funnel analýzy, feature flags, možnost self-hostingu.'
        'Pozor: Vyžaduje promyšlený plán událostí, jinak jsou data nepoužitelná.'
    ) -join "`n"
    'OpenTelemetry (tracing)' = @(
        'Co to je: Vendor-neutralní standard pro trasování a metriky.'
        'Kdy zvolit: Více služeb, složité toky, potřeba dohledat, kde se ztrácí čas.'
        'Plus: Otevřený standard, žádné uzamčení, funguje s mnoha backendy.'
        'Pozor: Náročné na správné instrumentaci, režie na výkon.'
    ) -join "`n"
    'Pino (JSON logy)' = @(
        'Co to je: Nejrychlejší logger pro Node.js s výstupem ve strukturovaném JSON.'
        'Kdy zvolit: Serverové logování, kde záleží na výkonu a strojovém zpracování.'
        'Plus: Minimální režie, strukturované logy, snadné napojení na agregaci.'
        'Pozor: Čitelnost v konzoli je horší, použij pino-pretty jen lokálně.'
    ) -join "`n"
    'Winston' = @(
        'Co to je: Zavedený logger s flexibilními transporty.'
        'Kdy zvolit: Potřebuješ více cílů výstupu a vlastní formátování.'
        'Plus: Bohaté možnosti transportů a formátů, vyspělé a dobře zdokumentované.'
        'Pozor: Pomalejší a těžkopádnější než Pino, pro nové projekty obvykle zbytečný.'
    ) -join "`n"
    'Grafana / Prometheus (metriky)' = @(
        'Co to je: Sběr číselných metrik v čase a jejich vizualizace v dashboardech.'
        'Kdy zvolit: Chceš sledovat trendy, kapacitu a výkon v čase.'
        'Plus: Výkonné dotazování, alerty, možnost self-hostingu.'
        'Pozor: Prometheus není pro dlouhodobé uchování - nutné řešit retenci.'
    ) -join "`n"
    'Axiom / Logtail (aggregation)' = @(
        'Co to je: Centrální sběr a vyhledávání logů.'
        'Kdy zvolit: Logy z více prostředí na jednom místě s rychlým hledáním.'
        'Plus: Snadné nasazení, rychlé dotazy, dobrý poměr ceny a výkonu.'
        'Pozor: Objem logů přímo ovlivňuje cenu - loguj účelně.'
    ) -join "`n"
    'Datadog' = @(
        'Co to je: Enterprise platforma pro observability - metriky, logy, tracing, APM.'
        'Kdy zvolit: Větší organizace s potřebou jednoho místa pro vše.'
        'Plus: Špičková integrace a korelace, hotové dashboardy a alerty.'
        'Pozor: Nejvyšší cena, uzamčení na jednoho dodavatele, složitá konfigurace.'
    ) -join "`n"
    'Loki' = @(
        'Co to je: Logovací systém od Grafanu indexující jen popisky, ne obsah.'
        'Kdy zvolit: Máš Grafanu a nechceš platit za indexaci celého textu.'
        'Plus: Nízké náklady na uložení, přirozeně navazuje na Grafana stack.'
        'Pozor: Vyhledávání podle textu je pomalejší, kvalita popisků je klíčová.'
    ) -join "`n"

    'GDPR (cookie consent, RLS)' = @(
        'Co to je: Soulad s GDPR - souhlas s cookies a práva na úrovni dat.'
        'Kdy zvolit: Zpracováváš data osob v EU, a to i mimo EU subjekt.'
        'Plus: Snižuje právní riziko, zvyšuje důvěru uživatelů.'
        'Pozor: Samotný cookie banner nestačí - nutná evidence zpracování a retence.'
    ) -join "`n"
    'Audit trail (kdo co změnil)' = @(
        'Co to je: Záznam změn s informací o autorovi, času a původních hodnotách.'
        'Kdy zvolit: Sdílená data, finanční operace, jakákoli citlivá administrace.'
        'Plus: Umožní zpětné dohledání, obnovu hodnot i vyšetření incidentu.'
        'Pozor: Sám o sobě nestačí - musí být neměnný a s řízeným přístupem.'
    ) -join "`n"
    'Data retention policy' = @(
        'Co to je: Pravidla, jak dlouho se data uchovávají a kdy se mažou.'
        'Kdy zvolit: Ukládáš logy, analytiku, historii objednávek nebo dokumenty.'
        'Plus: Snížení rizika i nákladů, soulad s GDPR, přehlednější databáze.'
        'Pozor: Automatické mazání je nevratné - nutné mít zálohy a výjimky pro spory.'
    ) -join "`n"
    'Backup & disaster recovery' = @(
        'Co to je: Pravidelné zálohy a ověřený postup obnovy.'
        'Kdy zvolit: Vždy, když jsou v systému data, o která bys nechtěl přijít.'
        'Plus: Ochrana před selháním, chybným smazáním i lidskou chybou.'
        'Pozor: Neověřená záloha není záloha - pravidelně testuj obnovu.'
    ) -join "`n"
    'SOC2 ready' = @(
        'Co to je: Nastavení procesů a kontrol pro SOC2 audit.'
        'Kdy zvolit: Prodáváš B2B zákazníkům, kteří vyžadují bezpečnostní audit.'
        'Plus: Otevírá cestu k větším zákazníkům, zvyšuje důvěryhodnost.'
        'Pozor: Náročné na dokumentaci i procesy, nutné průběžně udržovat.'
    ) -join "`n"
    'AI cost tracking' = @(
        'Co to je: Sledování nákladů na volání jazykových modelů.'
        'Kdy zvolit: Používáš LLM v produkci, kde náklady rostou s uživateli.'
        'Plus: Umožní nastavit limity, odhalit plýtvání a plánovat cenu.'
        'Pozor: Nutné logovat tokeny a model u každého volání, jinak nemáš data.'
    ) -join "`n"
}

# ---- Funkce: správa obsahu, administrace, byznys funkce, AI, A/B testování ----
$script:helpDetailSets += @{
    'Vlastní DB + Administrace' = @(
        'Co to je: Obsah i data v databázi, spravované přes vlastní admin sekci.'
        'Kdy zvolit: Strukturovaná data, kde admin potřebuje specifické formuláře a workflow.'
        'Plus: Plná kontrola, přesně podle domény, žádný vendor lock-in.'
        'Pozor: Nejdražší varianta - musíš postavit CRUD, práva i validace.'
    ) -join "`n"
    'Lokální soubory (MDX / Markdown)' = @(
        'Co to je: Obsah uložený v repozitáři jako MDX nebo Markdown soubory.'
        'Kdy zvolit: Blog, dokumentace, stránky měněné při deployi.'
        'Plus: Verzování v gitu, review změn, žádná další infrastruktura.'
        'Pozor: Změna obsahu vyžaduje commit a deploy; nevhodné pro netechnické editory.'
    ) -join "`n"
    'Headless CMS (Sanity / Strapi / Payload)' = @(
        'Co to je: Samostatné CMS poskytující obsah přes API.'
        'Kdy zvolit: Netechničtí editoři, vícejazyčný obsah, oddělení obsahu od kódu.'
        'Plus: Editor bez znalosti kódu, strukturovaný obsah, náhledy a plánování.'
        'Pozor: Další služba k provozu a placení, nutné řešit náhledy a webhooky.'
    ) -join "`n"
    'JSON Slovníky (i18n pro UI texty)' = @(
        'Co to je: Texty rozhraní v JSON souborech, oddělené od komponent.'
        'Kdy zvolit: Vždy, když plánuješ více jazyků nebo chceš snadné korektury textů.'
        'Plus: Texty mění i neprogramátor, žádné zásahy do komponent.'
        'Pozor: Nutné udržovat klíče v pořádku a hlídat chybějící překlady.'
    ) -join "`n"
    'Git-based CMS (TinaCMS / Decap)' = @(
        'Co to je: Editor, který ukládá změny obsahu jako commity do gitu.'
        'Kdy zvolit: Chceš pohodlnou editaci a zároveň verzování v repozitáři.'
        'Plus: Historie obsahu v gitu, žádná databáze, dobrá kontrola změn.'
        'Pozor: Každá úprava vytváří commit a spouští build, méně vhodné pro velký obsah.'
    ) -join "`n"
    'Hardcoded (neřešit)' = @(
        'Co to je: Texty a obsah přímo v kódu.'
        'Kdy zvolit: Nikdy u produktu; jen u prototypu nebo jednorázového nástroje.'
        'Plus: Nejméně práce při prvním napsání.'
        'Pozor: Každá změna textu je deploy; dodatečné zavedení i18n je pak drahé.'
    ) -join "`n"

    'TipTap (headless, vlastní UI)' = @(
        'Co to je: Headless WYSIWYG editor s vlastním UI nad ProseMirror.'
        'Kdy zvolit: Chceš editor na míru, vlastní rozšíření a přesnou kontrolu nad výstupem.'
        'Plus: Velmi flexibilní, aktivní vývoj, dobrá práce s JSON obsahem.'
        'Pozor: UI a toolbar si stavíš sám, bez sanitizace hrozí XSS.'
    ) -join "`n"
    'Lexical (Meta)' = @(
        'Co to je: Editor framework od Meta zaměřený na výkon a přístupnost.'
        'Kdy zvolit: Náročný editor s velkým obsahem, kde záleží na výkonu.'
        'Plus: Velmi rychlý, řeší kolaboraci i přístupnost, moderní architektura.'
        'Pozor: Nižší úroveň, více kódu k napsání, méně hotových příkladů než TipTap.'
    ) -join "`n"
    'Slate.js' = @(
        'Co to je: Framework pro stavbu vlastních editorů s vlastním modelem dokumentu.'
        'Kdy zvolit: Potřebuješ velmi specifické chování, které hotové editory neumí.'
        'Plus: Nejvyšší míra přizpůsobení, čistý datový model.'
        'Pozor: Většinu funkcí píšeš sám, strmější křivka učení.'
    ) -join "`n"
    'Quill' = @(
        'Co to je: Zavedený WYSIWYG editor s hotovým UI.'
        'Kdy zvolit: Potřebuješ rychle funkční editor bez zvláštních požadavků.'
        'Plus: Nejrychlejší nasazení, stabilní, dobře zdokumentovaný.'
        'Pozor: Vlastní rozšíření jsou obtížná, výstup je HTML - nutná sanitizace.'
    ) -join "`n"
    'Žádný (pouze MDX)' = @(
        'Co to je: Bez editoru, obsah se píše v MDX.'
        'Kdy zvolit: Vývojářský blog, dokumentace, technický obsah.'
        'Plus: Nulová režie, obsah je součástí kódu, snadné review.'
        'Pozor: Netechnický editor nezvládne, nelze publikovat ze dne na den.'
    ) -join "`n"

    'Vlastní admin-kit (custom)' = @(
        'Co to je: Vlastní sada admin komponent a layoutu.'
        'Kdy zvolit: Admin má specifické požadavky a nechceš se přizpůsobovat frameworku.'
        'Plus: Přesně podle potřeb, jednotný design s hlavní aplikací.'
        'Pozor: Nejdražší varianta, tabulky, filtry a práva si postavíš sám.'
    ) -join "`n"
    'Refine.dev' = @(
        'Co to je: React framework pro admin panely s hotovými CRUD obrazovkami.'
        'Kdy zvolit: Potřebuješ rychle postavit datově orientovanou administraci.'
        'Plus: Hotové tabulky, formuláře i napojení na API, ušetří týdny práce.'
        'Pozor: Vlastní koncepty k naučení, méně vhodné na jednoduchý admin.'
    ) -join "`n"
    'React Admin' = @(
        'Co to je: Zavedený framework pro administrace nad REST nebo GraphQL.'
        'Kdy zvolit: Tabulkový admin s CRUD a filtry, kde stačí konvence.'
        'Plus: Velmi rychlý start, obrovská nabídka hotových komponent.'
        'Pozor: Silné konvence omezují vlastní UX, starší ekosystém.'
    ) -join "`n"
    'AdminJS' = @(
        'Co to je: Administrace generovaná automaticky ze schématu databáze.'
        'Kdy zvolit: Potřebuješ základní správu dat okamžitě, bez návrhu UI.'
        'Plus: Nejméně práce, vznikne za minuty, dá se rozšiřovat.'
        'Pozor: Vzhled i chování jsou dané, méně vhodné pro koncové zákazníky.'
    ) -join "`n"
    'Payload CMS (admin v ceně)' = @(
        'Co to je: Headless CMS s vlastním admin panelem a konfigurací v kódu.'
        'Kdy zvolit: Chceš CMS i admin v jednom, s plnou kontrolou nad datovým modelem.'
        'Plus: Admin zdarma k CMS, konfigurace v TypeScriptu, dobrá práce s Next.js.'
        'Pozor: Silná vazba na Payload, migrace jinam je pracná.'
    ) -join "`n"

    'Nativní (Next.js metadata / Nuxt useHead)' = @(
        'Co to je: Využití vestavěného API frameworku pro meta tagy.'
        'Kdy zvolit: Běžné SEO potřeby bez zvláštních požadavků.'
        'Plus: Žádná závislost, typová kontrola, dobře dokumentované.'
        'Pozor: U dynamických hlaviček a deduplikace tagů je méně pohodlné.'
    ) -join "`n"
    'Unhead (deduplikace + async aware)' = @(
        'Co to je: Knihovna pro správu hlaviček s deduplikací a podporou asynchronních dat.'
        'Kdy zvolit: Složitější SEO s dynamickými a vnořenými komponentami.'
        'Plus: Řeší duplicitní tagy i pořadí, funguje na serveru i klientu.'
        'Pozor: Další závislost a abstrakce, u jednoduchého webu zbytečné.'
    ) -join "`n"
    'next-seo / vue-seo' = @(
        'Co to je: Komponenta pro deklarativní zápis SEO tagů.'
        'Kdy zvolit: Chceš přehledně definovat meta tagy a Open Graph na stránce.'
        'Plus: Čitelný zápis, méně opakování, rychlé nasazení.'
        'Pozor: Používá se méně než dřív, u nových projektů preferuj nativní API.'
    ) -join "`n"
    'Ruční správa (vlastní komponenta)' = @(
        'Co to je: Vlastní komponenta, která vypisuje tagy do hlavičky.'
        'Kdy zvolit: Speciální požadavky, které hotové knihovny neřeší.'
        'Plus: Plná kontrola nad výsledným HTML, žádná závislost.'
        'Pozor: Deduplikace a řazení tagů jsou na tobě, snadno vznikne duplicita.'
    ) -join "`n"

    'Dashboard (Statistiky, grafy)' = @(
        'Co to je: Přehledová stránka s klíčovými čísly a grafy.'
        'Kdy zvolit: Uživatelé nebo provoz potřebují rychlý přehled o stavu.'
        'Plus: Rychlá orientace, odhalení trendů, podklad pro rozhodování.'
        'Pozor: Náročné dotazy - používej agregace, cache a materializované pohledy.'
    ) -join "`n"
    'Správa uživatelů (Tabulky)' = @(
        'Co to je: CRUD nad uživateli včetně rolí a stavu účtu.'
        'Kdy zvolit: Máš role, pozvánky, blokování nebo ruční zásahy do účtů.'
        'Plus: Nezbytnost pro provoz produktu, základ podpory zákazníků.'
        'Pozor: Vysoce citlivá data - striktní práva, audit a ochrana osobních údajů.'
    ) -join "`n"
    'Auditní Log (Historie změn)' = @(
        'Co to je: Přehled změn, kteří uživatelé provedli.'
        'Kdy zvolit: Sdílená data, více rolí, potřeba dohledat, kdo co změnil.'
        'Plus: Ochrana před obviněním, možnost dohledat chybu, soulad s audity.'
        'Pozor: Ukládá osobní údaje - nastav retenci a omezený přístup.'
    ) -join "`n"
    'Import/Export dat (CSV/Excel)' = @(
        'Co to je: Hromadné načítání a stahování dat.'
        'Kdy zvolit: Migrace dat, dávkové úpravy, reporting pro zákazníka.'
        'Plus: Nezbytné pro onboarding i pro účetnictví, výrazně šetří čas.'
        'Pozor: Validuj každý řádek, řeš duplicity a časový limit u velkých souborů.'
    ) -join "`n"
    'Feature flags (LaunchDarkly / vlastní)' = @(
        'Co to je: Zapínání funkcí bez nasazení nové verze.'
        'Kdy zvolit: Postupné zavádění, testování u části uživatelů, rychlé vypnutí rizika.'
        'Plus: Snižuje riziko nasazení, umožňuje okamžitý rollback funkce.'
        'Pozor: Vzniká technický dluh - staré flagy je nutné odstraňovat.'
    ) -join "`n"
    'Upload souborů (S3/Supabase/Blob)' = @(
        'Co to je: Nahrávání souborů do objektového úložiště.'
        'Kdy zvolit: Avatary, přílohy, dokumenty, obrázky produktů.'
        'Plus: Oddělení souborů od aplikace, škálovatelné a levné úložiště.'
        'Pozor: Řeš omezení typu a velikosti, viry, přístupová práva a úklid osiřelých souborů.'
    ) -join "`n"
    'Platby (Stripe)' = @(
        'Co to je: Integrace platební brány pro jednorázové i opakované platby.'
        'Kdy zvolit: Prodáváš produkty, předplatné nebo služby.'
        'Plus: Hotová bezpečnost a PCI compliance, široká podpora metod.'
        'Pozor: Částky v minor units, webhooky musí být idempotentní, pozor na DPH.'
    ) -join "`n"
    'E-maily (Resend / Postmark)' = @(
        'Co to je: Odesílání transakčních e-mailů přes specializovanou službu.'
        'Kdy zvolit: Potvrzení objednávek, reset hesla, pozvánky, notifikace.'
        'Plus: Vysoká doručitelnost, šablony, přehled o doručení a chybách.'
        'Pozor: Nutné nastavit SPF, DKIM a DMARC, jinak e-maily padají do spamu.'
    ) -join "`n"
    'PDF generování' = @(
        'Co to je: Generování PDF dokumentů na serveru.'
        'Kdy zvolit: Faktury, certifikáty, smlouvy, reporty ke stažení.'
        'Plus: Přesná podoba dokumentu, možnost archivace a tisku.'
        'Pozor: Fonty s diakritikou, stránkování a výkon u velkých dávek.'
    ) -join "`n"
    'Notifikace (push/email/SMS)' = @(
        'Co to je: Vícekanálové upozorňování uživatelů.'
        'Kdy zvolit: Rezervace, objednávky, změny stavu, důležité události.'
        'Plus: Uživatel se dozví o změně, méně zmeškaných událostí.'
        'Pozor: Každý kanál má vlastní souhlas a náklady, pozor na zahlcení.'
    ) -join "`n"
    'Full-text vyhledávání (Meilisearch)' = @(
        'Co to je: Specializovaný vyhledávač s tolerancí k překlepům.'
        'Kdy zvolit: Katalog produktů, obsah, dokumenty - kde LIKE nestačí.'
        'Plus: Velmi rychlé, zvládá diakritiku a překlepy, snadné nasazení.'
        'Pozor: Další služba, nutná synchronizace indexu s databází.'
    ) -join "`n"

    'Vercel AI SDK' = @(
        'Co to je: SDK pro streaming AI odpovědí a sjednocení poskytovatelů.'
        'Kdy zvolit: Chat, generování textu, AI funkce v Next.js nebo Reactu.'
        'Plus: Jednotné API nad modely, streaming a nástroje v ceně.'
        'Pozor: Abstrakce skrývá specifika poskytovatelů, u pokročilých funkcí limituje.'
    ) -join "`n"
    'OpenAI API' = @(
        'Co to je: Modely GPT pro text, obrázky, přepis a embeddingy.'
        'Kdy zvolit: Obecné AI funkce, kde potřebuješ širokou podporu a ekosystém.'
        'Plus: Nejlepší ekosystém a dokumentace, široká nabídka modelů.'
        'Pozor: Data mimo EU, náklady rostou s tokeny, nutné hlídat limity.'
    ) -join "`n"
    'Anthropic Claude API' = @(
        'Co to je: Modely Claude zaměřené na dlouhý kontext a práci s kódem.'
        'Kdy zvolit: Analýza dlouhých dokumentů, kódování, pečlivé uvažování.'
        'Plus: Velmi dlouhý kontext, kvalitní výstup u kódu a analýzy.'
        'Pozor: Vyšší cena u nejsilnějších modelů, jiné chování promptů než u GPT.'
    ) -join "`n"
    'RAG (Vektorová databáze)' = @(
        'Co to je: Doplňování modelu o vlastní data přes vyhledání relevantních částí.'
        'Kdy zvolit: Dotazy nad firemními dokumenty, produkty, znalostní bází.'
        'Plus: Odpovědi z tvých dat, méně halucinací, možnost citovat zdroje.'
        'Pozor: Kvalita závisí na dělení textu, aktualizaci indexu a kvalitě embeddingů.'
    ) -join "`n"
    'Ollama (lokální modely)' = @(
        'Co to je: Spouštění open-source modelů lokálně nebo na vlastním serveru.'
        'Kdy zvolit: Citlivá data nesmí opustit infrastrukturu, nebo chceš nulové náklady na tokeny.'
        'Plus: Soukromí dat, žádné náklady za volání, offline provoz.'
        'Pozor: Nutný výkonný hardware, nižší kvalita než nejlepší hostované modely.'
    ) -join "`n"
    'LangChain / LangGraph' = @(
        'Co to je: Framework pro řetězení volání modelů, nástrojů a agentní logiky.'
        'Kdy zvolit: Složitější AI workflow s více kroky, nástroji a stavem.'
        'Plus: Hotové integrace a vzory pro agenty, rychlejší stavba pipeline.'
        'Pozor: Rychle se mění API, abstrakce ztěžuje ladění a může omezovat.'
    ) -join "`n"
    'MCP Server (Model Context Protocol)' = @(
        'Co to je: Standard pro připojení AI k nástrojům a datům.'
        'Kdy zvolit: Chceš, aby AI agenti bezpečně používali tvoje nástroje nebo data.'
        'Plus: Otevřený standard podporovaný více nástroji, znovupoužitelné integrace.'
        'Pozor: Nutné striktně omezit oprávnění nástrojů a logovat volání.'
    ) -join "`n"

    'Žádné' = @(
        'Co to je: Bez A/B testování.'
        'Kdy zvolit: Malá návštěvnost, raná fáze, nebo když nemáš hypotézy k testování.'
        'Plus: Žádná režie, jednodušší kód i analytika.'
        'Pozor: Rozhodnutí o designu a textacích pak děláš podle dojmu, ne dat.'
    ) -join "`n"
    'PostHog (feature flags + experiments)' = @(
        'Co to je: A/B testování a feature flags v jedné platformě s produktovou analytikou.'
        'Kdy zvolit: Chceš testovat varianty a zároveň vidět chování v produktu.'
        'Plus: Vše v jednom, session replay, možnost self-hostingu.'
        'Pozor: Nutná správná definice metriky, jinak jsou výsledky zavádějící.'
    ) -join "`n"
    'GrowthBook (self-hosted)' = @(
        'Co to je: Self-hosted platforma pro A/B testy a feature flags.'
        'Kdy zvolit: Data nesmí opustit infrastrukturu, ale chceš statistické vyhodnocení.'
        'Plus: Plná kontrola nad daty, Bayesovská statistika, otevřený zdrojový kód.'
        'Pozor: Nutné provozovat a udržovat, méně hotových integrací.'
    ) -join "`n"
    'Statsig' = @(
        'Co to je: Moderní platforma pro experimenty, feature gates a metriky.'
        'Kdy zvolit: Větší tým, který experimentuje pravidelně a potřebuje spolehlivé výsledky.'
        'Plus: Kvalitní statistika, správa experimentů i konfigurací na jednom místě.'
        'Pozor: Placené podle objemu, další platforma k obsluze.'
    ) -join "`n"
    'Vlastní (DB + middleware)' = @(
        'Co to je: Vlastní rozdělování variant a vyhodnocování.'
        'Kdy zvolit: Velmi specifické požadavky, malý počet jednoduchých testů.'
        'Plus: Žádné náklady navíc, plná kontrola nad logikou.'
        'Pozor: Snadno vznikne statisticky neplatný test, chybí správa i reporting.'
    ) -join "`n"
}

# ---- Mobil: platforma, funkce, distribuce, navigace, UI, stav, auth ----
$script:helpDetailSets += @{
    'Žádná (pouze web)' = @(
        'Co to je: Bez mobilní aplikace, pouze responzivní web.'
        'Kdy zvolit: Rozpočet nebo čas nedovolí nativní aplikaci, obsah je dostupný na webu.'
        'Plus: Nejnižší náklady, jedna codebase, žádné schvalování v obchodech.'
        'Pozor: Chybí push notifikace, přístup k hardwaru a ikona na ploše.'
    ) -join "`n"
    'React Native + Expo (SDK 57+)' = @(
        'Co to je: Nativní aplikace v Reactu s nástroji a cloudovými buildy Expo.'
        'Kdy zvolit: Doporučená volba pro nový mobil - sdílíš typy i logiku s webem.'
        'Plus: OTA aktualizace, snadné buildy, bohatá nabídka hotových modulů.'
        'Pozor: Omezení u exotických nativních modulů, nutné sledovat verze SDK.'
    ) -join "`n"
    'React Native (bare, bez Expo)' = @(
        'Co to je: Čistý React Native s plnou kontrolou nad nativními projekty.'
        'Kdy zvolit: Potřebuješ vlastní nativní modul nebo specifické SDK třetí strany.'
        'Plus: Naprostá kontrola nad Android i iOS projektem, žádná omezení Expo.'
        'Pozor: Ruční správa buildů, certifikátů i aktualizací - více práce.'
    ) -join "`n"
    'Flutter' = @(
        'Co to je: Framework od Googlu s vlastním renderovacím enginem a jazykem Dart.'
        'Kdy zvolit: Chceš identické UI na obou platformách a vysoký výkon.'
        'Plus: Konzistentní vzhled, výborný výkon, kvalitní hotové widgety.'
        'Pozor: Jiný jazyk než web, nelze sdílet kód s TypeScript backendem.'
    ) -join "`n"
    'Capacitor (web → nativní)' = @(
        'Co to je: Zabalení existujícího webu do nativního shellu.'
        'Kdy zvolit: Už máš hotový web a potřebuješ rychle aplikaci do obchodů.'
        'Plus: Nejrychlejší cesta k aplikaci, sdílený kód s webem na maximum.'
        'Pozor: Výkon a pocit z aplikace jsou horší, nativní funkce jsou omezené.'
    ) -join "`n"

    'Offline drafty (AsyncStorage)' = @(
        'Co to je: Ukládání neuložených dat lokálně pro offline práci.'
        'Kdy zvolit: Uživatelé pracují v terénu, ve výtahu nebo se slabým signálem.'
        'Plus: Práce nezanikne při výpadku sítě, lepší dojem z aplikace.'
        'Pozor: Nutné řešit konflikty při synchronizaci a stav neuložených dat.'
    ) -join "`n"
    'SecureStore pro tokeny' = @(
        'Co to je: Šifrované úložiště pro přihlašovací tokeny na zařízení.'
        'Kdy zvolit: Vždy, když aplikace ukládá tokeny - je to bezpečnostní minimum.'
        'Plus: Tokeny jsou chráněné biometrií nebo klíčem zařízení.'
        'Pozor: Nikdy neukládej tokeny do AsyncStorage ani do běžných souborů.'
    ) -join "`n"
    'Push notifikace (Expo Notifications)' = @(
        'Co to je: Doručování upozornění na zařízení.'
        'Kdy zvolit: Rezervace, objednávky, chat, změny stavu, marketing.'
        'Plus: Vysoká míra zobrazení, přivede uživatele zpět do aplikace.'
        'Pozor: Vyžaduje souhlas, nutné řešit segmentaci, jinak uživatel notifikace vypne.'
    ) -join "`n"
    'Sdílené API s webem' = @(
        'Co to je: Web i mobil používají stejné endpointy.'
        'Kdy zvolit: Máš web i mobil a chceš jednu business logiku.'
        'Plus: Méně kódu, konzistentní pravidla a data, rychlejší vývoj.'
        'Pozor: API musí vyhovět oběma klientům, složitější verzování.'
    ) -join "`n"
    'Dark/Light/System téma' = @(
        'Co to je: Podpora světlého, tmavého i systémového režimu.'
        'Kdy zvolit: Moderní aplikace - uživatelé to dnes očekávají.'
        'Plus: Lepší čitelnost podle prostředí, vyšší spokojenost uživatelů.'
        'Pozor: Každá barva musí projít v obou režimech, náročné na kontrolu kontrastu.'
    ) -join "`n"
    'Biometrické přihlášení' = @(
        'Co to je: Přihlášení pomocí otisku prstu nebo obličeje.'
        'Kdy zvolit: Uživatel se přihlašuje často, nebo jde o citlivá data.'
        'Plus: Velmi rychlé a bezpečné, méně zapomenutých hesel.'
        'Pozor: Vždy potřebuje záložní metodu (PIN nebo heslo) pro případ selhání.'
    ) -join "`n"
    'Deep linking' = @(
        'Co to je: Otevření konkrétní obrazovky aplikace přes odkaz.'
        'Kdy zvolit: Posíláte odkazy v e-mailech, notifikacích nebo na webu.'
        'Plus: Plynulý přechod z webu do aplikace, lepší marketingové kampaně.'
        'Pozor: Nutné ošetřit neplatné odkazy, přihlášení a stav aplikace.'
    ) -join "`n"
    'Photo picker / Camera' = @(
        'Co to je: Přístup k fotoaparátu a galerii uživatele.'
        'Kdy zvolit: Nahrávání fotek, skenování dokladů, avatary, přílohy.'
        'Plus: Zásadně zjednoduší vkládání obsahu na mobilu.'
        'Pozor: Vyžaduje oprávnění a vysvětlení účelu, nutné omezit velikost a komprimovat.'
    ) -join "`n"

    'Expo EAS Build (cloud)' = @(
        'Co to je: Cloudové buildy aplikace přes Expo Application Services.'
        'Kdy zvolit: Nechceš řešit Xcode a lokální build řetězce.'
        'Plus: Build z jakéhokoli systému, profily pro náhled i produkci, OTA aktualizace.'
        'Pozor: Placené minutové kvóty, buildy čekají ve frontě.'
    ) -join "`n"
    'GitHub Actions + prebuild (APK)' = @(
        'Co to je: Build aplikace v GitHub Actions včetně generování nativních projektů.'
        'Kdy zvolit: Chceš buildy plně ve svém CI bez cloudové služby.'
        'Plus: Bez dalších nákladů, plná kontrola nad pipeline.'
        'Pozor: iOS build potřebuje macOS runner, složitější nastavení podpisu.'
    ) -join "`n"
    'App Store / Google Play' = @(
        'Co to je: Veřejná distribuce přes oficiální obchody s aplikacemi.'
        'Kdy zvolit: Aplikace pro koncové zákazníky.'
        'Plus: Důvěra uživatelů, vyhledatelnost, platby v aplikaci.'
        'Pozor: Schvalovací procesy, poplatky, delší doba zveřejnění aktualizace.'
    ) -join "`n"
    'Interní distribuce (Firebase)' = @(
        'Co to je: Distribuce k testerům mimo veřejné obchody.'
        'Kdy zvolit: Testování před vydáním, interní firemní aplikace.'
        'Plus: Rychlé doručení buildu, žádné schvalování, snadná správa testerů.'
        'Pozor: Nevhodné pro koncové uživatele, na iOS nutné registrované zařízení.'
    ) -join "`n"

    'Expo Router (file-based)' = @(
        'Co to je: Navigace podle struktury souborů, podobně jako v Next.js.'
        'Kdy zvolit: Nový projekt s Expo - je to doporučený přístup.'
        'Plus: Čitelné a předvídatelné routy, deep linking zdarma, méně konfigurace.'
        'Pozor: Nutné pochopit layout soubory, méně vhodné pro dynamické scénáře.'
    ) -join "`n"
    'React Navigation' = @(
        'Co to je: Zavedená knihovna pro navigaci, nad kterou stojí i Expo Router.'
        'Kdy zvolit: Potřebuješ specifické chování nebo už projekt používáš.'
        'Plus: Nejflexibilnější, obrovská komunita a dokumentace.'
        'Pozor: Verbóznější konfigurace, deep linking si nastavuješ sám.'
    ) -join "`n"
    'Vlastní stack' = @(
        'Co to je: Vlastní implementace navigační logiky.'
        'Kdy zvolit: Velmi specifické požadavky, které hotové knihovny neumí.'
        'Plus: Naprostá kontrola nad přechody i stavem.'
        'Pozor: Ztrácíš podporu zařízení - tlačítko zpět, gesta, obnovení stavu.'
    ) -join "`n"
    'Tabs + Stack kombinace' = @(
        'Co to je: Spodní taby s vnořenými stacky obrazovek.'
        'Kdy zvolit: Většina aplikací - hlavní sekce v tabech, detaily ve stacku.'
        'Plus: Uživatelé jsou na to zvyklí, přehledná struktura.'
        'Pozor: Hluboké vnoření mate uživatele, nutné hlídat historii.'
    ) -join "`n"

    'React Native Paper' = @(
        'Co to je: Komponenty v duchu Material Design pro React Native.'
        'Kdy zvolit: Android-first aplikace, kde chceš hotové a přístupné komponenty.'
        'Plus: Vyspělé komponenty, dobrá přístupnost, tmavý režim.'
        'Pozor: Výrazný material vzhled, přizpůsobení brandu vyžaduje práci.'
    ) -join "`n"
    'NativeBase' = @(
        'Co to je: Knihovna komponent s důrazem na přístupnost.'
        'Kdy zvolit: Chceš hotové komponenty s podporou témat.'
        'Plus: Jednoduché tématizování, slušná nabídka komponent.'
        'Pozor: Vývoj knihovny se zpomalil, zvaž alternativy u nových projektů.'
    ) -join "`n"
    'Tamagui' = @(
        'Co to je: Výkonné UI řešení sdílené mezi React Native a webem.'
        'Kdy zvolit: Chceš jeden design systém pro web i mobil.'
        'Plus: Sdílené komponenty i téma, optimalizovaný výkon, dark mode zdarma.'
        'Pozor: Složitější nastavení buildu, strmější křivka učení.'
    ) -join "`n"
    'Vlastní komponenty' = @(
        'Co to je: Vlastní návrhový systém od základu.'
        'Kdy zvolit: Máš silný brand a chceš odlišný vzhled.'
        'Plus: Naprostá kontrola, žádné přebíjení cizích stylů.'
        'Pozor: Nejdražší - přístupnost a chování na obou platformách řešíš sám.'
    ) -join "`n"
    'Gluestack UI' = @(
        'Co to je: Utility-first komponenty pro React Native s kopírovatelným kódem.'
        'Kdy zvolit: Chceš Tailwind-like přístup i v mobilu.'
        'Plus: Komponenty vlastníš v projektu, konzistentní konfigurace.'
        'Pozor: Menší komunita, méně příkladů a hotových vzorů.'
    ) -join "`n"

    'Zustand + TanStack Query' = @(
        'Co to je: Lehký globální stav plus knihovna pro serverová data.'
        'Kdy zvolit: Doporučená kombinace pro mobil - jasné oddělení dvou druhů stavu.'
        'Plus: Minimum kódu, výborný výkon, přirozené rozdělení odpovědností.'
        'Pozor: Vyžaduje disciplínu neukládat serverová data i do storu.'
    ) -join "`n"
    'Redux Toolkit + RTK Query' = @(
        'Co to je: Redux s RTK Query pro data ze serveru na jednom místě.'
        'Kdy zvolit: Velký tým, který Redux už zná a chce jednotný přístup.'
        'Plus: Jednotné místo pro stav i data, výborné ladění.'
        'Pozor: Více boilerplate a konceptů než kombinace Zustand a TanStack Query.'
    ) -join "`n"
    'Jotai + SWR' = @(
        'Co to je: Atomický stav a lehké načítání dat.'
        'Kdy zvolit: Menší aplikace, kde chceš minimální režii.'
        'Plus: Velmi malé API, přirozená práce s Reactem.'
        'Pozor: Atomický model se u složitého stavu hůř sleduje.'
    ) -join "`n"
    'Context + vlastní fetch' = @(
        'Co to je: Nativní React Context a ruční HTTP volání.'
        'Kdy zvolit: Velmi jednoduchá aplikace s minimem obrazovek.'
        'Plus: Žádné závislosti, plná kontrola.'
        'Pozor: Cache, retry a stavy načítání si píšeš sám - rychle to naroste.'
    ) -join "`n"

    'Bearer tokeny (vlastní JWT)' = @(
        'Co to je: Vlastní přihlášení aplikace pomocí JWT uloženého v SecureStore.'
        'Kdy zvolit: Máš vlastní auth backend nebo specifické požadavky na tokeny.'
        'Plus: Plná kontrola, sdílené API s webem.'
        'Pozor: Nutné řešit obnovu tokenu, odhlášení i bezpečné uložení.'
    ) -join "`n"
    'Expo AuthSession (OAuth)' = @(
        'Co to je: OAuth přihlášení přes systémový prohlížeč spravovaný Expem.'
        'Kdy zvolit: Chceš přihlášení přes Google, Apple nebo GitHub.'
        'Plus: Bezpečný a doporučený způsob OAuth flow na mobilu.'
        'Pozor: Náročnější konfigurace a nutnost vlastního zpracování návratu.'
    ) -join "`n"
    'Supabase Auth (shared)' = @(
        'Co to je: Sdílená autentizace Supabase mezi webem a mobilní aplikací.'
        'Kdy zvolit: Web i mobil používají Supabase a chceš jednoho uživatele všude.'
        'Plus: Jedno zdrojové úložiště uživatelů, podpora mnoha poskytovatelů.'
        'Pozor: Silná vazba na Supabase, nutné řešit expiraci a obnovu session.'
    ) -join "`n"
    'Biometrické + PIN' = @(
        'Co to je: Biometrika jako hlavní metoda a PIN jako záloha.'
        'Kdy zvolit: Citlivá aplikace s častým používáním.'
        'Plus: Nejlepší poměr bezpečnosti a pohodlí pro uživatele.'
        'Pozor: Je nutné ošetřit selhání i změnu biometrie v zařízení.'
    ) -join "`n"
}

# ---- Moduly: domény, e-shop, rezervace, SaaS ----
$script:helpDetailSets += @{
    'Obecná / Univerzální' = @(
        'Co to je: Nespecifikovaná doména bez specializovaných pravidel.'
        'Kdy zvolit: Interní nástroj, prototyp, aplikace bez zvláštní doménové logiky.'
        'Plus: Žádná další pravidla, nejjednodušší a nejrychlejší start.'
        'Pozor: Pokud se doména vyjasní později, je nutné pravidla doplnit dodatečně.'
    ) -join "`n"
    'E-shop / E-commerce' = @(
        'Co to je: Prodej produktů s košíkem, platbami, dopravou a skladem.'
        'Kdy zvolit: Prodáváš fyzické nebo digitální zboží koncovým zákazníkům.'
        'Plus: Přinese hotová doménová pravidla pro ceny, sklad, DPH i vratky.'
        'Pozor: Ceny v minor units, atomická kontrola skladu, idempotentní webhooky plateb.'
    ) -join "`n"
    'Rezervační systém (salon, lékař, restaurace)' = @(
        'Co to je: Rezervace termínů vázané na kapacitu, zdroje nebo osoby.'
        'Kdy zvolit: Služby s časovými sloty - kadeřnictví, ordinace, restaurace, kurzy.'
        'Plus: Přinese pravidla pro časová pásma, souběh a storna.'
        'Pozor: Overbooking je nutné blokovat na úrovni databáze, jinak vznikne kolize.'
    ) -join "`n"
    'SaaS platforma' = @(
        'Co to je: Multi-tenant aplikace s předplatným a plány.'
        'Kdy zvolit: Prodáváš software jako službu více zákazníkům na jednom nasazení.'
        'Plus: Přinese pravidla pro izolaci tenantů, billing a feature gating.'
        'Pozor: Izolace dat a ověřování předplatného na serveru jsou kritické.'
    ) -join "`n"
    'LMS (Learning Management System)' = @(
        'Co to je: Platforma pro kurzy, lekce a sledování pokroku studentů.'
        'Kdy zvolit: Prodáváš nebo provozuješ vzdělávací obsah.'
        'Plus: Přinese pravidla pro video obsah, pokrok, certifikáty a kvízy.'
        'Pozor: Video musí být přes podepsané URL, jinak hrozí šíření obsahu zdarma.'
    ) -join "`n"
    'Sociální síť / Komunita' = @(
        'Co to je: Platforma s obsahem vytvářeným uživateli a vzájemnými interakcemi.'
        'Kdy zvolit: Diskuse, sdílení, sledování, komentáře, zprávy.'
        'Plus: Silná uživatelská angažovanost a síťový efekt.'
        'Pozor: Náročná moderace, právní odpovědnost za obsah, nároky na škálování.'
    ) -join "`n"
    'Blog / Magazín / Média' = @(
        'Co to je: Obsahový web zaměřený na články a publikování.'
        'Kdy zvolit: Publikuješ obsah, řešíš SEO a organickou návštěvnost.'
        'Plus: Nejlepší podmínky pro SEO, snadné cachování, nízké náklady na provoz.'
        'Pozor: Důraz na metadata, sitemap a rychlost načtení.'
    ) -join "`n"
    'Marketplace (více prodejců)' = @(
        'Co to je: Platforma, kde prodává více nezávislých prodejců.'
        'Kdy zvolit: Zprostředkováváš prodej mezi prodejci a zákazníky.'
        'Plus: Škáluješ bez vlastního skladu, provize z každého prodeje.'
        'Pozor: Nejsložitější varianta e-shopu - vypořádání, provize, spory, DPH.'
    ) -join "`n"
    'CRM / Interní nástroj' = @(
        'Co to je: Evidence kontaktů, obchodních příležitostí a interních procesů.'
        'Kdy zvolit: Tým potřebuje evidovat zákazníky, úkoly a komunikaci.'
        'Plus: Nahradí tabulky a e-maily, zprůhlední procesy.'
        'Pozor: Ukládá osobní údaje - nutný audit, práva a retence.'
    ) -join "`n"
    'Portfolio / Prezentační web' = @(
        'Co to je: Statický web představující firmu nebo osobu.'
        'Kdy zvolit: Chceš rychlý a levný web s minimem dynamiky.'
        'Plus: Nejnižší náklady na provoz, výborný výkon, snadná údržba.'
        'Pozor: Minimum funkcí - e-shop nebo admin by znamenaly přepis.'
    ) -join "`n"
    'Booking + platby (kombinace)' = @(
        'Co to je: Rezervace spojená s online platbou, obvykle zálohou.'
        'Kdy zvolit: Chceš snížit počet neuskutečněných rezervací.'
        'Plus: Výrazně snižuje no-show, zajišťuje závazek zákazníka.'
        'Pozor: Nutné řešit vrácení zálohy, storna a soulad s platebními pravidly.'
    ) -join "`n"

    'Product catalog (varianty, SKU)' = @(
        'Co to je: Katalog produktů s variantami, velikostmi a skladovými kódy.'
        'Kdy zvolit: Prodáváš produkty s variantami (barva, velikost, balení).'
        'Plus: Přehledná struktura, správné filtrování, jasná evidence skladu.'
        'Pozor: Model variant je klíčový - špatný návrh se obtížně mění později.'
    ) -join "`n"
    'Košík + checkout flow' = @(
        'Co to je: Nákupní košík s vícekrokovým dokončením objednávky.'
        'Kdy zvolit: Každý e-shop, kde zákazník vybírá více položek.'
        'Plus: Vyšší průměrná objednávka, pohodlný nákup.'
        'Pozor: Košík musí přežít obnovení stránky a odhlášení; doprava a DPH se počítají na serveru.'
    ) -join "`n"
    'Platební brána (Stripe / GoPay)' = @(
        'Co to je: Online platba kartou nebo bankovním převodem.'
        'Kdy zvolit: Chceš okamžité platby místo dobírky a převodů.'
        'Plus: Vyšší konverze, automatické párování plateb, méně ruční práce.'
        'Pozor: Webhooky musí být idempotentní, částky v minor units, pozor na DPH.'
    ) -join "`n"
    'Doprava (Packeta / DPD / PPL)' = @(
        'Co to je: Výběr dopravce včetně ceny, výdejních míst a sledování zásilky.'
        'Kdy zvolit: Prodáváš fyzické zboží s doručením.'
        'Plus: Zákazník si vybere vyhovující možnost, méně dotazů na podporu.'
        'Pozor: Ceny dopravy se musí počítat na serveru, jinak hrozí zneužití.'
    ) -join "`n"
    'Skladové hospodářství' = @(
        'Co to je: Evidence dostupného množství a pohybů skladu.'
        'Kdy zvolit: Prodáváš omezené množství a nechceš prodávat nedostupné zboží.'
        'Plus: Zabraňuje prodeji nedostupného zboží, dává přehled o zásobách.'
        'Pozor: Odečítání musí být atomické, jinak při souběhu prodáš více, než máš.'
    ) -join "`n"
    'Fakturace (Fakturoid / iDoklad)' = @(
        'Co to je: Automatické vystavování faktur přes účetní službu.'
        'Kdy zvolit: Prodáváš firmám nebo potřebuješ daňové doklady.'
        'Plus: Správné náležitosti, méně ruční práce, napojení na účetnictví.'
        'Pozor: Nutné správné sazby DPH včetně reverse charge pro EU B2B.'
    ) -join "`n"
    'Slevové kódy a akce' = @(
        'Co to je: Kupóny, slevy, množstevní zvýhodnění a sezónní akce.'
        'Kdy zvolit: Chceš podpořit konverzi nebo odměnit zákazníky.'
        'Plus: Nástroj pro marketing i retenci, měřitelný dopad na tržby.'
        'Pozor: Kombinovatelnost slev musíš omezit, jinak vzniknou chyby ve výpočtu.'
    ) -join "`n"
    'Recenze produktů' = @(
        'Co to je: Hodnocení a komentáře zákazníků k produktům.'
        'Kdy zvolit: Zákazníci se rozhodují podle zkušeností ostatních.'
        'Plus: Zvyšuje důvěru i konverzi, dobrý zdroj zpětné vazby.'
        'Pozor: Nutná moderace a ověření, že recenze pochází od skutečného zákazníka.'
    ) -join "`n"
    'Wishlist / oblíbené' = @(
        'Co to je: Uložení produktů na později.'
        'Kdy zvolit: Zákazníci zvažují nákup delší dobu nebo nakupují opakovaně.'
        'Plus: Vrací zákazníky zpět, umožňuje cílené připomínky.'
        'Pozor: Bez e-mailové připomínky má funkce malý přínos.'
    ) -join "`n"
    'Porovnání produktů' = @(
        'Co to je: Srovnání parametrů více produktů vedle sebe.'
        'Kdy zvolit: Prodáváš technické zboží s mnoha parametry.'
        'Plus: Pomáhá rozhodování, snižuje počet dotazů na podporu.'
        'Pozor: Vyžaduje konzistentní a úplná data o parametrech.'
    ) -join "`n"
    'Doporučovací engine' = @(
        'Co to je: Personalizovaná doporučení na základě chování a historie.'
        'Kdy zvolit: Máš dostatek dat o nákupech a chceš zvýšit průměrnou objednávku.'
        'Plus: Vyšší konverze i hodnota objednávky, lepší zážitek zákazníka.'
        'Pozor: Bez dat dává špatné výsledky, nutné měřit dopad a hlídat soukromí.'
    ) -join "`n"
    'Abandoned cart recovery' = @(
        'Co to je: Automatické e-maily zákazníkům, kteří nedokončili nákup.'
        'Kdy zvolit: Máš vyšší podíl opuštěných košíků.'
        'Plus: Jeden z nejlepších návratových kanálů, měřitelný přínos.'
        'Pozor: Nutný souhlas s marketingem, jinak jde o nevyžádanou komunikaci.'
    ) -join "`n"

    'Kalendář s časovými sloty' = @(
        'Co to je: Výběr konkrétního termínu a času z nabídky.'
        'Kdy zvolit: Služba vázaná na čas a kapacitu.'
        'Plus: Přehledná rezervace bez telefonátů, méně administrativy.'
        'Pozor: Všechny časy ukládej v UTC, slot musí respektovat časové pásmo zákazníka.'
    ) -join "`n"
    'Správa zaměstnanců / specialistů' = @(
        'Co to je: Přiřazení rezervací konkrétním osobám a jejich rozvrhům.'
        'Kdy zvolit: Různí pracovníci poskytují různé služby v různé časy.'
        'Plus: Přesné plánování kapacity, jasná odpovědnost za termín.'
        'Pozor: Konflikty v rozvrhu musí řešit databáze, ne jen frontend.'
    ) -join "`n"
    'Rezervace + platba (deposit)' = @(
        'Co to je: Požadavek na zálohu při vytvoření rezervace.'
        'Kdy zvolit: Neuskutečněné rezervace tě stojí peníze nebo kapacitu.'
        'Plus: Výrazně snižuje no-show, zajišťuje závazek zákazníka.'
        'Pozor: Nutná jasná storno politika a podmínky vrácení zálohy.'
    ) -join "`n"
    'Přesuny a storna' = @(
        'Co to je: Změna termínu a zrušení rezervace podle pravidel.'
        'Kdy zvolit: Zákazníci potřebují flexibilitu, ale ty chceš chránit kapacitu.'
        'Plus: Méně konfliktů se zákazníky, automatizované uvolnění slotu.'
        'Pozor: Okno pro storno musí být definované a vynucené na serveru.'
    ) -join "`n"
    'SMS / Email reminder' = @(
        'Co to je: Připomínky před termínem.'
        'Kdy zvolit: Zákazníci často zapomínají na rezervaci.'
        'Plus: Nejúčinnější opatření proti no-show, ověřený přínos.'
        'Pozor: SMS jsou placené a vyžadují souhlas, nutné hlídat náklady.'
    ) -join "`n"
    'Google Calendar sync' = @(
        'Co to je: Obousměrná synchronizace termínů s Google Kalendářem.'
        'Kdy zvolit: Zákazníci nebo personál pracují v Google Kalendáři.'
        'Plus: Termín má zákazník i tým na jednom místě, méně přepisování.'
        'Pozor: Synchronizace je náročná - řeš konflikty, opakované události a výpadky.'
    ) -join "`n"
    'Opakované rezervace' = @(
        'Co to je: Pravidelně se opakující termíny podle pravidla.'
        'Kdy zvolit: Pravidelné služby - úklid, tréninky, pravidelné kontroly.'
        'Plus: Méně práce pro zákazníka, vyšší retence.'
        'Pozor: Práce s opakováním a výjimkami je komplexní, nutná knihovna a testy.'
    ) -join "`n"
    'Waitlist (fronta čekajících)' = @(
        'Co to je: Fronta čekajících s automatickým nabídnutím uvolněného místa.'
        'Kdy zvolit: Kapacita je plně obsazená a poptávka převyšuje nabídku.'
        'Plus: Neztrácíš zákazníky ani kapacitu, vyšší využití.'
        'Pozor: Nabídka má časový limit, jinak místo zůstane blokované.'
    ) -join "`n"
    'Dárkové vouchery' = @(
        'Co to je: Prodej a uplatnění dárkových poukazů.'
        'Kdy zvolit: Služby, které se často dávají jako dárek.'
        'Plus: Přináší nové zákazníky, platba předem zlepšuje cashflow.'
        'Pozor: Nutné řešit zůstatek, platnost a částečné čerpání.'
    ) -join "`n"
    'Věrnostní program' = @(
        'Co to je: Body nebo slevy pro opakující se zákazníky.'
        'Kdy zvolit: Zákazníci se vracejí pravidelně a chceš to podpořit.'
        'Plus: Vyšší retence a hodnota zákazníka, měřitelný dopad.'
        'Pozor: Musí mít jasná pravidla a reálnou hodnotu, jinak ho zákazníci ignorují.'
    ) -join "`n"

    'Multi-tenant architektura' = @(
        'Co to je: Jedno nasazení aplikace s izolovanými daty více zákazníků.'
        'Kdy zvolit: SaaS pro mnoho zákazníků s jedním kódem.'
        'Plus: Nižší náklady na zákazníka, jedna verze aplikace k údržbě.'
        'Pozor: Každý dotaz musí být omezen na tenanta, jinak dojde k úniku dat.'
    ) -join "`n"
    'Subscription billing (Stripe Billing)' = @(
        'Co to je: Pravidelné platby a správa životního cyklu předplatného.'
        'Kdy zvolit: Prodáváš opakovanou službu s měsíčním nebo ročním poplatkem.'
        'Plus: Automatické účtování, správa změn plánu i selhání platby.'
        'Pozor: Webhooky ověřuj podpisem a čiň je idempotentními.'
    ) -join "`n"
    'Plány + feature gating' = @(
        'Co to je: Různé úrovně služeb s odlišnými funkcemi.'
        'Kdy zvolit: Chceš nabídnout více cenových úrovní.'
        'Plus: Umožňuje růst příjmů bez změny produktu, jasná diferenciace.'
        'Pozor: Omezení musí být deklarativní a kontrolované na serveru, ne v UI.'
    ) -join "`n"
    'Trial + upgrade/downgrade' = @(
        'Co to je: Zkušební období a změna plánu během předplatného.'
        'Kdy zvolit: Zákazník si potřebuje produkt vyzkoušet a později změnit úroveň.'
        'Plus: Nižší bariéra vstupu, možnost růstu i zmenšení plánu.'
        'Pozor: Změna plánu uprostřed období vyžaduje poměrné vyúčtování.'
    ) -join "`n"
    'Usage-based billing' = @(
        'Co to je: Platba podle skutečné spotřeby služby.'
        'Kdy zvolit: Náklady rostou s používáním - AI volání, úložiště, počet zpráv.'
        'Plus: Spravedlivé pro zákazníka, přirozeně roste s jeho úspěchem.'
        'Pozor: Nutné spolehlivě měřit spotřebu, jinak vznikají spory o fakturu.'
    ) -join "`n"
    'Invoice generování' = @(
        'Co to je: Automatické měsíční faktury za předplatné.'
        'Kdy zvolit: Prodáváš firmám, které potřebují daňový doklad.'
        'Plus: Automatizace účetnictví, soulad s legislativou.'
        'Pozor: Nutné správně řešit DPH, reverse charge a číselné řady dokladů.'
    ) -join "`n"
    'Dunning management' = @(
        'Co to je: Řízené opakování platby při selhání a následné omezení služby.'
        'Kdy zvolit: Máš předplatné a nechceš zákazníka okamžitě odříznout.'
        'Plus: Zachrání část příjmů, dává zákazníkovi prostor situaci vyřešit.'
        'Pozor: Postup musí být jasný a komunikovaný, jinak zákazník odejde.'
    ) -join "`n"
    'Team / organizace' = @(
        'Co to je: Skupiny uživatelů pod jedním účtem nebo tenantem.'
        'Kdy zvolit: Produkt používají týmy, ne jednotlivci.'
        'Plus: Umožňuje spolupráci a centrální správu i fakturaci.'
        'Pozor: Nutné vyřešit vlastnictví, pozvánky, převod účtu a odchod členů.'
    ) -join "`n"
    'Invite systém' = @(
        'Co to je: Zvání nových členů e-mailem.'
        'Kdy zvolit: Týmy rostou postupně a správu mají administrátoři.'
        'Plus: Kontrolovaný přístup, jasná historie pozvánek.'
        'Pozor: Pozvánky musí expirovat a být jednorázové, jinak jde o riziko.'
    ) -join "`n"
    'RBAC per tenant' = @(
        'Co to je: Role definované zvlášť pro každý tenant.'
        'Kdy zvolit: Velké organizace s vlastní strukturou oprávnění.'
        'Plus: Přesná kontrola přístupu, soulad s firemními pravidly.'
        'Pozor: Oprávnění musí být ověřována na serveru u každého požadavku.'
    ) -join "`n"
    'White-label možnost' = @(
        'Co to je: Vlastní branding aplikace pro jednotlivé zákazníky.'
        'Kdy zvolit: Prodáváš platformu jiným firmám pod jejich značkou.'
        'Plus: Zvyšuje hodnotu nabídky, umožňuje vyšší ceny.'
        'Pozor: Branding se musí propsat do e-mailů, PDF i domény - snadno se zapomene.'
    ) -join "`n"
}

# ---- Moduly: LMS, CRM, integrace, marketing, právní požadavky ----
$script:helpDetailSets += @{
    'Kurzy + lekce' = @(
        'Co to je: Struktura vzdělávacího obsahu - kurzy složené z lekcí.'
        'Kdy zvolit: Prodáváš nebo provozuješ výuku v jakékoli podobě.'
        'Plus: Základ LMS - umožňuje prodávat obsah i sledovat pokrok.'
        'Pozor: Struktura musí zvládnout budoucí větvení a doplňkové materiály.'
    ) -join "`n"
    'Video streaming (Mux / Cloudflare)' = @(
        'Co to je: Specializované hostování videa s podepsanými URL.'
        'Kdy zvolit: Video je placený obsah, který se nesmí šířit zdarma.'
        'Plus: Adaptivní kvalita podle připojení, ochrana proti stahování.'
        'Pozor: Náklady rostou s objemem přenesených dat, nutné nastavit limity.'
    ) -join "`n"
    'Kvízy a testy' = @(
        'Co to je: Znalostní testy s vyhodnocením odpovědí.'
        'Kdy zvolit: Potřebuješ ověřit znalosti studenta nebo certifikovat výstup.'
        'Plus: Zvyšuje angažovanost, dává měřitelný výsledek vzdělávání.'
        'Pozor: Vyhodnocení musí být na serveru, jinak si student odpovědi přečte.'
    ) -join "`n"
    'Certifikáty (PDF generování)' = @(
        'Co to je: Generované PDF certifikáty o absolvování.'
        'Kdy zvolit: Student potřebuje doložit absolvování.'
        'Plus: Vyšší vnímaná hodnota kurzu, dobrý marketingový nástroj.'
        'Pozor: Přidej ověřovací kód pro ověření pravosti, jinak je certifikát snadno padělatelný.'
    ) -join "`n"
    'Progress tracking' = @(
        'Co to je: Sledování pokroku studenta v kurzu.'
        'Kdy zvolit: Kurz má více lekcí a student se potřebuje vracet.'
        'Plus: Student vidí pokrok a motivaci, ty vidíš dokončení.'
        'Pozor: Ukládej na serveru, jinak přijdou data při změně zařízení.'
    ) -join "`n"
    'Diskusní fórum' = @(
        'Co to je: Diskuse studentů pod lekcí nebo kurzem.'
        'Kdy zvolit: Chceš podpořit komunitu a snížit počet dotazů na podporu.'
        'Plus: Vyšší retence, síťový efekt, obsah generovaný uživateli.'
        'Pozor: Nutná moderace a notifikace, jinak fórum zůstane mrtvé.'
    ) -join "`n"
    'Live sessions (Zoom / Daily.co)' = @(
        'Co to je: Živé lekce přes videokonferenční službu.'
        'Kdy zvolit: Nabízíš interaktivní výuku s dotazy v reálném čase.'
        'Plus: Vyšší vnímaná hodnota, přímý kontakt s lektorem.'
        'Pozor: Nutné řešit termíny, kapacitu a přístupové odkazy.'
    ) -join "`n"
    'Předplatné kurzu' = @(
        'Co to je: Přístup ke všem kurzům za pravidelný poplatek.'
        'Kdy zvolit: Nabízíš knihovnu obsahu, kde rychle přibývá.'
        'Plus: Předvídatelné příjmy, vyšší hodnota pro aktivní studenty.'
        'Pozor: Musíš pravidelně přidávat obsah, jinak předplatné ztratí smysl.'
    ) -join "`n"
    'Drip content' = @(
        'Co to je: Postupné odemykání obsahu podle času nebo pokroku.'
        'Kdy zvolit: Nechceš, aby student prošel vše najednou.'
        'Plus: Vyšší dokončenost, plynulé rozložení učení, nižší riziko.'
        'Pozor: U pokročilých studentů může působit omezujícím dojmem.'
    ) -join "`n"

    'Kontakty + firmy' = @(
        'Co to je: Evidence kontaktních osob a firem včetně vztahů.'
        'Kdy zvolit: Obchodní tým potřebuje přehled o zákaznících a partnerech.'
        'Plus: Nahradí tabulky, umožní vyhledávání a filtrování.'
        'Pozor: Nutná deduplikace podle e-mailu a ochrana osobních údajů.'
    ) -join "`n"
    'Pipeline / deals' = @(
        'Co to je: Kanban přehled obchodních příležitostí podle fází.'
        'Kdy zvolit: Chceš sledovat, kde v prodejním procesu příležitost je.'
        'Plus: Okamžitý přehled o stavu obchodu, jednoduchá práce s drag and drop.'
        'Pozor: Fáze a pravidla je nutné jasně definovat, jinak je board nepoužitelný.'
    ) -join "`n"
    'Úkoly a aktivity' = @(
        'Co to je: Task management navázaný na kontakty a obchody.'
        'Kdy zvolit: Obchod vyžaduje follow-up a evidenci komunikace.'
        'Plus: Nic nepropadne, jasná odpovědnost a historie.'
        'Pozor: Bez notifikací a přehledu se úkoly přestanou používat.'
    ) -join "`n"
    'Reporty a dashboardy' = @(
        'Co to je: Analytika prodeje v grafech a číslech.'
        'Kdy zvolit: Vedení potřebuje přehled o výkonu a predikci.'
        'Plus: Podklad pro rozhodování, odhalení slabých míst v procesu.'
        'Pozor: Data musí být definována jednotně, jinak si každý počítá jiná čísla.'
    ) -join "`n"
    'Import/Export dat' = @(
        'Co to je: Hromadné nahrání a stažení kontaktů nebo obchodů.'
        'Kdy zvolit: Migruješ z jiného systému nebo řešíš zálohu dat.'
        'Plus: Nezbytné pro onboarding i odchod zákazníka, šetří hodiny ruční práce.'
        'Pozor: Validuj každý řádek a detekuj duplicity, jinak si zaneseš databázi nekonzistentními daty.'
    ) -join "`n"
    'Email sekvence' = @(
        'Co to je: Automatické série follow-up e-mailů.'
        'Kdy zvolit: Chceš udržet kontakt s leadem bez ruční práce.'
        'Plus: Zvyšuje konverzi i retenci, škáluje bez personálních nákladů.'
        'Pozor: Nutný souhlas s marketingem a snadné odhlášení.'
    ) -join "`n"
    'Lead scoring' = @(
        'Co to je: Automatické bodování kvality obchodních příležitostí.'
        'Kdy zvolit: Málo obchodníků a mnoho leadů, chceš pracovat s nejlepšími.'
        'Plus: Efektivnější využití času obchodního týmu, vyšší konverze.'
        'Pozor: Model je nutné průběžně vyhodnocovat a ladit podle reality.'
    ) -join "`n"
    'Ticket systém' = @(
        'Co to je: Evidence požadavků a stížností zákazníků.'
        'Kdy zvolit: Zákaznická podpora potřebuje přehled a historii.'
        'Plus: Žádný požadavek se neztratí, měřitelná doba odezvy.'
        'Pozor: Nutné nastavit priority, SLA a automatické přiřazování.'
    ) -join "`n"

    'Platby: Stripe' = @(
        'Co to je: Globální platební brána s podporou karet i lokálních metod.'
        'Kdy zvolit: Prodáváš mezinárodně nebo chceš moderní API a předplatné.'
        'Plus: Nejlepší dokumentace a DX, podpora předplatného i tržišť.'
        'Pozor: Vyšší poplatky u evropských karet, nutná idempotence webhooků.'
    ) -join "`n"
    'Platby: GoPay' = @(
        'Co to je: Česká platební brána s širokou podporou lokálních metod.'
        'Kdy zvolit: Prodáváš v ČR a chceš platby, které zákazníci znají.'
        'Plus: Lokální metody včetně platebních tlačítek bank, známá značka.'
        'Pozor: Vyšší poplatky než u globálních bran, méně moderní API.'
    ) -join "`n"
    'Platby: PayPal' = @(
        'Co to je: Globální platební služba s vlastním účtem zákazníka.'
        'Kdy zvolit: Chceš pokrýt zákazníky, kteří nechtějí zadávat kartu.'
        'Plus: Důvěra zákazníků, ochrana kupujícího, snadný onboarding.'
        'Pozor: Vyšší poplatky, častější spory a vratky, nutné párování plateb.'
    ) -join "`n"
    'Doprava: Packeta / Zásilkovna' = @(
        'Co to je: Doručení na výdejní místa a prostřednictvím kurýra.'
        'Kdy zvolit: Prodáváš v ČR a SK, kde jsou výdejní místa velmi oblíbená.'
        'Plus: Nejnižší náklady na doručení, vysoká oblíbenost u zákazníků.'
        'Pozor: Nutné řešit výběr konkrétního místa a synchronizaci stavů.'
    ) -join "`n"
    'Doprava: DPD / PPL' = @(
        'Co to je: Klasické kurýrní služby doručující na adresu.'
        'Kdy zvolit: Zákazník chce doručení domů nebo jde o těžké zásilky.'
        'Plus: Doručení na adresu, dobré pokrytí a přepravní kapacity.'
        'Pozor: Vyšší cena, nutné správně vyplnit adresu a kontakt na příjemce.'
    ) -join "`n"
    'Fakturace: Fakturoid' = @(
        'Co to je: Česká služba pro automatické vystavování faktur.'
        'Kdy zvolit: Potřebuješ daňové doklady pro české i zahraniční zákazníky.'
        'Plus: Správné náležitosti, API pro automatizaci, napojení na účetnictví.'
        'Pozor: Nutné správně nastavit sazby DPH včetně reverse charge.'
    ) -join "`n"
    'Fakturace: iDoklad' = @(
        'Co to je: Alternativa k Fakturoidu pro fakturaci a evidenci.'
        'Kdy zvolit: Fakturoid ti nevyhovuje cenou, funkcemi nebo integracemi.'
        'Plus: Srovnatelné funkce, silná podpora v ČR, napojení na účetní systémy.'
        'Pozor: Jiné API a datový model než Fakturoid, nutné přizpůsobit integraci.'
    ) -join "`n"
    'Email: Resend / Postmark' = @(
        'Co to je: Služby pro transakční e-maily s důrazem na doručitelnost.'
        'Kdy zvolit: Odesíláš potvrzení, pozvánky, reset hesla nebo notifikace.'
        'Plus: Vysoká doručitelnost, šablony, přehledy o chybách a odeslání.'
        'Pozor: Nutné nastavit SPF, DKIM a DMARC a hlídat reputaci domény.'
    ) -join "`n"
    'SMS: Twilio / SMS.cz' = @(
        'Co to je: Odesílání SMS zpráv podle událostí v aplikaci.'
        'Kdy zvolit: Potřebuješ okamžitou reakci, kde e-mail nestačí.'
        'Plus: Nejvyšší míra zobrazení, funguje i bez internetu.'
        'Pozor: Vyšší náklady na zprávu, nutná evidence souhlasu a dodržení předpisů.'
    ) -join "`n"
    'Účetnictví: Pohoda / Money S3' = @(
        'Co to je: Export dat do českých účetních systémů.'
        'Kdy zvolit: Účetní pracuje v Pohodě nebo Money S3 a nechce ručně přepisovat.'
        'Plus: Odpadá ruční přepis, méně chyb a rychlejší uzávěrka.'
        'Pozor: Každý systém má jiný formát importu - nutné udržovat konverzi.'
    ) -join "`n"
    'Marketing: Mailchimp / Klaviyo' = @(
        'Co to je: Nástroje pro e-mailový marketing a automatizaci kampaní.'
        'Kdy zvolit: Chceš rozesílat novinky, kampaně a segmentované nabídky.'
        'Plus: Hotové šablony, automatizace, měření otevření i prokliků.'
        'Pozor: Nutný souhlas se zasíláním, nutné hlídat doručitelnost domény.'
    ) -join "`n"
    'Analytics: GA4 / Meta Pixel' = @(
        'Co to je: Měřicí kódy pro sledování návštěvnosti a konverzí.'
        'Kdy zvolit: Řešíš placenou reklamu nebo potřebuješ atribuci kampaní.'
        'Plus: Nástroj pro optimalizaci reklam i webu, měřitelný dopad.'
        'Pozor: Vyžaduje souhlas podle GDPR, snadno se rozbije měření.'
    ) -join "`n"

    'Newsletter' = @(
        'Co to je: Odběr novinek e-mailem s potvrzením (double opt-in).'
        'Kdy zvolit: Chceš budovat publikum a komunikovat s návštěvníky.'
        'Plus: Levný vlastněný kanál, vyšší návratnost než sociální sítě.'
        'Pozor: Nutné potvrzení přihlášení a snadné odhlášení, jinak hrozí stížnosti.'
    ) -join "`n"
    'Blog s MDX' = @(
        'Co to je: Sekce článků psaná v MDX přímo v repozitáři.'
        'Kdy zvolit: Autor je technický, chceš verzování a rychlé statické stránky.'
        'Plus: Skvělý výkon a SEO, žádná databáze, obsah u kódu.'
        'Pozor: Nezvládne netechnický editor, publikace vyžaduje deploy.'
    ) -join "`n"
    'Landing pages builder' = @(
        'Co to je: Nástroj pro tvorbu cílových stránek bez vývojáře.'
        'Kdy zvolit: Spouštíš kampaně a potřebuješ rychle testovat varianty.'
        'Plus: Marketing je soběstačný, rychlé iterace a testování.'
        'Pozor: Vlastní builder je drahý - nejprve zvaž hotové nástroje.'
    ) -join "`n"
    'Referral systém' = @(
        'Co to je: Odměny za doporučení nových zákazníků.'
        'Kdy zvolit: Produkt má organický potenciál a spokojené zákazníky.'
        'Plus: Nejlevnější akvizice, vyšší důvěra doporučených zákazníků.'
        'Pozor: Nutné řešit zneužití a podvody s účty a ověřovat platnost odměn.'
    ) -join "`n"
    'Affiliate program' = @(
        'Co to je: Partnerský program s provizemi za prodej.'
        'Kdy zvolit: Máš partnery nebo influence, kteří mohou prodávat.'
        'Plus: Platíš za výsledek, škáluje bez fixních nákladů.'
        'Pozor: Nutné spolehlivé měření a vypořádání, pozor na podvodné partnery.'
    ) -join "`n"
    'Structured data (JSON-LD)' = @(
        'Co to je: Strukturovaná data podle schema.org pro vyhledávače.'
        'Kdy zvolit: Chceš bohaté výsledky ve vyhledávání - hodnocení, ceny, akce.'
        'Plus: Vyšší proklik z vyhledávače, lepší zobrazení v výsledcích.'
        'Pozor: Data musí odpovídat skutečnosti, jinak hrozí postih od vyhledávače.'
    ) -join "`n"
    'Open Graph optimalizace' = @(
        'Co to je: Meta tagy určující náhled při sdílení na sociálních sítích.'
        'Kdy zvolit: Obsah se sdílí - sdílení bez náhledu snižuje proklik.'
        'Plus: Vyšší prokliky ze sociálních sítí, profesionální vzhled sdílení.'
        'Pozor: Nutný obrázek ve správném rozměru, cache sítí se aktualizuje pomalu.'
    ) -join "`n"
    'Sitemap + robots.txt' = @(
        'Co to je: Seznam adres pro vyhledávače a pravidla pro crawlery.'
        'Kdy zvolit: Vždy u veřejného webu, který má být indexován.'
        'Plus: Rychlejší a úplné indexování, kontrola nad tím, co se nemá indexovat.'
        'Pozor: Nesprávný robots.txt může zablokovat celý web - nasazuj opatrně.'
    ) -join "`n"
    'RSS feed' = @(
        'Co to je: Strojově čitelný kanál nového obsahu.'
        'Kdy zvolit: Blog, magazín, podcast - publikum používá čtečky.'
        'Plus: Trvanlivý distribuční kanál, nezávislý na platformách.'
        'Pozor: Málo známé pro běžné uživatele, ale silné u technického publika.'
    ) -join "`n"
    'Push notifikace (web)' = @(
        'Co to je: Upozornění do prohlížeče bez instalace aplikace.'
        'Kdy zvolit: Chceš uživatele vrátit na web, ale nemáš mobilní aplikaci.'
        'Plus: Vyšší míra zobrazení než e-mail, nízké náklady.'
        'Pozor: Vyžaduje souhlas, na iOS je podpora omezená, snadno obtěžuje.'
    ) -join "`n"

    'GDPR (souhlasy, výmaz)' = @(
        'Co to je: Správa souhlasů a uplatnění práva na výmaz.'
        'Kdy zvolit: Zpracováváš osobní údaje osob v EU.'
        'Plus: Snižuje právní riziko pokut, zvyšuje důvěru uživatelů.'
        'Pozor: Musíš umět prokázat udělení souhlasu a skutečně data smazat.'
    ) -join "`n"
    'Obchodní podmínky' = @(
        'Co to je: Verzované smluvní podmínky používání služby.'
        'Kdy zvolit: Prodáváš nebo provozuješ službu, vždy před prvním prodejem.'
        'Plus: Základ právní ochrany, nutnost pro platební brány a obchody.'
        'Pozor: Verze musí být dohledatelné - u změny je nutné prokázat, které platily.'
    ) -join "`n"
    'Cookies consent (Cookiebot)' = @(
        'Co to je: Nástroj pro sběr a evidenci souhlasu s cookies.'
        'Kdy zvolit: Používáš analytiku, reklamu nebo jiné než nezbytné cookies.'
        'Plus: Blokuje skripty do udělení souhlasu, vede evidenci udělení.'
        'Pozor: Musí být opt-in a skripty skutečně blokované, jinak je banner jen na okrasu.'
    ) -join "`n"
    'Reklamační systém' = @(
        'Co to je: Stavový automat pro vyřizování reklamací.'
        'Kdy zvolit: Prodáváš zboží a musíš řešit reklamace v zákonné lhůtě.'
        'Plus: Přehled o všech reklamacích, dodržení lhůt, historie komunikace.'
        'Pozor: Zákonná lhůta pro vyřízení je 30 dní - systém na to musí upozorňovat.'
    ) -join "`n"
    '14 dní na vrácení (spotřebitel)' = @(
        'Co to je: Zákonné právo spotřebitele odstoupit od smlouvy do 14 dnů.'
        'Kdy zvolit: Prodáváš koncovému spotřebiteli v ČR a EU.'
        'Plus: Soulad se zákonem, jasná pravidla pro zákazníka i obsluhu.'
        'Pozor: Platí výjimky (například zboží na míru), nutné je správně vymezit.'
    ) -join "`n"
    'Ochrana osobních údajů' = @(
        'Co to je: Evidence zpracování osobních údajů a nastavená pravidla.'
        'Kdy zvolit: Ukládáš nebo zpracováváš jakékoli osobní údaje.'
        'Plus: Soulad s GDPR, jasný přehled o datech a odpovědnostech.'
        'Pozor: Samotná evidence nestačí - pravidla se musí dodržovat v kódu.'
    ) -join "`n"
    'Autorská práva a licence' = @(
        'Co to je: Evidence práv k obsahu, obrázkům, hudbě a kódu.'
        'Kdy zvolit: Používáš cizí obsah nebo prodáváš vlastní tvorbu.'
        'Plus: Ochrana před žalobou i před zneužitím tvé tvorby jinými.'
        'Pozor: U videa a hudby jsou nároky často vymáhány automatizovaně.'
    ) -join "`n"
    'VAT / DPH kalkulace' = @(
        'Co to je: Výpočet DPH včetně reverse charge a režimu OSS.'
        'Kdy zvolit: Prodáváš firmám nebo zákazníkům v zahraničí.'
        'Plus: Správné částky na faktuře, soulad s daňovými předpisy.'
        'Pozor: Sazby a pravidla se liší podle země, měň je konfigurací a nikdy napevno.'
    ) -join "`n"
}

# ---- Chování agenta: doplňky k obecným instrukcím ----
$script:helpDetailSets += @{
    'Nikdy neinstalujte nedeklarované závislosti' = @(
        'Co to znamená: Agent nesmí tiše přidávat balíčky, které nejsou v manifestu.'
        'Proč: Nechtěné nebo neověřené balíčky jsou bezpečnostní i licenční riziko.'
        'Jak se to projeví: Každá nová závislost musí být vědomé rozhodnutí v review.'
    ) -join "`n"
    'Spusťte testovací sadu' = @(
        'Co to znamená: Před odevzdáním změn spusť relevantní nebo celou testovací sadu.'
        'Proč: Bez spuštění testů nelze tvrdit, že změna něco nerozbila.'
        'Jak se to projeví: Agent hlásí výsledek testů, ne jen hotový kód.'
    ) -join "`n"
    'Spusťte linter a formátovač' = @(
        'Co to znamená: Spustit lint a formát před dokončením úlohy a opravit nálezy.'
        'Proč: Udržuje konzistentní styl a odhaluje část chyb bez lidského úsilí.'
        'Jak se to projeví: Menší a čitelnější diffy, méně diskuzí v review.'
    ) -join "`n"
    'Kontrola typů' = @(
        'Co to znamená: Spustit typovou kontrolu a opravit všechny nahlášené chyby.'
        'Proč: Typové chyby odhalí problémy, které testy často nezachytí.'
        'Jak se to projeví: Agent nedodá kód, dokud typecheck neprojde.'
    ) -join "`n"
    'Replikujte CI kontroly lokálně' = @(
        'Co to znamená: Před odevzdáním spustit stejné kroky, jaké pouští CI pipeline.'
        'Proč: Neúspěšné CI zdržuje celý tým a zdržuje merge.'
        'Jak se to projeví: Zelené CI na první pokus, kratší zpětná vazba.'
    ) -join "`n"
    'Dodržujte stávající strukturu' = @(
        'Co to znamená: Nepřesouvat a nereorganizovat složky bez explicitního zadání.'
        'Proč: Velké přesuny ztěžují review, rozbíjejí odkazy a historii gitu.'
        'Jak se to projeví: Změny zůstávají malé a soustředěné na zadání.'
    ) -join "`n"
    'Společné umístění testů' = @(
        'Co to znamená: Nové testy umisťovat podle stávající konvence projektu.'
        'Proč: Nekonzistentní umístění znesnadňuje hledání a údržbu testů.'
        'Jak se to projeví: Tester i vývojář najdou test tam, kde ho čekají.'
    ) -join "`n"
    'Vyhněte se novým závislostem' = @(
        'Co to znamená: Preferovat existující knihovny před přidáním dalších.'
        'Proč: Každá závislost zvyšuje velikost, riziko i nároky na údržbu.'
        'Jak se to projeví: Méně balíčků, menší bundle, jednodušší aktualizace.'
    ) -join "`n"
    'Respektujte konfigurační soubory' = @(
        'Co to znamená: Dodržovat nastavení tsconfig, eslint, .editorconfig a pyproject.'
        'Proč: Agent nesmí obcházet pravidla projektu kvůli rychlejšímu řešení.'
        'Jak se to projeví: Kód prochází kontrolami bez nutnosti výjimek.'
    ) -join "`n"
    'Preferujte konst' = @(
        'Co to znamená: Používat const nebo neměnné hodnoty tam, kde to jde.'
        'Proč: Neměnné hodnoty snižují počet stavů a tím i chyb.'
        'Jak se to projeví: Méně neočekávaných změn proměnných v čase.'
    ) -join "`n"
    'Předsazené výrazy (early returns)' = @(
        'Co to znamená: Vyřizovat okrajové případy na začátku funkcí.'
        'Proč: Hluboké zanoření podmínek je nejhůř čitelné a snadno skrývá chyby.'
        'Jak se to projeví: Kratší funkce, jasná hlavní cesta kódu.'
    ) -join "`n"
    'Popisné pojmenování' = @(
        'Co to znamená: Názvy proměnných a funkcí nesou význam, ne zkratky.'
        'Proč: Kód se čte mnohem častěji, než píše.'
        'Jak se to projeví: Méně potřeby komentářů, rychlejší orientace.'
    ) -join "`n"
    'Malé funkce' = @(
        'Co to znamená: Funkce dělá jednu věc a vejde se na obrazovku.'
        'Proč: Malé funkce se snáze testují, čtou i znovu používají.'
        'Jak se to projeví: Lepší testovatelnost a méně vedlejších efektů.'
    ) -join "`n"
    'Autodokumentační kód' = @(
        'Co to znamená: Kód má být srozumitelný sám, komentáře vysvětlují proč.'
        'Proč: Komentář popisující co kód dělá, zastará a mate.'
        'Jak se to projeví: Méně komentářů, ale kvalitnějších.'
    ) -join "`n"
    'Pokrytí pro nové kódy' = @(
        'Co to znamená: Ke každé nové nebo změněné funkcionalitě přidat testy.'
        'Proč: Bez testů se regrese odhalí až u zákazníka.'
        'Jak se to projeví: Změny jsou bezpečné i při dalších úpravách.'
    ) -join "`n"
    'Jednotkové testy' = @(
        'Co to znamená: Pokrýt novou logiku rychlými izolovanými testy.'
        'Proč: Unit testy běží v milisekundách a chytají většinu chyb.'
        'Jak se to projeví: Rychlá zpětná vazba při vývoji.'
    ) -join "`n"
    'Okrajové případy' = @(
        'Co to znamená: Testovat i chybové a hraniční stavy, ne jen ideální cestu.'
        'Proč: Většina produkčních chyb vzniká na okrajích, ne ve středu.'
        'Jak se to projeví: Testy pro prázdné hodnoty, limity a chyby.'
    ) -join "`n"
    'Testovací názvy' = @(
        'Co to znamená: Název testu popisuje očekávané chování.'
        'Proč: Při pádu testu hned víš, co přestalo fungovat.'
        'Jak se to projeví: Výpis testů je sám o sobě dokumentací.'
    ) -join "`n"
    'AAA vzor' = @(
        'Co to znamená: Test je rozdělen na přípravu, akci a ověření.'
        'Proč: Jednotná struktura zrychluje čtení i psaní testů.'
        'Jak se to projeví: Každý test má tři jasné části.'
    ) -join "`n"
    'JSDoc/Docstringy' = @(
        'Co to znamená: Veřejné funkce a typy mají dokumentační komentář.'
        'Proč: Umožní našeptávání v editoru i pochopení bez čtení implementace.'
        'Jak se to projeví: Nápověda přímo v IDE u volání funkce.'
    ) -join "`n"
    'Aktualizace README' = @(
        'Co to znamená: Při nové funkci nebo změně chování upravit README.'
        'Proč: Zastaralá dokumentace mate víc než žádná.'
        'Jak se to projeví: Návod odpovídá skutečnému stavu kódu.'
    ) -join "`n"
    'Složitá logika' = @(
        'Co to znamená: Netriviální algoritmus má inline komentář s vysvětlením.'
        'Proč: U složité logiky je postup důležitější než samotný zápis.'
        'Jak se to projeví: Kdokoli pochopí, proč je kód napsaný právě tak.'
    ) -join "`n"
    'Dokumentace API' = @(
        'Co to znamená: Endpointy mají popsaný vstup, výstup a chybové stavy.'
        'Proč: Bez kontraktu si klient domýšlí chování a vznikají chyby.'
        'Jak se to projeví: Dokumentace nebo OpenAPI spec v repozitáři.'
    ) -join "`n"
    'Ověřujte vstupy' = @(
        'Co to znamená: Validovat a sanitizovat veškerý vstup na serveru.'
        'Proč: Klient je vždy nedůvěryhodný, i když je to tvoje vlastní UI.'
        'Jak se to projeví: Server odmítne neplatná data srozumitelnou chybou.'
    ) -join "`n"
    'Žádná tvrdá tajemství' = @(
        'Co to znamená: Žádné klíče, hesla ani tokeny v kódu nebo repozitáři.'
        'Proč: Tajemství v gitu zůstává v historii navždy, i po smazání.'
        'Jak se to projeví: Hodnoty se načítají z prostředí, v repu jen .env.example.'
    ) -join "`n"
    'Parametrizované dotazy' = @(
        'Co to znamená: Dotazy skládat s parametry, nikdy slepováním řetězců.'
        'Proč: Slepování uživatelského vstupu do SQL vede k SQL injection.'
        'Jak se to projeví: ORM nebo prepared statements u všech dotazů.'
    ) -join "`n"
    'Prevence XSS' = @(
        'Co to znamená: Escapovat a sanitizovat výstupy, které jdou do HTML.'
        'Proč: Neescapovaný obsah umožní spuštění cizího skriptu v prohlížeči.'
        'Jak se to projeví: Žádné vkládání neověřeného HTML a striktní CSP.'
    ) -join "`n"
    'Sémantické HTML' = @(
        'Co to znamená: Používat elementy podle jejich významu, ne podle vzhledu.'
        'Proč: Sémantika je základ přístupnosti, SEO i ovládání klávesnicí.'
        'Jak se to projeví: Správné prvky místo univerzálních kontejnerů.'
    ) -join "`n"
    'Alternativní text u obrázků' = @(
        'Co to znamená: Každý obrázek má alt text nebo je označen jako dekorativní.'
        'Proč: Čtečky obrazovky jinak přečtou název souboru nebo nic.'
        'Jak se to projeví: Popis funkce obrázku tam, kde nese informaci.'
    ) -join "`n"
    'Navigace klávesnicí' = @(
        'Co to znamená: Vše důležité ovladatelné bez myši a s viditelným fokusem.'
        'Proč: Část uživatelů používá jen klávesnici a bez toho nemůže pracovat.'
        'Jak se to projeví: Logické pořadí tabulátoru a viditelný focus.'
    ) -join "`n"
    'Štítky ARIA' = @(
        'Co to znamená: Doplňující atributy tam, kde nativní sémantika nestačí.'
        'Proč: Vlastní komponenty nejsou pro asistivní technologie čitelné.'
        'Jak se to projeví: Srozumitelné názvy a stavy u vlastních prvků.'
    ) -join "`n"
    'Lint pravidla pro výkon' = @(
        'Co to znamená: Dodržovat pravidla odhalující časté výkonnostní chyby.'
        'Proč: Chybějící závislosti v efektech a zbytečné renderování zpomalují aplikaci.'
        'Jak se to projeví: Méně re-renderů a méně zbytečných výpočtů.'
    ) -join "`n"
    'Memoizace' = @(
        'Co to znamená: Ukládat výsledek drahých výpočtů, dokud se nezmění vstupy.'
        'Proč: Opakované přepočítávání při každém renderu zbytečně zatěžuje prohlížeč.'
        'Jak se to projeví: Plynulejší UI u velkých seznamů a tabulek.'
    ) -join "`n"
    'Vyhněte se N+1 dotazům' = @(
        'Co to znamená: Načítat související data jedním dotazem, ne v cyklu.'
        'Proč: N+1 dotazů násobí latenci a počet operací v databázi.'
        'Jak se to projeví: Konstantní počet dotazů i při rostoucím počtu záznamů.'
    ) -join "`n"
    'Velikost svazku' = @(
        'Co to znamená: Hlídat velikost JavaScriptu odesílaného klientovi.'
        'Proč: Každá závislost se projeví na době načtení, hlavně na mobilu.'
        'Jak se to projeví: Pravidelná kontrola velikosti v CI.'
    ) -join "`n"
}

# ---- Nasazení: hosting a platformy ----
$script:helpDetailSets += @{
    'Vercel (BaaS + Edge)' = @(
        'Co to je: Platforma od tvůrců Next.js s automatickými náhledy a edge sítí.'
        'Kdy zvolit: Next.js nebo Nuxt projekt, kde chceš minimum provozní práce.'
        'Plus: Nejlepší DX pro Next.js, náhled na každý PR, edge funkce, CDN v ceně.'
        'Pozor: Vyšší cena u velkého provozu, silná vazba na platformu u edge funkcí.'
    ) -join "`n"
    'Netlify' = @(
        'Co to je: Hosting podobný Vercelu s náhledovými nasazeními a funkcemi.'
        'Kdy zvolit: Statické weby nebo aplikace, kde nechceš Vercel.'
        'Plus: Jednoduché nastavení, dobré náhledy, přívětivý free tier.'
        'Pozor: Slabší podpora Next.js než na Vercelu, některé funkce chybí nebo jsou dražší.'
    ) -join "`n"
    'Docker Container (VPS/AWS)' = @(
        'Co to je: Vlastní kontejner nasazený na server nebo do cloudu.'
        'Kdy zvolit: Potřebuješ kontrolu nad prostředím, dlouho běžící procesy nebo specifické služby.'
        'Plus: Přenositelnost mezi poskytovateli, plná kontrola, předvídatelné náklady.'
        'Pozor: Řešíš logging, monitoring, HTTPS, škálování i aktualizace sám.'
    ) -join "`n"
    'Container PaaS (Fly.io / Render)' = @(
        'Co to je: Managed platforma, která nasadí kontejner nebo repozitář bez správy VM.'
        'Kdy zvolit: Chceš vlastní serverovou aplikaci bez provozní režie velkého cloudu.'
        'Plus: Rozumný kompromis ceny a jednoduchosti, regionální nasazení, dobré pro Postgres.'
        'Pozor: Omezené možnosti doladění, u velkého provozu může být dražší než vlastní VM.'
    ) -join "`n"
    'VM Compose (DigitalOcean / GCP)' = @(
        'Co to je: Virtuální server s Docker Compose na více služeb.'
        'Kdy zvolit: Malý nebo střední projekt s databází, cache a aplikací na jednom místě.'
        'Plus: Nejnižší náklady, plná kontrola, snadné porozumění celému prostředí.'
        'Pozor: Ruční údržba, zálohy a bezpečnost; riziko jednoho bodu selhání.'
    ) -join "`n"
    'AWS ECS / Fargate (Enterprise)' = @(
        'Co to je: Kontejnerová orchestrační platforma AWS bez správy serverů.'
        'Kdy zvolit: Korporátní nasazení s požadavky na škálování, audity a compliance.'
        'Plus: Škálování, integrace s dalšími službami AWS, soulad s firemními procesy.'
        'Pozor: Vysoká komplexita a náklady, potřeba znalostí AWS a Infrastructure as Code.'
    ) -join "`n"
    'Coolify (self-hosted PaaS)' = @(
        'Co to je: Open-source alternativa k Vercelu, kterou si provozuješ sám.'
        'Kdy zvolit: Chceš pohodlí PaaS, ale data i náklady pod vlastní kontrolou.'
        'Plus: Bez poplatků za platformu, nasazení přes git, webhooky i databáze.'
        'Pozor: Server si spravuješ sám, údržba a aktualizace včetně záloh jsou na tobě.'
    ) -join "`n"
}

# ---- Volby záložky Skills, UI knihovny a zkrácené názvy v UI ----
$script:helpDetailSets += @{
    'Pouze zaškrtnuté skilly' = @(
        'Co to je: Vygenerují se jen skilly, které v záložce zaškrtneš.'
        'Kdy zvolit: Doporučená volba - vybereš jen to, co projekt skutečně potřebuje.'
        'Plus: Méně souborů, žádný balast, rychlá orientace v repozitáři.'
        'Pozor: Musíš projít kategorie a nic důležitého nevynechat.'
    ) -join "`n"
    'Všechny skilly (kompletní sada)' = @(
        'Co to je: Vygeneruje všech 72 skills bez ohledu na zaškrtnutí.'
        'Kdy zvolit: Chceš kompletní zásobu skillů, ze které budeš vybírat později.'
        'Plus: Nic nechybí, agent má k dispozici veškeré postupy.'
        'Pozor: Hodně souborů v repozitáři; agentům se zvětší seznam ke zvážení.'
    ) -join "`n"
    'Kontrolní seznam (checklist)' = @(
        'Co to je: Do každého SKILL.md přidá odrážkový seznam k odškrtnutí.'
        'Kdy zvolit: Chceš, aby agent u každé změny prošel konkrétní body.'
        'Plus: Nejúčinnější forma instrukce - agent má jasný seznam k ověření.'
        'Pozor: Příliš dlouhé seznamy agenti zkracují, drž 3 až 5 bodů.'
    ) -join "`n"
    'Příklad použití' = @(
        'Co to je: Přidá do SKILL.md krátkou ukázku vyvolání skillu.'
        'Kdy zvolit: Chceš agentovi ukázat očekávaný způsob použití.'
        'Plus: Urychluje pochopení, slouží jako vzor pro podobné situace.'
        'Pozor: Ukázka se musí udržovat aktuální, jinak mate.'
    ) -join "`n"
    'Lucide Icons' = @(
        'Co to je: Sada konzistentních ikon jako React komponenty.'
        'Kdy zvolit: Potřebuješ jednotný a čistý ikonový systém bez závislosti na designérovi.'
        'Plus: Velký výběr, jednotný styl, možnost měnit tloušťku tahu, tree-shaking.'
        'Pozor: Ikony bez textového popisu zhoršují přístupnost - doplň aria-label.'
    ) -join "`n"
    'Sonner (toast notifikace)' = @(
        'Co to je: Knihovna pro krátká oznámení v rohu obrazovky.'
        'Kdy zvolit: Potřebuješ uživateli potvrdit akci nebo ohlásit chybu.'
        'Plus: Jednoduché API, přístupné a hezky vypadající, podpora slibů.'
        'Pozor: Notifikace nejsou náhrada validačních chyb ani potvrzení formuláře.'
    ) -join "`n"
    'next-themes (dark mode)' = @(
        'Co to je: Knihovna pro přepínání světlého, tmavého a systémového režimu.'
        'Kdy zvolit: Chceš podporu tmavého režimu bez bliknutí při načtení stránky.'
        'Plus: Řeší bliknutí po přechodu ze serveru, ukládá volbu uživatele.'
        'Pozor: Každá barva musí projít v obou režimech - testuj kontrast.'
    ) -join "`n"
    'Recharts (grafy)' = @(
        'Co to je: Knihovna pro grafy postavená na D3, určená pro React.'
        'Kdy zvolit: Potřebuješ dashboardy a přehledy s běžnými typy grafů.'
        'Plus: Snadné použití, responzivní, dobrá dokumentace a příklady.'
        'Pozor: U velkých datových sad a komplexních vizualizací je pomalejší.'
    ) -join "`n"
    'Knip' = @(
        'Co to je: Nástroj, který najde nepoužívané soubory, exporty a závislosti.'
        'Kdy zvolit: Projekt roste a začíná mít mrtvý kód a nepotřebné balíčky.'
        'Plus: Zmenšuje bundle, odhaluje zapomenutý kód, zpřehledňuje repozitář.'
        'Pozor: Občas označí dynamicky používaný kód - nutné nastavit výjimky.'
    ) -join "`n"
    'Husky' = @(
        'Co to je: Nástroj pro zavedení git hooků do repozitáře.'
        'Kdy zvolit: Chceš pouštět kontroly automaticky před commitem nebo pushnutím.'
        'Plus: Zabraňuje tomu, aby se do repozitáře dostal nefunkční nebo neformátovaný kód.'
        'Pozor: Přidává čas ke každému commitu - kombinuj s lint-staged pro rychlost.'
    ) -join "`n"
    'Commitlint' = @(
        'Co to je: Kontrola formátu commit zpráv podle Conventional Commits.'
        'Kdy zvolit: Chceš automatické verzování a generovaný changelog.'
        'Plus: Umožňuje semantic release, čitelná historie, snadné hledání změn.'
        'Pozor: Vyžaduje disciplínu týmu, u malých projektů může zdržovat.'
    ) -join "`n"
    'Interní distribuce (Firebase App Distribution)' = @(
        'Co to je: Distribuce testovacích buildů mimo veřejné obchody s aplikacemi.'
        'Kdy zvolit: Testování před vydáním nebo interní firemní aplikace.'
        'Plus: Rychlé doručení buildu testerům, žádné schvalování, přehled o instalacích.'
        'Pozor: Nevhodné pro koncové uživatele; na iOS musí být zařízení registrovaná.'
    ) -join "`n"
    'Konsolidovaný (instrukce + agent + setup)' = @(
        'Co to je: Ucelený výstup - instrukce, agent a nastavení prostředí pro agenta.'
        'Kdy zvolit: Doporučená volba pro většinu projektů.'
        'Plus: Jen 3 soubory se snadno udržují, nic se nerozjede do desítek složek.'
        'Pozor: Skills jsou vložené přímo v instrukcích, takže se načítají vždy.'
    ) -join "`n"
    'Rozšířený (+ skills a agent-task)' = @(
        'Co to je: Navíc samostatný SKILL.md a definice agenta pro plnění úloh.'
        'Kdy zvolit: Chceš, aby se skills načítaly jen podle potřeby.'
        'Plus: Menší kontext při běžné práci, skills se načtou jen když jsou relevantní.'
        'Pozor: Více souborů k údržbě, nutné udržovat v souladu s instrukcemi.'
    ) -join "`n"
    'Jen instrukce' = @(
        'Co to je: Jediný soubor .github/copilot-instructions.md se vším obsahem.'
        'Kdy zvolit: Malý projekt nebo chceš začít co nejjednodušeji.'
        'Plus: Nejméně souborů, žádná další struktura, snadné review.'
        'Pozor: Chybí AGENTS.md i nastavení prostředí pro coding agenta.'
    ) -join "`n"
    'Bez skills' = @(
        'Co to je: Do výstupu se nevloží žádné postupy ani kontrolní seznamy.'
        'Kdy zvolit: Projekt nepotřebuje detailní postupy, stačí obecné instrukce.'
        'Plus: Nejkratší výstup, žádný obsah navíc.'
        'Pozor: Agent pak nemá konkrétní kroky pro jednotlivé činnosti.'
    ) -join "`n"
    'Odkazy na související soubory' = @(
        'Co to je: U každého skillu se uvedou cesty k instrukcím, agentovi a nastavení.'
        'Kdy zvolit: Projekt má více souborů s pokyny, které spolu souvisejí.'
        'Plus: Agent si snadno dohledá širší kontext.'
        'Pozor: Odkazy na neexistující soubory působí zmatečně - generuj je společně.'
    ) -join "`n"
    'Souhrnná tabulka skills' = @(
        'Co to je: Na začátek sekce skills se vloží tabulka všech vybraných skillů.'
        'Kdy zvolit: Vybíráš více skillů a chceš mít rychlý přehled.'
        'Plus: Rychlá orientace pro člověka i pro agenta.'
        'Pozor: U jednoho až dvou skillů je tabulka zbytečná.'
    ) -join "`n"
    'Frontmatter s metadaty' = @(
        'Co to je: Do SKILL.md se přidá YAML frontmatter s metadaty projektu.'
        'Kdy zvolit: Používáš rozšířený výstup se samostatným SKILL.md.'
        'Plus: Nástroje i lidé hned vidí, k jakému projektu a architektuře skill patří.'
        'Pozor: Na obsah metadat agenti obvykle nereagují, slouží hlavně pro lidi.'
    ) -join "`n"
    'Úkolový prompt v instrukcích' = @(
        'Co to je: Do instrukcí se vloží sekce s rolí agenta a konkrétními úkoly.'
        'Kdy zvolit: Chceš, aby agent věděl, kým má být a co má dělat.'
        'Plus: Úkoly se generují z tvých vybraných modulů, takže sedí na projekt.'
        'Pozor: Nezvyšuje počet souborů, ale instrukce jsou delší.'
    ) -join "`n"
    'Úkolový prompt jako samostatný soubor' = @(
        'Co to je: Vytvoří .github/prompts/<projekt>.prompt.md ke vložení do chatu.'
        'Kdy zvolit: Chceš prompt spouštět opakovaně nebo ho sdílet s týmem.'
        'Plus: V editoru se objeví jako spustitelný prompt, snadno se kopíruje.'
        'Pozor: Přidá do výstupu další soubor nad rámec zvoleného formátu.'
    ) -join "`n"
    'Před aplikací vyčistit doporučené skupiny' = @(
        'Co to je: Než se preset aplikuje, odznačí všechny volby ve skupinách, kterých se týká.'
        'Kdy zvolit: Chceš čistý start podle šablony bez zbytků předchozích výběrů.'
        'Plus: Výsledek přesně odpovídá šabloně, nic přebývá.'
        'Pozor: Přijdeš o ruční volby v dotčených skupinách - vyplň je po aplikaci znovu.'
    ) -join "`n"
    'Obecná / Univerzální' = @(
        'Co to je: Neutrální volba bez doménových doporučení.'
        'Kdy zvolit: Interní nástroj, prototyp nebo projekt, jehož doména se teprve vyjasní.'
        'Plus: Nic navíc se nepředvyplní, máš plnou kontrolu.'
        'Pozor: Nedostaneš doménová pravidla ani doporučené moduly.'
    ) -join "`n"
    'Žádná (pouze web)' = @(
        'Co to je: Bez mobilní aplikace, pouze responzivní web.'
        'Kdy zvolit: Rozpočet nebo čas nedovolí nativní aplikaci.'
        'Plus: Nejnižší náklady, jedna codebase, žádné schvalování v obchodech.'
        'Pozor: Chybí push notifikace, přístup k hardwaru a ikona na ploše.'
    ) -join "`n"
}

$script:helpTextDetail = @{}
foreach ($set in $script:helpDetailSets) { foreach ($k in $set.Keys) { $script:helpTextDetail[$k] = $set[$k] } }
foreach ($k in $script:helpTextDetail.Keys) {
    $base = $script:helpText[$k]
    if ([string]::IsNullOrWhiteSpace($base)) { $script:helpText[$k] = $script:helpTextDetail[$k] }
    else { $script:helpText[$k] = $base.TrimEnd() + "`n`n" + $script:helpTextDetail[$k] }
}

# ==========================================
# KATALOG SKILLS
# Výstup: .github/skills/<slug>/SKILL.md ve formátu GitHub Copilot Agent Skills
#   ---
#   name: <slug>
#   description: <kdy skill použít>
#   ---
# C = kategorie, S = slug (název složky), T = titulek, D = popis (kdy použít), K = checklist
# ==========================================
$script:skillCatalog = @(
    @{ C = 'Bezpečnost a soukromí'; S = 'secure-input-validation'; T = 'Validace a sanitizace vstupů'
        D = 'Validuj a sanitizuj uživatelský vstup na serveru. Použij při návrhu formulářů, API endpointů a zpracování dat od uživatele.'
        K = @('Validuj typ, rozsah a tvar na serveru', 'Odmítej neznámá pole pomocí strict schématu', 'Limituj velikost payloadu a délky řetězců', 'Normalizuj data před samotnou validací') }
    @{ C = 'Bezpečnost a soukromí'; S = 'xss-prevention'; T = 'Ochrana proti XSS'
        D = 'Escapuj a sanitizuj veškerý výstup do HTML. Použij při renderu uživatelského nebo CMS obsahu.'
        K = @('Využívej výchozí escapování šablony', 'Nepoužívej innerHTML bez sanitizace', 'Sanitizuj HTML z CMS na serveru', 'Nasazuj striktní Content Security Policy') }
    @{ C = 'Bezpečnost a soukromí'; S = 'authn-authz'; T = 'Autentizace a autorizace'
        D = 'Ověřuj identitu i oprávnění vždy na serveru. Použij při přidání chráněných stránek, API endpointů nebo rolí.'
        K = @('Ověř session nebo token u každého chráněného požadavku', 'Kontroluj oprávnění u konkrétního zdroje', 'Nikdy nedůvěřuj roli poslané z klienta', 'Zaznamenej neúspěšné pokusy o přístup') }
    @{ C = 'Bezpečnost a soukromí'; S = 'data-protection'; T = 'Ochrana citlivých dat'
        D = 'Šifruj citlivá data a minimalizuj jejich sběr. Použij při práci s osobními údaji, tokeny a platebními daty.'
        K = @('Ukládej pouze data nezbytná pro funkci', 'Hashuj hesla pomocí argon2 nebo bcrypt', 'Šifruj citlivá pole a tokeny v klidu', 'Nikdy neloguj osobní údaje ani tajemství') }
    @{ C = 'Bezpečnost a soukromí'; S = 'dependency-security'; T = 'Bezpečnost závislostí'
        D = 'Sleduj a aktualizuj závislosti, odstraňuj zranitelné balíčky. Použij při přidání nové knihovny nebo řešení bezpečnostního nálezu.'
        K = @('Před přidáním balíčku ověř jeho údržbu a popularitu', 'Spouštěj audit závislostí v CI', 'Odstraň nepoužívané závislosti', 'Připni verze a používej lockfile') }
    @{ C = 'Bezpečnost a soukromí'; S = 'secrets-management'; T = 'Správa tajemství a konfigurace'
        D = 'Uchovávej tajemství mimo kód a ověřuj konfiguraci při startu. Použij při práci s API klíči, connection stringy a ENV proměnnými.'
        K = @('Nikdy necommituj tajemství ani soubory .env', 'Validuj povinné ENV proměnné při startu', 'Používej oddělená prostředí a rotaci klíčů', 'V logu maskuj citlivé hodnoty') }

    @{ C = 'Architektura a návrh'; S = 'layered-architecture'; T = 'Vrstvená architektura'
        D = 'Drž oddělené prezentační, doménovou a datovou vrstvu. Použij při návrhu nového modulu nebo refaktoringu.'
        K = @('Prezentační vrstva nepřistupuje přímo do databáze', 'Doménová logika nezávisí na frameworku', 'Datová vrstva zapouzdřuje přístup k datům', 'Závislosti směřuj dovnitř k doméně') }
    @{ C = 'Architektura a návrh'; S = 'separation-of-concerns'; T = 'Oddělení odpovědností'
        D = 'Každá jednotka má jednu jasnou odpovědnost. Použij při návrhu funkcí, komponent a modulů.'
        K = @('Funkce řeší jednu věc a má popisný název', 'Nepřesouvej business logiku do komponent', 'Odděl vstupně-výstupní operace od výpočtu', 'Vyhýbej se globálnímu měnitelnému stavu') }
    @{ C = 'Architektura a návrh'; S = 'design-patterns'; T = 'Návrhové vzory'
        D = 'Používej zavedené vzory místo ad hoc řešení. Použij u opakujících se problémů s tvorbou objektů, stavem nebo komunikací.'
        K = @('Zvol vzor podle problému, ne podle módy', 'Preferuj kompozici před dědičností', 'Zdokumentuj netriviální vzor v kódu', 'Nepřidávej abstrakci bez druhého použití') }
    @{ C = 'Architektura a návrh'; S = 'dependency-injection'; T = 'Dependency injection'
        D = 'Předávej závislosti zvenčí místo jejich vytváření uvnitř. Použij při návrhu služeb, repozitářů a testovatelných komponent.'
        K = @('Závislosti přijímej konstruktorem nebo parametrem', 'Programuj proti rozhraní, ne proti implementaci', 'Umožni snadné nahrazení závislosti v testech', 'Vyhýbej se service locatoru') }
    @{ C = 'Architektura a návrh'; S = 'modularity'; T = 'Modularita a hranice modulů'
        D = 'Vymez moduly s jasným veřejným rozhraním. Použij při dělení monorepa nebo při růstu codebase.'
        K = @('Modul exportuje jen své veřejné rozhraní', 'Zakaž cyklické závislosti mezi moduly', 'Sdílené typy umísti do samostatného balíčku', 'Vynuť hranice lint pravidlem') }
    @{ C = 'Architektura a návrh'; S = 'architecture-decision-records'; T = 'Architektonická rozhodnutí (ADR)'
        D = 'Zaznamenej významná technická rozhodnutí a jejich důvody. Použij při volbě knihovny, architektury nebo zásadní změně.'
        K = @('Ukládej ADR do složky docs/adr', 'Uveď kontext, rozhodnutí a důsledky', 'Neměň stará ADR, přidej nové superseding', 'Odkazuj ADR z příslušného kódu') }

    @{ C = 'Datová vrstva'; S = 'data-modeling'; T = 'Datové modelování'
        D = 'Navrhni schéma s ohledem na integritu a budoucí rozvoj. Použij při návrhu nových tabulek a vztahů.'
        K = @('Každá tabulka má primární klíč a časová razítka', 'Vztahy vynuť cizími klíči', 'Peníze ukládej v minor units jako integer', 'Normalizuj, dokud to nebolí, pak denormalizuj cíleně') }
    @{ C = 'Datová vrstva'; S = 'database-migrations'; T = 'Migrace a verzování schématu'
        D = 'Veškeré změny schématu řeš migrací v repozitáři. Použij při jakékoli změně tabulek nebo indexů.'
        K = @('Migrace jsou verzované a idempotentní', 'Migraci spouštěj z přímého, ne poolovaného připojení', 'Napiš i reverzní migraci', 'Migraci otestuj na kopii produkčních dat') }
    @{ C = 'Datová vrstva'; S = 'query-indexing'; T = 'Indexování a výkon dotazů'
        D = 'Navrhuj dotazy s ohledem na indexy a plán provedení. Použij u pomalých dotazů nebo nových filtrů.'
        K = @('Indexuj sloupce používané ve WHERE a JOIN', 'Vyhýbej se funkcím nad indexovaným sloupcem', 'Ověř plán dotazu přes EXPLAIN', 'Odstraň nepoužívané indexy') }
    @{ C = 'Datová vrstva'; S = 'transactions-consistency'; T = 'Transakce a konzistence'
        D = 'Chraň kritické operace transakcemi a správnou izolací. Použij při vícekrokových změnách souvisejících dat.'
        K = @('Obklopuj vícekrokové změny transakcí', 'Drž transakce krátké', 'Řeš souběh optimistickým nebo pesimistickým zámkem', 'Neošetřuj transakce přes více požadavků') }
    @{ C = 'Datová vrstva'; S = 'connection-pooling'; T = 'Connection pooling'
        D = 'Používej pooling přiměřený prostředí (serverless vs server). Použij při připojení aplikace k databázi.'
        K = @('V serverless použij HTTP driver nebo transaction pooler', 'V dlouho běžícím serveru nastav velikost poolu', 'Nevytvářej spojení na každý požadavek', 'Sleduj vyčerpání poolu') }
    @{ C = 'Datová vrstva'; S = 'search-fulltext'; T = 'Fulltextové vyhledávání'
        D = 'Řeš vyhledávání specializovaným nástrojem, ne dotazy LIKE. Použij při hledání v textovém obsahu.'
        K = @('Použij fulltextový index nebo specializovaný engine', 'Zohledni diakritiku a stemming jazyka', 'Řeš relevanci a řazení výsledků', 'Odděl vyhledávání od transakční databáze') }

    @{ C = 'API vrstva'; S = 'rest-conventions'; T = 'REST konvence'
        D = 'Dodržuj konzistentní pojmenování a sémantiku HTTP. Použij při návrhu nových endpointů.'
        K = @('Prostředky pojmenuj podstatným jménem v množném čísle', 'Používej správné metody GET, POST, PATCH a DELETE', 'Vracej odpovídající stavové kódy', 'Nepoužívej slovesa v cestě') }
    @{ C = 'API vrstva'; S = 'api-validation'; T = 'Validace API vstupů'
        D = 'Validuj vstup na hranici API a vracej srozumitelné chyby. Použij u každého endpointu přijímajícího data.'
        K = @('Validuj tělo, parametry i hlavičky', 'Vracej stav 400 s popisem konkrétního pole', 'Ignoruj nebo odmítni neznámá pole', 'Limituj velikost těla požadavku') }
    @{ C = 'API vrstva'; S = 'api-versioning'; T = 'Verzování API'
        D = 'Zaváděj změny bez rozbití stávajících klientů. Použij při breaking change API.'
        K = @('Verzi uváděj v cestě nebo v hlavičce', 'Breaking change jen v nové verzi', 'Udržuj starou verzi po dohodnutou dobu', 'Změní dokumentuj v changelogu') }
    @{ C = 'API vrstva'; S = 'api-rate-limiting'; T = 'Rate limiting'
        D = 'Omez počet požadavků podle identity klienta. Použij u veřejných i autentizovaných endpointů.'
        K = @('Limituj podle IP adresy a uživatele', 'Vracej stav 429 s hlavičkou Retry-After', 'Použij trvanlivé počítadlo (Redis)', 'Nastav přísnější limit na citlivé operace') }
    @{ C = 'API vrstva'; S = 'api-error-handling'; T = 'Chybové stavy a kódy'
        D = 'Vracej jednotný tvar chyby bez úniku interních detailů. Použij při návrhu chybových odpovědí.'
        K = @('Používej jednotný tvar chyby (code, message, details)', 'Nevracej ani neloguj stack trace klientovi', 'Rozlišuj chybu klienta a serveru', 'Zaznamenej chybu s korelačním ID') }
    @{ C = 'API vrstva'; S = 'openapi-documentation'; T = 'Dokumentace API (OpenAPI)'
        D = 'Udržuj strojově čitelnou specifikaci API. Použij při přidání nebo změně endpointu.'
        K = @('Generuj OpenAPI z kódu nebo udržuj ručně', 'Dokumentuj schémata a chybové stavy', 'Publikuj interaktivní dokumentaci', 'Ověřuj platnost spec v CI') }

    @{ C = 'Frontend a UI'; S = 'component-architecture'; T = 'Komponentová architektura'
        D = 'Děl komponenty podle odpovědnosti a znovupoužitelnosti. Použij při tvorbě nových obrazovek a komponent.'
        K = @('Odděl prezentační a kontejnerové komponenty', 'Drž komponentu malou a zaměřenou', 'Sdílené UI umísti do vlastního balíčku', 'Vyhýbej se předávání desítek props') }
    @{ C = 'Frontend a UI'; S = 'state-management'; T = 'Správa stavu'
        D = 'Zvol nejmenší dostačující úroveň stavu. Použij při sdílení dat mezi komponentami.'
        K = @('Preferuj lokální stav před globálním', 'Server state řeš knihovnou jako TanStack Query', 'Neukládej odvozená data do stavu', 'Vyhýbej se duplicitě stavu') }
    @{ C = 'Frontend a UI'; S = 'forms-validation'; T = 'Formuláře a validace'
        D = 'Validuj na klientu pro uživatelský komfort a na serveru pro bezpečnost. Použij při tvorbě formulářů.'
        K = @('Použij stejné schéma validace na klientu i serveru', 'Zobrazuj chybu u konkrétního pole', 'Zabraň dvojímu odeslání formuláře', 'Zachovej zadaná data při chybě') }
    @{ C = 'Frontend a UI'; S = 'design-system-tokens'; T = 'Design systém a tokeny'
        D = 'Definuj barvy, typografii a rozestupy jako tokeny. Použij při tvorbě UI komponent.'
        K = @('Needitul hodnoty barev přímo v komponentě', 'Používej sémantické tokeny (surface, border, text)', 'Podporuj světlý i tmavý režim', 'Dokumentuj komponenty v katalogu') }
    @{ C = 'Frontend a UI'; S = 'responsive-design'; T = 'Responzivní design'
        D = 'Navrhuj od mobilu nahoru a testuj na reálných šířkách. Použij při tvorbě layoutu.'
        K = @('Začni mobile-first breakpointy', 'Nepoužívej pevné šířky v pixelech u layoutu', 'Testuj ovládání dotykem i klávesnicí', 'Respektuj zvětšení textu uživatelem') }
    @{ C = 'Frontend a UI'; S = 'seo-metadata'; T = 'SEO a metadata'
        D = 'Poskytuj správné meta tagy a strukturovaná data. Použij u veřejně dostupných stránek.'
        K = @('Unikátní title a description pro každou stránku', 'Doplň Open Graph a Twitter karty', 'Použij JSON-LD strukturovaná data', 'Generuj sitemap a robots.txt') }

    @{ C = 'Přístupnost (a11y)'; S = 'semantic-html'; T = 'Sémantické HTML'
        D = 'Používej správné HTML elementy místo univerzálních kontejnerů. Použij při tvorbě jakéhokoli UI.'
        K = @('Použij nav, main, header, footer, button a ul', 'Drž nadpisy v hierarchickém pořadí', 'Nepoužívej kontejner tam, kde stačí button', 'Měj jeden hlavní nadpis na stránku') }
    @{ C = 'Přístupnost (a11y)'; S = 'keyboard-navigation'; T = 'Navigace klávesnicí'
        D = 'Vše ovladatelné klávesnicí s viditelným fokusem. Použij u interaktivních prvků.'
        K = @('Všechny akce proveď i bez myši', 'Neodstraňuj outline bez náhrady', 'Zajisti logické pořadí tabulátoru', 'Zavírej modaly klávesou Escape') }
    @{ C = 'Přístupnost (a11y)'; S = 'aria-screen-readers'; T = 'ARIA a čtečky obrazovky'
        D = 'Doplň ARIA tam, kde sémantika nestačí. Použij u vlastních a složených komponent.'
        K = @('Preferuj nativní sémantiku před ARIA', 'Popiš ikonová tlačítka přes aria-label', 'Oznamuj dynamické změny přes aria-live', 'Neskrývej fokusované prvky přes aria-hidden') }
    @{ C = 'Přístupnost (a11y)'; S = 'accessible-media'; T = 'Přístupná média a alt texty'
        D = 'Doplň alternativní text a titulky k médiím. Použij u obrázků, videí a ikon.'
        K = @('Smysluplný alt text, u dekorativních prázdný', 'Doplň titulky u videa a přepis u audia', 'Nepoužívej obrázek jako jediný nositel textu', 'Zajisti ovládání přehrávače klávesnicí') }
    @{ C = 'Přístupnost (a11y)'; S = 'color-contrast'; T = 'Kontrast a vizuální přístupnost'
        D = 'Zajisti dostatečný kontrast a nespoléhej jen na barvu. Použij při návrhu barevných stavů.'
        K = @('Dodrž kontrast textu alespoň 4.5:1', 'Nevyjadřuj stav pouze barvou', 'Ověř kontrast v tmavém i světlém režimu', 'Nepoužívej blikající obsah') }
    @{ C = 'Přístupnost (a11y)'; S = 'accessible-forms'; T = 'Přístupné formuláře'
        D = 'Propoj popisky, chyby a pole formuláře. Použij u každého formuláře.'
        K = @('Každé pole má label propojený přes for a id', 'Chybu oznam přes aria-describedby', 'Povinná pole označ i textově', 'Seskup související pole pomocí fieldset') }

    @{ C = 'Testování a kvalita'; S = 'testing-strategy'; T = 'Testovací strategie'
        D = 'Rozvrhni testy podle rizika a nákladů. Použij při zavádění testů do projektu.'
        K = @('Piš hodně unit, méně integračních a málo E2E testů', 'Testuj business logiku, ne framework', 'Kritické cesty pokryj E2E testem', 'Zajisti determinismus testů') }
    @{ C = 'Testování a kvalita'; S = 'unit-testing'; T = 'Unit testy'
        D = 'Testuj malé jednotky izolovaně a rychle. Použij pro funkce a čistou logiku.'
        K = @('Jeden test ověřuje jedno chování', 'Název testu popisuje očekávané chování', 'Strukturuj test podle Arrange-Act-Assert', 'Vyhýbej se sdílenému měnitelnému stavu') }
    @{ C = 'Testování a kvalita'; S = 'integration-testing'; T = 'Integrační testy'
        D = 'Ověřuj spolupráci vrstev včetně databáze. Použij u repozitářů a API handlerů.'
        K = @('Používej reálnou databázi v kontejneru', 'Každý test si připraví vlastní data', 'Uklízej data po skončení testu', 'Netestuj implementační detaily') }
    @{ C = 'Testování a kvalita'; S = 'e2e-testing'; T = 'E2E testy'
        D = 'Testuj klíčové uživatelské cesty v prohlížeči. Použij u kritických toků, jako je přihlášení nebo platba.'
        K = @('Pokryj jen kritické toky', 'Selektory vybírej podle role nebo data-testid', 'Spouštěj testy proti reálnému buildu', 'Řeš přihlášení přes uložený stav') }
    @{ C = 'Testování a kvalita'; S = 'mocking-fixtures'; T = 'Mockování a fixtures'
        D = 'Nahrazuj vnější závislosti a připravuj testovací data. Použij u testů se sítí, časem nebo náhodou.'
        K = @('Mockuj na hranici systému, ne uvnitř logiky', 'Použij MSW nebo obdobu na úrovni sítě', 'Zafixuj čas a náhodu v testech', 'Uchovávej fixtures v repozitáři') }
    @{ C = 'Testování a kvalita'; S = 'type-safety'; T = 'Typová bezpečnost'
        D = 'Vynuť striktní typy a validuj data na hranicích systému. Použij v TypeScript kódu.'
        K = @('Zapni strict a zakaž typ any', 'Validuj externí data schématem (Zod)', 'Odvozuj typy ze schématu', 'Nepoužívej přetypování bez důvodu') }

    @{ C = 'DevOps a CI/CD'; S = 'ci-pipeline'; T = 'CI pipeline'
        D = 'Automatizuj kontrolu kvality u každé změny. Použij při nastavení CI.'
        K = @('Spouštěj CI na každý pull request', 'Řaď kroky od nejrychlejšího', 'Cache závislosti', 'Zastav pipeline při první chybě') }
    @{ C = 'DevOps a CI/CD'; S = 'cd-deployment'; T = 'Nasazení a release'
        D = 'Nasaď automaticky a vratně. Použij při nastavení deploymentu.'
        K = @('Nasazuj až po zeleném CI', 'Používej preview prostředí u pull requestu', 'Umožni rychlý rollback', 'Verzuj každý release tagem') }
    @{ C = 'DevOps a CI/CD'; S = 'environments-config'; T = 'Prostředí a konfigurace'
        D = 'Odděl konfiguraci od kódu a drž prostředí konzistentní. Použij při práci s ENV proměnnými.'
        K = @('Konfiguraci načítej z prostředí', 'Nikdy necommituj soubor .env', 'Dokumentuj povinné proměnné v .env.example', 'Ověř konfiguraci při startu aplikace') }
    @{ C = 'DevOps a CI/CD'; S = 'containerization'; T = 'Kontejnerizace'
        D = 'Sestav malý, reprodukovatelný a bezpečný image. Použij při tvorbě Dockerfile.'
        K = @('Použij multi-stage build', 'Nespouštěj kontejner jako root', 'Připni konkrétní verzi základního image', 'Přidej soubor .dockerignore') }
    @{ C = 'DevOps a CI/CD'; S = 'infrastructure-as-code'; T = 'Infrastruktura jako kód'
        D = 'Spravuj infrastrukturu deklarativně a verzovaně. Použij u cloudových zdrojů.'
        K = @('Definuj veškeré zdroje v IaC', 'Změny infrastruktury procházejí review', 'Drž stav v bezpečném remote backendu', 'Odděl prostředí pomocí workspace') }
    @{ C = 'DevOps a CI/CD'; S = 'monitoring-alerting'; T = 'Monitoring a alerting'
        D = 'Měř zdraví aplikace a upozorňuj na anomálie. Použij po nasazení do produkce.'
        K = @('Sleduj dostupnost, latenci a chybovost', 'Alertuj na symptomy, ne na příčiny', 'Každý alert má vlastní runbook', 'Sniž šum v alertech') }

    @{ C = 'Výkon a optimalizace'; S = 'frontend-performance'; T = 'Výkon frontendu'
        D = 'Sniž objem JavaScriptu a počet blokujících požadavků. Použij při pomalém načítání stránky.'
        K = @('Děl kód a lazy-loaduj netriviální části', 'Neposílej klientu data, která nepotřebuje', 'Optimalizuj kritickou cestu renderu', 'Měř v reálném prostředí, ne jen lokálně') }
    @{ C = 'Výkon a optimalizace'; S = 'backend-performance'; T = 'Výkon backendu'
        D = 'Odstraň zbytečnou práci na serveru. Použij u pomalých endpointů.'
        K = @('Vyhýbej se N+1 dotazům', 'Cacheuj drahé a stabilní výpočty', 'Přesuň práci mimo požadavek, kde to jde', 'Profiluj před optimalizací') }
    @{ C = 'Výkon a optimalizace'; S = 'caching-strategies'; T = 'Cache strategie'
        D = 'Cacheuj cíleně se správnou invalidací. Použij u drahých nebo opakovaných dat.'
        K = @('Rozhodni, kde cache žije (klient, server, CDN)', 'Nastav TTL a způsob invalidace', 'Zahrň uživatele do cache klíče', 'Pozor na únik citlivých dat') }
    @{ C = 'Výkon a optimalizace'; S = 'database-optimization'; T = 'Optimalizace databáze'
        D = 'Zrychli dotazy pomocí schématu, indexů a plánu. Použij u pomalých dotazů.'
        K = @('Změř plán dotazu před změnou', 'Přidej index podle reálných dotazů', 'Vyhýbej se dotazu SELECT s hvězdičkou', 'Zvaž materializovaný pohled u agregací') }
    @{ C = 'Výkon a optimalizace'; S = 'media-optimization'; T = 'Optimalizace obrázků a médií'
        D = 'Doručuj média v odpovídající velikosti a formátu. Použij u obrázků a videa.'
        K = @('Použij moderní formáty AVIF a WebP', 'Nastav správné rozměry a srcset', 'Lazy-loaduj obsah pod přehybem', 'Videa streamuj, nestahuj celá') }
    @{ C = 'Výkon a optimalizace'; S = 'cdn-delivery'; T = 'CDN a doručování obsahu'
        D = 'Doručuj statický obsah z edge sítě. Použij u veřejných statických souborů.'
        K = @('Drž statické assety na CDN s dlouhou cache', 'Verzuj názvy souborů kvůli cache busting', 'Necacheuj citlivá data na edge', 'Nastav správné cache hlavičky') }

    @{ C = 'Dokumentace a spolupráce'; S = 'readme-onboarding'; T = 'README a onboarding'
        D = 'Umožni novému vývojáři spustit projekt bez doplňujících otázek. Použij při založení projektu.'
        K = @('Popiš účel, stack a požadavky', 'Uveď kroky spuštění jako kopírovatelný blok', 'Dokumentuj povinné ENV proměnné', 'Aktualizuj při změně postupu') }
    @{ C = 'Dokumentace a spolupráce'; S = 'code-documentation'; T = 'Dokumentace kódu'
        D = 'Dokumentuj veřejné rozhraní a netriviální rozhodnutí. Použij u exportovaných funkcí a složité logiky.'
        K = @('Dokumentuj veřejné funkce a typy pomocí JSDoc', 'Komentuj důvod, ne popis kódu', 'Odstraň zastaralé komentáře', 'Nepiš komentáře, které jen opakují kód') }
    @{ C = 'Dokumentace a spolupráce'; S = 'changelog-versioning'; T = 'Changelog a verzování'
        D = 'Veď přehled změn a drž sémantické verzování. Použij při vydání verze.'
        K = @('Drž changelog ve formátu Keep a Changelog', 'Dodrž sémantické verzování', 'Zvýrazni breaking changes', 'Generuj poznámky k vydání z commitů') }
    @{ C = 'Dokumentace a spolupráce'; S = 'commit-conventions'; T = 'Konvence commitů'
        D = 'Piš malé a popisné commity v konvenčním formátu. Použij při každém commitu.'
        K = @('Používej Conventional Commits', 'Jeden commit řeší jednu věc', 'Popisuj dopad, ne jen změněný soubor', 'Nikdy necommituj tajemství ani build artefakty') }
    @{ C = 'Dokumentace a spolupráce'; S = 'code-review-guidelines'; T = 'Code review guidelines'
        D = 'Kontroluj správnost, čitelnost a rizika místo stylu. Použij při review pull requestu.'
        K = @('Zaměř se na logiku, bezpečnost a hraniční stavy', 'Malé pull requesty se reviewují rychleji', 'Buď konkrétní a navrhni řešení', 'Kritizuj kód, ne autora') }
    @{ C = 'Dokumentace a spolupráce'; S = 'contributing-workflow'; T = 'Workflow příspěvků'
        D = 'Definuj jasný postup větvení a pull requestu. Použij při nastavení repozitáře.'
        K = @('Popiš vytvoření větve a pull requestu v CONTRIBUTING.md', 'Vyžaduj zelené CI před mergem', 'Použij šablonu pull requestu', 'Chraň hlavní větev') }

    @{ C = 'AI integrace'; S = 'llm-integration'; T = 'Integrace LLM'
        D = 'Abstrahuj poskytovatele modelu a řeš chyby i limity. Použij při volání LLM z aplikace.'
        K = @('Obal poskytovatele vlastním rozhraním', 'Ošetři timeout, rate limit a chyby', 'Streamuj odpověď směrem k uživateli', 'Nikdy nevkládej klíč do klientu') }
    @{ C = 'AI integrace'; S = 'prompt-engineering'; T = 'Prompt engineering'
        D = 'Piš prompty strukturovaně a verzuj je v repozitáři. Použij při tvorbě promptů.'
        K = @('Uchovávej prompt v repozitáři a verzuj jej', 'Definuj roli, vstup a formát výstupu', 'Vyžaduj strukturovaný výstup', 'Testuj prompt na sadě případů') }
    @{ C = 'AI integrace'; S = 'rag-embeddings'; T = 'RAG a embeddings'
        D = 'Doplň model o vlastní znalosti pomocí retrieval. Použij u dotazů nad firemními daty.'
        K = @('Děl dokumenty na překrývající se chunky', 'Ukládej embeddingy ve vektorové databázi', 'Vracej citace zdrojů', 'Aktualizuj index při změně dat') }
    @{ C = 'AI integrace'; S = 'ai-agents-tools'; T = 'AI agenti a nástroje'
        D = 'Definuj bezpečné a úzce vymezené nástroje pro agenty. Použij při tvorbě agentů.'
        K = @('Každý nástroj má jasný účel a validované vstupy', 'Omez oprávnění na minimum', 'Vyžaduj potvrzení u destruktivních akcí', 'Loguj každé volání nástroje') }
    @{ C = 'AI integrace'; S = 'ai-safety'; T = 'Bezpečnost AI'
        D = 'Braň prompt injection a úniku dat. Použij u funkcí postavených na LLM.'
        K = @('Neslévej instrukce uživatele se systémovým promptem', 'Validuj a filtruj výstup modelu', 'Nevkládej citlivá data do promptu', 'Omez dopad volaných nástrojů') }
    @{ C = 'AI integrace'; S = 'ai-cost-management'; T = 'Náklady na AI'
        D = 'Sleduj a omezte náklady na volání modelu. Použij u produkčních AI funkcí.'
        K = @('Loguj spotřebu tokenů a náklady', 'Nastav limity na uživatele a organizaci', 'Cacheuj opakované dotazy', 'Vol model podle složitosti úlohy') }

    @{ C = 'Lokalizace a obsah'; S = 'i18n-implementation'; T = 'Implementace i18n'
        D = 'Připrav aplikaci na více jazyků od začátku. Použij při tvorbě UI textů.'
        K = @('Nepiš texty přímo do komponent', 'Používej typované překladové klíče', 'Formátuj datum, číslo a měnu podle locale', 'Počítej s delšími překlady v layoutu') }
    @{ C = 'Lokalizace a obsah'; S = 'content-localization'; T = 'Lokalizace obsahu'
        D = 'Překládej obsah včetně kontextu a kulturních rozdílů. Použij při tvorbě obsahu pro více trhů.'
        K = @('Překládej význam, ne slova', 'Odděl text od formátování', 'Respektuj regionální formáty a měny', 'Udržuj konzistentní terminologii v glosáři') }
    @{ C = 'Lokalizace a obsah'; S = 'cms-content-management'; T = 'Správa obsahu a CMS'
        D = 'Odděl obsah od kódu a umožni editaci bez nasazení. Použij u dynamického obsahu.'
        K = @('Ukládej obsah mimo kód (CMS nebo MDX)', 'Používej typované schéma obsahu', 'Podporuj verzování a náhled', 'Sanitizuj HTML z editoru') }
    @{ C = 'Lokalizace a obsah'; S = 'legal-gdpr'; T = 'Právní a GDPR požadavky'
        D = 'Sbírej jen nezbytné údaje a se souhlasem. Použij při zpracování osobních údajů.'
        K = @('Souhlas s cookies musí být opt-in', 'Umožni výmaz a export dat', 'Veď evidenci zpracování údajů', 'Nastav retenci a zálohování') }
    @{ C = 'Lokalizace a obsah'; S = 'accessibility-compliance'; T = 'Soulad s přístupností'
        D = 'Splň standard WCAG 2.2 úrovně AA. Použij u veřejně dostupných aplikací.'
        K = @('Cíl na úroveň AA', 'Automatizuj audit přístupnosti v CI', 'Testuj i se čtečkou obrazovky', 'Doplň prohlášení o přístupnosti') }
    @{ C = 'Lokalizace a obsah'; S = 'content-seo-strategy'; T = 'Obsahová a SEO strategie'
        D = 'Propoj obsah, strukturu a technické SEO. Použij při budování organické návštěvnosti.'
        K = @('Každá stránka má jeden hlavní záměr', 'Propojuj stránky interními odkazy', 'Udržuj konzistentní strukturu URL', 'Měř a vyhodnocuj výsledky') }
)

# Obecné kroky postupu podle kategorie (použijí se v každém SKILL.md)
$script:skillCategorySteps = @{
    'Bezpečnost a soukromí'          = @('Identifikuj vstupní body a citlivá data.', 'Aplikuj ochranu na serveru, ne pouze v klientu.', 'Ověř výsledek testem zaměřeným na zneužití.')
    'Architektura a návrh'           = @('Sepiš požadavky a hranice řešení.', 'Zvol nejjednodušší variantu splňující požadavky.', 'Zdokumentuj rozhodnutí a jeho důsledky.')
    'Datová vrstva'                  = @('Definuj entitu, vztahy a invarianty.', 'Navrhni dotazy a indexy podle reálného přístupu.', 'Přidej migraci a test konzistence.')
    'API vrstva'                     = @('Definuj kontrakt a stavové kódy.', 'Validuj vstup na hranici API.', 'Zdokumentuj změnu a otestuj chybové stavy.')
    'Frontend a UI'                  = @('Rozlož obrazovku na komponenty podle odpovědnosti.', 'Zvol nejmenší dostačující stav.', 'Otestuj responzivitu i ovládání klávesnicí.')
    'Přístupnost (a11y)'             = @('Použij nativní sémantiku jako základ.', 'Doplň ARIA jen tam, kde sémantika nestačí.', 'Ověř klávesnicí a čtečkou obrazovky.')
    'Testování a kvalita'            = @('Rozhodni, jaké riziko test pokrývá.', 'Testuj chování, ne implementaci.', 'Zajisti determinismus a rychlost testu.')
    'DevOps a CI/CD'                 = @('Definuj krok opakovatelně a idempotentně.', 'Zajisti rychlou zpětnou vazbu.', 'Připrav cestu zpět (rollback).')
    'Výkon a optimalizace'           = @('Nejprve změř a najdi úzké hrdlo.', 'Optimalizuj jednu věc a znovu změř.', 'Zaznamenej výchozí a cílové hodnoty.')
    'Dokumentace a spolupráce'       = @('Piš pro člověka, který projekt vidí poprvé.', 'Drž dokumentaci blízko kódu.', 'Aktualizuj ji při každé změně chování.')
    'AI integrace'                   = @('Definuj vstup, výstup a limity.', 'Ošetři chyby, náklady a soukromí.', 'Vyhodnoť kvalitu na sadě případů.')
    'Lokalizace a obsah'            = @('Odděl obsah od kódu a formátování.', 'Připrav strukturu pro více jazyků.', 'Ověř délky, formáty a soulad s legislativou.')
}

# Popisy skills slouží zároveň jako tooltipy
# Tooltip pro skill = popis, postup a kontrolní seznam z katalogu
foreach ($sk in $script:skillCatalog) {
    $tipLines = @($sk.D, '', 'Postup:')
    foreach ($step in $script:skillCategorySteps[$sk.C]) { $tipLines += "  - $step" }
    $tipLines += @('', 'Kontrolní seznam:')
    foreach ($item in $sk.K) { $tipLines += "  - $item" }
    $tipLines += @('', "Kategorie: $($sk.C)", "Výstup: .agents/skills/$($sk.S)/SKILL.md")
    $script:helpText[$sk.T] = ($tipLines -join "`n")
}

Function Get-HelpText($key) {
    if ($script:helpText.ContainsKey($key)) { return $script:helpText[$key] }
    return "Klikněte pro výběr této možnosti."
}

# ==========================================
# REFERENČNÍ UI: NAVIGACE + KARTY
# ==========================================
$form = New-Object System.Windows.Forms.Form
$form.Text = "Copilot Workspace Architect"
$form.Size = New-Object System.Drawing.Size(1640, 920)
$form.MinimumSize = New-Object System.Drawing.Size(1180, 760)
$form.StartPosition = "CenterScreen"
$form.BackColor = $script:colors.Background
$form.ForeColor = $script:colors.TextPrimary
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)

$panelBottom = New-Object System.Windows.Forms.Panel
$panelBottom.Dock = [System.Windows.Forms.DockStyle]::Bottom
$panelBottom.Height = 86
$panelBottom.BackColor = $script:colors.Background
$form.Controls.Add($panelBottom)
$panelBottom.Add_Paint({ param($s, $e); $p = New-Object System.Drawing.Pen($script:colors.Border); $e.Graphics.DrawLine($p, 0, 0, $s.Width, 0); $p.Dispose() })

$chkShowHelp = New-Object System.Windows.Forms.CheckBox
$chkShowHelp.Text = "  Zobrazovat nápovědu"
$chkShowHelp.Checked = $true
$chkShowHelp.Location = New-Object System.Drawing.Point(76, 30)
$chkShowHelp.Size = New-Object System.Drawing.Size(260, 28)
$chkShowHelp.ForeColor = $script:colors.TextSecondary
$chkShowHelp.BackColor = $script:colors.Background
$chkShowHelp.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$chkShowHelp.Cursor = [System.Windows.Forms.Cursors]::Hand
$panelBottom.Controls.Add($chkShowHelp)
$lblHint = New-Object System.Windows.Forms.Label
$lblHint.Text = "?"
$lblHint.Location = New-Object System.Drawing.Point(30, 27)
$lblHint.Size = New-Object System.Drawing.Size(30, 32)
$lblHint.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Regular)
$lblHint.ForeColor = $script:colors.TextSecondary
$panelBottom.Controls.Add($lblHint)

$lblPresetHint = New-Object System.Windows.Forms.Label
$lblPresetHint.Text = ""
$lblPresetHint.Location = New-Object System.Drawing.Point(360, 24)
$lblPresetHint.Size = New-Object System.Drawing.Size(620, 44)
$lblPresetHint.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$lblPresetHint.ForeColor = $script:colors.Emerald
$lblPresetHint.BackColor = $script:colors.Background
$lblPresetHint.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
$panelBottom.Controls.Add($lblPresetHint)

$btnOk = New-Object System.Windows.Forms.Button
$btnOk.Text = "  ✦  Vygenerovat Master TS Kontext"
$btnOk.Size = New-Object System.Drawing.Size(300, 42)
$btnOk.Location = New-Object System.Drawing.Point(0, 22)
$btnOk.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
$btnOk.BackColor = $script:colors.Emerald
$btnOk.ForeColor = $script:colors.Black
$btnOk.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnOk.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnOk.FlatAppearance.BorderSize = 0
$btnOk.FlatAppearance.MouseOverBackColor = $script:colors.EmeraldLight
$btnOk.FlatAppearance.MouseDownBackColor = $script:colors.EmeraldDark
$btnOk.Cursor = [System.Windows.Forms.Cursors]::Hand
$panelBottom.Controls.Add($btnOk)
$panelBottom.Add_Resize({ $btnOk.Left = $panelBottom.ClientSize.Width - $btnOk.Width - 28 })
$btnOk.Left = $panelBottom.ClientSize.Width - $btnOk.Width - 28

# --- Uložení a načtení konfigurace ---
$btnLoadConfig = New-Object System.Windows.Forms.Button
$btnLoadConfig.Text = "Načíst"
$btnLoadConfig.Size = New-Object System.Drawing.Size(110, 42)
$btnLoadConfig.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnLoadConfig.FlatAppearance.BorderColor = $script:colors.BorderStrong
$btnLoadConfig.FlatAppearance.BorderSize = 1
$btnLoadConfig.BackColor = $script:colors.Surface
$btnLoadConfig.ForeColor = $script:colors.TextPrimary
$btnLoadConfig.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$btnLoadConfig.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnLoadConfig.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
$panelBottom.Controls.Add($btnLoadConfig)

$btnSaveConfig = New-Object System.Windows.Forms.Button
$btnSaveConfig.Text = "Uložit"
$btnSaveConfig.Size = New-Object System.Drawing.Size(110, 42)
$btnSaveConfig.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnSaveConfig.FlatAppearance.BorderColor = $script:colors.BorderStrong
$btnSaveConfig.FlatAppearance.BorderSize = 1
$btnSaveConfig.BackColor = $script:colors.Surface
$btnSaveConfig.ForeColor = $script:colors.TextPrimary
$btnSaveConfig.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$btnSaveConfig.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnSaveConfig.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
$panelBottom.Controls.Add($btnSaveConfig)

$btnClearTab = New-Object System.Windows.Forms.Button
$btnClearTab.Text = "Vyčistit záložku"
$btnClearTab.Size = New-Object System.Drawing.Size(140, 42)
$btnClearTab.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnClearTab.FlatAppearance.BorderColor = $script:colors.BorderStrong
$btnClearTab.FlatAppearance.BorderSize = 1
$btnClearTab.BackColor = $script:colors.Surface
$btnClearTab.ForeColor = $script:colors.TextSecondary
$btnClearTab.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$btnClearTab.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnClearTab.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
$panelBottom.Controls.Add($btnClearTab)

$panelBottom.Add_Resize({
    $btnOk.Left = $panelBottom.ClientSize.Width - $btnOk.Width - 28
    $btnLoadConfig.Left = $btnOk.Left - $btnLoadConfig.Width - 10
    $btnSaveConfig.Left = $btnLoadConfig.Left - $btnSaveConfig.Width - 10
    $btnClearTab.Left = $btnSaveConfig.Left - $btnClearTab.Width - 10
})
$btnLoadConfig.Left = $btnOk.Left - $btnLoadConfig.Width - 10
$btnSaveConfig.Left = $btnLoadConfig.Left - $btnSaveConfig.Width - 10
$btnClearTab.Left = $btnSaveConfig.Left - $btnClearTab.Width - 10

$nav = New-Object System.Windows.Forms.Panel
$nav.Dock = [System.Windows.Forms.DockStyle]::Top
$nav.Height = 88
$nav.BackColor = $script:colors.TitleBar
$form.Controls.Add($nav)

$content = New-Object System.Windows.Forms.Panel
$content.Dock = [System.Windows.Forms.DockStyle]::Fill
$content.BackColor = $script:colors.Background
$form.Controls.Add($content)

$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Dock = [System.Windows.Forms.DockStyle]::Fill
$tabControl.Appearance = [System.Windows.Forms.TabAppearance]::FlatButtons
$tabControl.ItemSize = New-Object System.Drawing.Size(1, 1)
$tabControl.SizeMode = [System.Windows.Forms.TabSizeMode]::Fixed
$tabControl.Padding = New-Object System.Drawing.Point(0, 0)
$tabControl.BackColor = $script:colors.Background
$tabControl.ForeColor = $script:colors.TextPrimary
$content.Controls.Add($tabControl)

$script:navButtons = @()
$navItems = @(
    @("⚡", "Presety"),
    @("⌘", "Architektura"), @("</>", "Frontend"), @("▤", "Backend"), @("☁", "DevOps"),
    @("♢", "Bezpečnost"), @("✚", "Funkce"), @("▯", "Mobil"), @("◇", "Moduly"),
    @("◆", "Skills"), @("✓", "Chování"), @("▱", "Slovník")
)
for ($i = $navItems.Count - 1; $i -ge 0; $i--) {
    $button = New-Object System.Windows.Forms.Button
    $button.Text = "$($navItems[$i][0])`n$($navItems[$i][1])"
    $button.Tag = $i
    $button.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $button.FlatAppearance.BorderSize = 0
    $button.BackColor = $script:colors.TitleBar
    $button.ForeColor = $script:colors.TextSecondary
    $button.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
    $button.Cursor = [System.Windows.Forms.Cursors]::Hand
    $button.Dock = [System.Windows.Forms.DockStyle]::Left
    $button.Width = 150
    $button.Add_Click({ $tabControl.SelectedIndex = [int]$this.Tag; Update-Navigation })
    $nav.Controls.Add($button)
    $script:navButtons += $button
}
$nav.Add_Resize({
    $itemWidth = [Math]::Max(1, [int]($nav.ClientSize.Width / $script:navButtons.Count))
    foreach ($button in $script:navButtons) { $button.Width = $itemWidth }
})

Function Update-Navigation {
    foreach ($button in $script:navButtons) {
        $active = ([int]$button.Tag -eq $tabControl.SelectedIndex)
        $button.ForeColor = if ($active) { $script:colors.Emerald } else { $script:colors.TextSecondary }
        $button.BackColor = if ($active) { $script:colors.EmeraldGlow } else { $script:colors.TitleBar }
    }
    Update-NavCounts
}

# Pocty zaskrtnutych voleb u jednotlivych zalozek v navigaci
Function Update-NavCounts {
    foreach ($button in $script:navButtons) {
        $idx = [int]$button.Tag
        if ($idx -ge $tabControl.TabPages.Count) { continue }
        $page = $tabControl.TabPages[$idx]
        $n = 0
        foreach ($card in @($page.Controls | Where-Object { $_ -is [System.Windows.Forms.Panel] })) {
            $n += @($card.Controls | Where-Object { $_ -is [System.Windows.Forms.CheckBox] -and $_.Checked }).Count
        }
        $label = $navItems[$idx][1]
        $icon = $navItems[$idx][0]
        $button.Text = if ($n -gt 0) { "$icon`n$label ($n)" } else { "$icon`n$label" }
    }
}

Function New-ReferencePage($title) {
    $page = New-Object System.Windows.Forms.TabPage($title)
    $page.BackColor = $script:colors.Background
    $page.Padding = New-Object System.Windows.Forms.Padding(0)
    $page.AutoScroll = $true
    $page.AutoScrollMinSize = New-Object System.Drawing.Size(1400, 820)
    $tabControl.Controls.Add($page)
    return $page
}

Function Add-ReferenceCard($parent, $title, $description, $icon, $items, $kind, $x, $y, $w, $h) {
    $card = New-Object System.Windows.Forms.Panel
    $card.Location = New-Object System.Drawing.Point(($x + 34), ($y + 120))
    $card.Size = New-Object System.Drawing.Size($w, $h)
    $card.BackColor = $script:colors.Surface
    $card.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $parent.Controls.Add($card)
    $iconLabel = New-Object System.Windows.Forms.Label
    $iconLabel.Text = $icon
    $iconLabel.Location = New-Object System.Drawing.Point(24, 18)
    $iconLabel.Size = New-Object System.Drawing.Size(42, 38)
    $iconLabel.Font = New-Object System.Drawing.Font("Segoe UI Symbol", 23)
    $iconLabel.ForeColor = $script:colors.Emerald
    $card.Controls.Add($iconLabel)
    $heading = New-Object System.Windows.Forms.Label
    $heading.Text = $title
    $heading.Location = New-Object System.Drawing.Point(78, 18)
    $heading.Size = New-Object System.Drawing.Size(($w - 98), 27)
    $heading.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
    $heading.ForeColor = $script:colors.TextPrimary
    $card.Controls.Add($heading)
    $desc = New-Object System.Windows.Forms.Label
    $desc.Text = $description
    $desc.Location = New-Object System.Drawing.Point(78, 47)
    $desc.Size = New-Object System.Drawing.Size(($w - 98), 24)
    $desc.Font = New-Object System.Drawing.Font("Segoe UI", 8.5)
    $desc.ForeColor = $script:colors.TextSecondary
    $card.Controls.Add($desc)
    $controls = @()
    $curY = 82
    foreach ($item in $items) {
        $control = New-Object System.Windows.Forms.CheckBox
        $control.Text = $item
        $control.Location = New-Object System.Drawing.Point(28, $curY)
        $control.Size = New-Object System.Drawing.Size(($w - 48), 27)
        $control.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
        $control.ForeColor = $script:colors.TextPrimary
        $control.BackColor = $script:colors.Surface
        $control.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
        $control.UseVisualStyleBackColor = $false
        $control.FlatAppearance.BorderColor = $script:colors.BorderStrong
        $control.FlatAppearance.BorderSize = 1
        $control.FlatAppearance.CheckedBackColor = $script:colors.Emerald
        $control.FlatAppearance.MouseOverBackColor = $script:colors.SurfaceHover
        $control.FlatAppearance.MouseDownBackColor = $script:colors.EmeraldDark
        $control.Cursor = [System.Windows.Forms.Cursors]::Hand
        if ($kind -eq "radio") {
            # Jednovyberova karta: zadny predvyber, po zaskrtnuti se sourozenci odznaci,
            # opetovnym kliknutim na zaskrtnutou volbu se vyber zrusi (stav "nevybrano").
            $control.Tag = "single"
            $control.Add_Click({
                if ($this.Checked -and $this.Tag -eq "single") {
                    foreach ($sibling in $this.Parent.Controls) {
                        if ($sibling -is [System.Windows.Forms.CheckBox] -and $sibling -ne $this) { $sibling.Checked = $false }
                    }
                }
            })
        } else {
            $control.Tag = "multi"
        }
        $script:tooltip.SetToolTip($control, (Get-HelpText $item))
        $card.Controls.Add($control)
        $controls += $control
        $curY += 27
    }
    # Skutecna potrebna vyska karty (hlavicka + popis + vsechny volby + odsazeni)
    $card.Tag = 82 + (27 * $items.Count) + 16
    return $controls
}

# Po vytvoreni vsech karet prelayoutuje stranku: karty roztahne na potrebnou
# vysku a prelozi radky pod sebe, aby se obsah nikdy neorezal ani neprekryl.
Function Repair-PageLayout($page) {
    $cards = @($page.Controls | Where-Object { $_ -is [System.Windows.Forms.Panel] })
    if ($cards.Count -eq 0) { return 0 }
    $rows = $cards | Group-Object { $_.Top } | Sort-Object { [int]$_.Name }
    $curTop = 120
    foreach ($row in $rows) {
        $rowCards = @($row.Group | Sort-Object Left)
        foreach ($c in $rowCards) {
            if ($c.Tag -is [int] -and $c.Height -lt [int]$c.Tag) { $c.Height = [int]$c.Tag }
        }
        $rowH = ($rowCards | Measure-Object -Property Height -Maximum).Maximum
        foreach ($c in $rowCards) {
            foreach ($child in $c.Controls) {
                if ($child -is [System.Windows.Forms.Label]) {
                    if ($child.Left -gt 70 -and $child.Top -eq 18) { $child.Width = $c.Width - 98 }
                    if ($child.Left -gt 70 -and $child.Top -eq 47) { $child.Width = $c.Width - 98 }
                }
                if (($child -is [System.Windows.Forms.RadioButton]) -or ($child -is [System.Windows.Forms.CheckBox])) {
                    $child.Width = $c.Width - 48
                }
            }
            $c.Top = $curTop
        }
        $curTop += $rowH + 20
    }
    return ($curTop + 20)
}

Function Add-RadioGroup($parent, $title, $items, $x, $y, $w, $h) {
    return Add-ReferenceCard $parent $title "Volitelné: vyberte jednu možnost, nebo nechte nevybráno." "◉" $items "radio" $x $y $w $h
}
Function Add-CheckGroup($parent, $title, $items, $x, $y, $w, $h) {
    return Add-ReferenceCard $parent $title "Volitelné moduly a integrace." "◇" $items "check" $x $y $w $h
}

Function Add-PageCards($page, $cards) {
    $x = 0; $y = 0; $col = 0; $rowHeight = 0
    foreach ($card in $cards) {
        $card[0] = Add-RadioGroup $page $card[1] $card[2] ($col * 460) $y 440 $card[3]
        $col++
        if ($col -eq 3) { $col = 0; $y += $card[3] + 20 }
    }
}

$tabPreset = New-ReferencePage "Presety"
$tab1 = New-ReferencePage "Architektura"

# ---- Sdílené seznamy voleb (používá je záložka Presety i původní záložky) ----
$optDomains = @("Obecná / Univerzální", "E-shop / E-commerce", "Rezervační systém (salon, lékař, restaurace)", "SaaS platforma", "LMS (Learning Management System)", "Sociální síť / Komunita", "Blog / Magazín / Média", "Marketplace (více prodejců)", "CRM / Interní nástroj", "Portfolio / Prezentační web", "Booking + platby (kombinace)")
$optFrameworks = @("Next.js (App Router)", "React + Vite", "Vue 3 + Vite", "Nuxt 3/4", "SvelteKit", "Astro (Islands Architecture)", "Angular 22", "React Router v8 (framework mode)")
$optMobilePlat = @("Žádná (pouze web)", "React Native + Expo (SDK 57+)", "React Native (bare, bez Expo)", "Flutter", "Capacitor (web → nativní)", "PWA (Progressive Web App)")
$optTargets = @("Pouze web (desktop + mobil)", "Web + Administrace", "Web + Administrace + Mobilní aplikace", "Web + Mobilní aplikace (bez adminu)", "PWA (Progressive Web App)")
$tab2 = New-ReferencePage "Frontend"
$tab3 = New-ReferencePage "Backend"
$tab4 = New-ReferencePage "DevOps"
$tab5 = New-ReferencePage "Bezpečnost"
$tab6 = New-ReferencePage "Funkce"
$tab7 = New-ReferencePage "Mobil"
$tab8 = New-ReferencePage "Moduly"
$tabSkills = New-ReferencePage "Skills"
$tab10 = New-ReferencePage "Chování"
$tab9 = New-ReferencePage "Slovník"

$txtProjectName = New-Object System.Windows.Forms.TextBox
$txtProjectName.Text = "EnterpriseProject"
$txtProjectName.Visible = $false
$form.Controls.Add($txtProjectName)

$rArch = Add-RadioGroup $tab1 "Struktura Repozitáře" @("Standardní (jedna aplikace)", "pnpm workspaces + apps/ (monorepo)", "Turborepo (pnpm workspaces)", "Modulární monolit (čisté hranice)") 0 0 440 200
$rFe = Add-RadioGroup $tab1 "Frontend Framework" $optFrameworks 460 0 440 200
$cLint = Add-CheckGroup $tab1 "Standardy Kódu" @("ESLint", "Prettier", "Biome", "Striktní TS (no implicit any)", "Knip", "Husky", "Commitlint") 920 0 440 200
$rAuthType = Add-RadioGroup $tab1 "Autentizace" @("NextAuth v5 / Auth.js", "Vlastní JWT + bearer tokeny", "Clerk (hosted)", "Supabase Auth") 0 220 440 200
$rDbStrategy = Add-RadioGroup $tab1 "Databáze" @("Neon (serverless Postgres, vlastní Auth)", "Supabase (kompletní backend: DB + Auth + Storage)", "Vlastní PostgreSQL (VPS)", "PlanetScale (MySQL)") 460 220 440 200
$rDeploy = Add-RadioGroup $tab1 "Nasazení" @("Vercel (BaaS + Edge)", "Netlify", "Docker Container (VPS/AWS)", "AWS ECS / Fargate (Enterprise)") 920 220 440 200
$rArchType = Add-RadioGroup $tab1 "Typ Architektury" @("Monolit (jedna aplikace)", "Modulární monolit (moduly s vlastními hranicemi)", "Mikroservisy (nezávislé služby)", "Serverless / Edge funkce", "Hybridní (modulární monolit + extrahované služby)") 0 440 440 230
$rTarget = Add-RadioGroup $tab1 "Cílové Platformy" $optTargets 460 440 440 230
$rDesign = Add-RadioGroup $tab1 "Design System a Vibe" @("Moderní & Minimalistický (Shadcn styl)", "Enterprise (Korporátní data)", "Dark Mode orientovaný", "Hravý / Barevný", "Material Design 3", "Glassmorphism / Neumorphism") 920 440 440 230
$tab1.AutoScrollMinSize = New-Object System.Drawing.Size(1400, 900)

$rRender = Add-RadioGroup $tab2 "Rendering Strategie" @("SSR (Server-Side Rendering)", "SPA (Single Page App)", "SSG (Static Site Generation)", "ISR (Incremental Static Regeneration)") 0 0 440 200
$rCss = Add-RadioGroup $tab2 "Styling" @("Tailwind CSS + Shadcn/UI", "Tailwind CSS (čistý)", "MUI", "CSS Modules + Vanilla Extract") 460 0 440 200
$rI18n = Add-RadioGroup $tab2 "Internacionalizace" @("Bez i18n (jednojazyčná aplikace)", "next-intl (Next.js App Router)", "Vlastní JSON slovník", "Vue I18n / SvelteKit i18n") 920 0 440 200
$rState = Add-RadioGroup $tab2 "State Management" @("Zustand / Pinia", "Redux Toolkit", "Context API", "Bez globálního stavu") 0 220 440 200
$rForms = Add-RadioGroup $tab2 "Formuláře a Validace" @("React Hook Form + Zod", "VeeValidate + Zod", "Server Actions (Nativní)", "Čistý state") 460 220 440 200
$rAnimation = Add-RadioGroup $tab2 "Animace" @("Žádná (minimalistické)", "Framer Motion", "GSAP", "CSS Animations (nativní)") 920 220 440 200
$cFeUi = Add-CheckGroup $tab2 "UI Knihovny" @("Lucide Icons", "Sonner (toast notifikace)", "next-themes (dark mode)", "Recharts (grafy)") 0 440 440 200

$rBe = Add-RadioGroup $tab3 "Backend Jádro" @("Next.js API Routes / Server Actions", "Oddělený Node.js (Express / NestJS)", "Hono", "BaaS (Supabase / Firebase)", "Python (FastAPI / Django)", "Go (Gin / Echo / Fiber)", "Rust (Axum / Actix)", "Edge Functions (Cloudflare Workers)") 0 0 440 200
$rVercelDb = Add-RadioGroup $tab3 "Integrace DB" @("Nativní integrace Neon (auto ENV inject)", "Supabase Marketplace (one-click)", "Manuální správa ENV", "Nepoužívám Vercel") 460 0 440 200
$rOrm = Add-RadioGroup $tab3 "ORM / Data Layer" @("Prisma", "Drizzle ORM", "Supabase Client", "Raw SQL + prepared statements") 920 0 440 200
$rFetch = Add-RadioGroup $tab3 "Data Fetching" @("TanStack Query", "SWR", "tRPC", "Nativní fetch()") 0 220 440 200
$rRealtime = Add-RadioGroup $tab3 "Real-time komunikace" @("Žádná (REST only)", "WebSockets (Socket.io / nativní)", "Server-Sent Events (SSE)", "Supabase Realtime / Firebase") 460 220 440 200
$rPooling = Add-RadioGroup $tab3 "Connection Pooling" @("Neon serverless driver (HTTP, žádný pool)", "Supabase Supavisor (transaction mode)", "Prisma Accelerate", "Vlastní konfigurace poolu") 920 220 440 200
$rCache = Add-RadioGroup $tab3 "Cache strategie" @("Žádná (fresh data)", "Vercel KV / Upstash Redis", "Next.js unstable_cache / Data Cache", "React Query cache (client-side)") 0 440 440 200
$rApiDesign = Add-RadioGroup $tab3 "API Design" @("REST + OpenAPI spec", "REST + Zod validace", "GraphQL (Cursor Connections)", "tRPC (end-to-end typesafe)") 460 440 440 200

$cTest = Add-CheckGroup $tab4 "Testování" @("Vitest", "Playwright (E2E)", "Jest", "Testing Library (React/Vue)", "MSW (Mock Service Worker)", "k6 / Artillery (load testing)") 0 0 440 200
$cCiCd = Add-CheckGroup $tab4 "CI/CD Pipeline" @("GitHub Actions", "Automatické testy na PR", "Preview deployment (Vercel)", "Databázové migrace v CI", "Build APK (Android)", "Build IPA (iOS)", "Semantic Release (auto-versioning)") 460 0 440 200
$cVercelFeatures = Add-CheckGroup $tab4 "Vercel konfigurace" @("Preview Deployment na PR", "Edge Functions", "Vercel Blob (soubory)", "Cron Jobs") 920 0 440 200
$rIac = Add-RadioGroup $tab4 "Infrastructure as Code" @("Žádné (manuální správa)", "Terraform", "Pulumi", "Vercel CLI + vercel.json") 0 220 440 200
$cObservability = Add-CheckGroup $tab4 "Observability" @("Vercel Analytics", "Vercel Speed Insights", "Google Analytics 4", "Sentry (chyby)", "PostHog (product analytics)", "OpenTelemetry (tracing)", "Grafana / Prometheus (metriky)") 460 220 440 200
$cLog = Add-CheckGroup $tab4 "Logování" @("Pino (JSON logy)", "Winston", "Axiom / Logtail (aggregation)", "Datadog", "Loki") 920 220 440 200

$cAuth = Add-CheckGroup $tab5 "Autentizace & Role" @("RBAC (Admin/User/Moderator)", "OAuth (Google, GitHub)", "Magic Links (bez hesla)", "2FA / TOTP", "Session management", "Refresh tokeny", "Device tracking") 0 0 440 230
$cSec = Add-CheckGroup $tab5 "Bezpečnostní moduly" @("T3 Env (Validace .env přes Zod)", "Rate Limiting", "Helmet hlavičky", "CORS konfigurace", "CSRF ochrana (SameSite)", "Content Security Policy (CSP)", "Password hashing (argon2/bcrypt)") 460 0 440 230
$cCompliance = Add-CheckGroup $tab5 "Compliance" @("GDPR (cookie consent, RLS)", "Audit trail (kdo co změnil)", "Data retention policy", "Backup & disaster recovery", "AI cost tracking", "SOC2 ready") 920 0 440 230

$rCms = Add-RadioGroup $tab6 "Správa obsahu" @("Vlastní DB + Administrace", "Lokální soubory (MDX / Markdown)", "Headless CMS (Sanity / Strapi / Payload)", "Hardcoded (neřešit)") 0 0 440 200
$rCmsEditor = Add-RadioGroup $tab6 "CMS Editor" @("TipTap (headless, vlastní UI)", "Lexical (Meta)", "Slate.js", "Žádný (pouze MDX)") 460 0 440 200
$rAdminShell = Add-RadioGroup $tab6 "Admin Shell" @("Vlastní admin-kit (custom)", "Refine.dev", "React Admin", "Payload CMS (admin v ceně)") 920 0 440 200
$rSeo = Add-RadioGroup $tab6 "SEO" @("Nativní (Next.js metadata / Nuxt useHead)", "Unhead (deduplikace + async aware)", "next-seo / vue-seo", "Ruční správa (vlastní komponenta)") 0 220 440 200
$cAdmin = Add-CheckGroup $tab6 "Administrace" @("Dashboard (Statistiky, grafy)", "Správa uživatelů (Tabulky)", "Audit Log (Historie změn)", "Import/Export dat (CSV/Excel)") 460 220 440 200
$cCore = Add-CheckGroup $tab6 "Byznys Funkce" @("Upload souborů (S3/Supabase/Blob)", "Platby (Stripe)", "E-maily (Resend / Postmark)", "PDF generování", "Notifikace (push/email/SMS)", "Full-text vyhledávání (Meilisearch)") 920 220 440 230
$cAi = Add-CheckGroup $tab6 "AI Integrace" @("Vercel AI SDK", "OpenAI API", "Anthropic Claude API", "RAG (Vektorová databáze)") 0 440 440 200
$rAbTesting = Add-RadioGroup $tab6 "A/B Testování" @("Žádné", "PostHog (feature flags + experiments)", "GrowthBook (self-hosted)", "Statsig") 460 440 440 200

$rMobile = Add-RadioGroup $tab7 "Mobilní platforma" $optMobilePlat 0 0 440 230
$cMobileFeatures = Add-CheckGroup $tab7 "Mobilní funkce" @("Offline drafty (AsyncStorage)", "SecureStore pro tokeny", "Push notifikace (Expo Notifications)", "Sdílené API s webem", "Biometrické přihlášení", "Dark/Light/System téma", "Deep linking", "Photo picker / Camera") 460 0 440 230
$rMobileDeploy = Add-RadioGroup $tab7 "Distribuce mobilu" @("Expo EAS Build (cloud)", "App Store / Google Play", "Interní distribuce (Firebase App Distribution)") 920 0 440 200
$rMobileNav = Add-RadioGroup $tab7 "Mobilní navigace" @("Expo Router (file-based)", "React Navigation", "Vlastní stack", "Tabs + Stack kombinace") 0 250 440 200
$rMobileUi = Add-RadioGroup $tab7 "Mobilní UI" @("React Native Paper", "NativeBase", "Tamagui", "Vlastní komponenty") 460 250 440 200
$rMobileState = Add-RadioGroup $tab7 "Mobilní state" @("Zustand + TanStack Query", "Redux Toolkit + RTK Query", "Jotai + SWR", "Context + vlastní fetch") 920 250 440 200
$rMobileAuth = Add-RadioGroup $tab7 "Mobilní autentizace" @("Bearer tokeny (vlastní JWT)", "Expo AuthSession (OAuth)", "Supabase Auth (shared)", "Biometrické + PIN") 0 470 440 200

$rAppDomain = Add-RadioGroup $tab8 "Primární doména" $optDomains 0 0 440 230
$cEcommerce = Add-CheckGroup $tab8 "E-shop moduly" @("Product catalog (varianty, SKU)", "Košík + checkout flow", "Platební brána (Stripe / GoPay)", "Doprava (Packeta / DPD / PPL)", "Skladové hospodářství", "Fakturace (Fakturoid / iDoklad)", "Slevové kódy a akce", "Recenze produktů", "Wishlist / oblíbené", "Porovnání produktů", "Doporučovací engine", "Abandoned cart recovery") 460 0 440 230
$cBooking = Add-CheckGroup $tab8 "Rezervační moduly" @("Kalendář s časovými sloty", "Správa zaměstnanců / specialistů", "Rezervace + platba (deposit)", "Přesuny a storna", "SMS / Email reminder", "Google Calendar sync", "Opakované rezervace", "Waitlist (fronta čekajících)", "Dárkové vouchery", "Věrnostní program") 920 0 440 230
$cSaas = Add-CheckGroup $tab8 "SaaS moduly" @("Multi-tenant architektura", "Subscription billing (Stripe Billing)", "Plány + feature gating", "Trial + upgrade/downgrade", "Usage-based billing", "Invoice generování", "Dunning management", "Team / organizace", "Invite systém", "RBAC per tenant", "White-label možnost") 0 250 440 230
$cLms = Add-CheckGroup $tab8 "LMS / Vzdělávání" @("Kurzy + lekce", "Video streaming (Mux / Cloudflare)", "Kvízy a testy", "Certifikáty (PDF generování)", "Progress tracking", "Diskusní fórum", "Live sessions (Zoom / Daily.co)", "Předplatné kurzu", "Drip content") 460 250 440 200
$cCrm = Add-CheckGroup $tab8 "CRM / Interní nástroje" @("Kontakty + firmy", "Pipeline / deals", "Úkoly a aktivity", "Reporty a dashboardy", "Import/Export dat", "Email sekvence", "Lead scoring", "Ticket systém") 920 250 440 200
$cIntegrations = Add-CheckGroup $tab8 "Integrace třetích stran" @("Platby: Stripe", "Platby: GoPay", "Platby: PayPal", "Doprava: Packeta / Zásilkovna", "Doprava: DPD / PPL", "Fakturace: Fakturoid", "Fakturace: iDoklad", "Email: Resend / Postmark", "SMS: Twilio / SMS.cz", "Účetnictví: Pohoda / Money S3", "Marketing: Mailchimp / Klaviyo", "Analytics: GA4 / Meta Pixel") 0 500 440 230
$cMarketing = Add-CheckGroup $tab8 "Marketing & Growth" @("Newsletter", "Blog s MDX", "Landing pages builder", "Referral systém", "Affiliate program", "Structured data (JSON-LD)", "Open Graph optimalizace", "Sitemap + robots.txt", "RSS feed", "Push notifikace (web)") 460 500 440 230
$cLegal = Add-CheckGroup $tab8 "Právní & Compliance" @("GDPR (souhlasy, výmaz)", "Obchodní podmínky", "Cookies consent (Cookiebot)", "Reklamační systém", "14 dní na vrácení (spotřebitel)", "Ochrana osobních údajů", "Autorská práva a licence", "VAT / DPH kalkulace") 920 500 440 200

# ---- Tab10: Chování Agenta (obecné, na stacku nezávislé instrukce pro Copilota) ----
$cBuildValidation = Add-CheckGroup $tab10 "Sestavení a validace" @("Nikdy neinstalujte nedeklarované závislosti", "Spusťte testovací sadu", "Spusťte linter a formátovač", "Kontrola typů", "Replikujte CI kontroly lokálně") 0 0 440 230
$cProjectLayout = Add-CheckGroup $tab10 "Rozložení projektu" @("Dodržujte stávající strukturu", "Společné umístění testů", "Vyhněte se novým závislostem", "Respektujte konfigurační soubory") 460 0 440 230
$cCodeStyle = Add-CheckGroup $tab10 "Styl kódu" @("Preferujte konst", "Předsazené výrazy (early returns)", "Popisné pojmenování", "Malé funkce", "Autodokumentační kód") 920 0 440 230
$cTestingBehavior = Add-CheckGroup $tab10 "Testování" @("Pokrytí pro nové kódy", "Jednotkové testy", "Okrajové případy", "Testovací názvy", "AAA vzor") 0 250 440 230
$cDocsBehavior = Add-CheckGroup $tab10 "Dokumentace" @("JSDoc/Docstringy", "Aktualizace README", "Složitá logika", "Dokumentace API") 460 250 440 200
$cSecurityBehavior = Add-CheckGroup $tab10 "Zabezpečení (obecné)" @("Ověřujte vstupy", "Žádná tvrdá tajemství", "Parametrizované dotazy", "Prevence XSS") 920 250 440 200
$cAccessibility = Add-CheckGroup $tab10 "Přístupnost" @("Sémantické HTML", "Alternativní text u obrázků", "Navigace klávesnicí", "Štítky ARIA", "Přístupné formuláře", "Přístupná média a alt texty", "Kontrast a vizuální přístupnost") 0 480 440 200
$cPerformance = Add-CheckGroup $tab10 "Výkon" @("Lint pravidla pro výkon", "Memoizace", "Vyhněte se N+1 dotazům", "Velikost svazku") 460 480 440 200
$tab10.AutoScrollMinSize = New-Object System.Drawing.Size(1400, 780)

# ---- Tab Skills: vyber skillu a format vystupu (konsolidovane soubory) ----
$rSkillOutput = Add-RadioGroup $tabSkills "Formát výstupu" @("Konsolidovaný (instrukce + agent + setup)", "Rozšířený (+ skills a agent-task)", "Jen instrukce") 0 0 440 200
$rSkillScope = Add-RadioGroup $tabSkills "Rozsah skills" @("Pouze zaškrtnuté skilly", "Všechny skilly (kompletní sada)", "Bez skills") 460 0 440 200
$cSkillContent = Add-CheckGroup $tabSkills "Obsah skills" @("Kontrolní seznam (checklist)", "Příklad použití", "Odkazy na související soubory") 920 0 440 200
$cSkillFrontMatter = Add-CheckGroup $tabSkills "Doplňky výstupu" @("Frontmatter s metadaty", "Souhrnná tabulka skills", "Úkolový prompt v instrukcích", "Úkolový prompt jako samostatný soubor") 0 220 440 200

$skillCatList = @()
foreach ($sk in $script:skillCatalog) { if ($skillCatList -notcontains $sk.C) { $skillCatList += $sk.C } }

$skillGroups = @{}
$skillX = 0; $skillY = 440; $skillCol = 0; $skillRowH = 0
foreach ($cat in $skillCatList) {
    $catTitles = @($script:skillCatalog | Where-Object { $_.C -eq $cat } | ForEach-Object { $_.T })
    $catH = 82 + (27 * $catTitles.Count) + 24
    $skillGroups[$cat] = Add-CheckGroup $tabSkills $cat $catTitles $skillX $skillY 440 $catH
    $skillRowH = [Math]::Max($skillRowH, $catH)
    $skillCol++
    $skillX += 460
    if ($skillCol -ge 3) { $skillCol = 0; $skillX = 0; $skillY += $skillRowH + 20; $skillRowH = 0 }
}
if ($skillCol -ne 0) { $skillY += $skillRowH + 20 }
$tabSkills.AutoScrollMinSize = New-Object System.Drawing.Size(1400, ($skillY + 220))


# ==========================================
# DOPORUČENÉ PRESETY
# Při volbě domény, mobilní platformy nebo frontend frameworku se doplní
# doporučené moduly. Presety pouze zaškrtávají - nikdy nic neodznačují,
# takže uživatel může cokoli z doporučení odebrat.
# ==========================================
$script:presets = @{}

$script:presets['E-shop / E-commerce'] = @(
    @{ C = $cEcommerce;    I = @('Product catalog (varianty, SKU)', 'Košík + checkout flow', 'Platební brána (Stripe / GoPay)', 'Doprava (Packeta / DPD / PPL)', 'Skladové hospodářství', 'Fakturace (Fakturoid / iDoklad)', 'Slevové kódy a akce', 'Recenze produktů', 'Wishlist / oblíbené', 'Porovnání produktů', 'Doporučovací engine', 'Abandoned cart recovery') }
    @{ C = $cCore;         I = @('Upload souborů (S3/Supabase/Blob)', 'Platby (Stripe)', 'E-maily (Resend / Postmark)', 'Notifikace (push/email/SMS)') }
    @{ C = $cIntegrations; I = @('Platby: Stripe', 'Platby: GoPay', 'Platby: PayPal', 'Doprava: Packeta / Zásilkovna', 'Doprava: DPD / PPL', 'Fakturace: Fakturoid', 'Fakturace: iDoklad', 'Email: Resend / Postmark', 'SMS: Twilio / SMS.cz', 'Účetnictví: Pohoda / Money S3', 'Marketing: Mailchimp / Klaviyo', 'Analytics: GA4 / Meta Pixel') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Obchodní podmínky', 'Cookies consent (Cookiebot)', 'Reklamační systém', '14 dní na vrácení (spotřebitel)', 'Ochrana osobních údajů', 'Autorská práva a licence', 'VAT / DPH kalkulace') }
    @{ C = $cAdmin;        I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)', 'Import/Export dat (CSV/Excel)') }
    @{ C = $cMarketing;    I = @('Newsletter', 'Sitemap + robots.txt', 'Referral systém', 'Affiliate program', 'Structured data (JSON-LD)', 'Open Graph optimalizace', 'RSS feed', 'Push notifikace (web)') }
    @{ C = $rOrm;          I = @('Prisma') }
    @{ C = $cAuth;         I = @('RBAC (Admin/User/Moderator)', 'OAuth (Google, GitHub)', '2FA / TOTP', 'Session management', 'Refresh tokeny', 'Device tracking') }
    @{ C = $cSec;          I = @('T3 Env (Validace .env přes Zod)', 'Rate Limiting', 'Helmet hlavičky', 'CORS konfigurace', 'CSRF ochrana (SameSite)', 'Password hashing (argon2/bcrypt)') }
    @{ C = $cCompliance;   I = @('GDPR (cookie consent, RLS)', 'Audit trail (kdo co změnil)', 'Backup & disaster recovery') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Automatické testy na PR', 'Preview deployment (Vercel)', 'Databázové migrace v CI', 'Semantic Release (auto-versioning)') }
    @{ C = $cTest;         I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cObservability;I = @('Sentry (chyby)') }
    @{ C = $cLog;          I = @('Pino (JSON logy)') }
    @{ C = $cBuildValidation;  I = @('Spusťte testovací sadu', 'Spusťte linter a formátovač', 'Kontrola typů') }
    @{ C = $cSecurityBehavior; I = @('Ověřujte vstupy', 'Žádná tvrdá tajemství', 'Parametrizované dotazy') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Navigace klávesnicí') }
)

$script:presets['Rezervační systém (salon, lékař, restaurace)'] = @(
    @{ C = $cBooking;      I = @('Kalendář s časovými sloty', 'Správa zaměstnanců / specialistů', 'Rezervace + platba (deposit)', 'Přesuny a storna', 'SMS / Email reminder', 'Google Calendar sync', 'Opakované rezervace', 'Waitlist (fronta čekajících)', 'Dárkové vouchery', 'Věrnostní program') }
    @{ C = $cCore;         I = @('E-maily (Resend / Postmark)', 'Notifikace (push/email/SMS)', 'Platby (Stripe)') }
    @{ C = $cIntegrations; I = @('Platby: Stripe', 'Platby: GoPay', 'SMS: Twilio / SMS.cz', 'Email: Resend / Postmark', 'Fakturace: Fakturoid') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Obchodní podmínky', 'Cookies consent (Cookiebot)') }
    @{ C = $cAdmin;        I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)') }
    @{ C = $cAuth;         I = @('RBAC (Admin/User/Moderator)', 'Magic Links (bez hesla)', 'Session management') }
    @{ C = $cSec;          I = @('T3 Env (Validace .env přes Zod)', 'Rate Limiting', 'CSRF ochrana (SameSite)') }
    @{ C = $cCompliance;   I = @('GDPR (cookie consent, RLS)', 'Backup & disaster recovery') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Automatické testy na PR', 'Preview deployment (Vercel)', 'Databázové migrace v CI', 'Semantic Release (auto-versioning)') }
    @{ C = $cTest;         I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cObservability;I = @('Sentry (chyby)') }
    @{ C = $cLog;          I = @('Pino (JSON logy)') }
    @{ C = $cBuildValidation;  I = @('Spusťte testovací sadu', 'Spusťte linter a formátovač', 'Kontrola typů') }
    @{ C = $cSecurityBehavior; I = @('Ověřujte vstupy', 'Žádná tvrdá tajemství', 'Parametrizované dotazy') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Přístupné formuláře', 'Navigace klávesnicí') }
)

$script:presets['SaaS platforma'] = @(
    @{ C = $cSaas;         I = @('Multi-tenant architektura', 'Subscription billing (Stripe Billing)', 'Plány + feature gating', 'Trial + upgrade/downgrade', 'Usage-based billing', 'Invoice generování', 'Dunning management', 'Team / organizace', 'Invite systém', 'RBAC per tenant', 'White-label možnost') }
    @{ C = $cCore;         I = @('E-maily (Resend / Postmark)', 'Platby (Stripe)', 'Notifikace (push/email/SMS)', 'PDF generování') }
    @{ C = $cIntegrations; I = @('Platby: Stripe', 'Fakturace: Fakturoid', 'Email: Resend / Postmark', 'Marketing: Mailchimp / Klaviyo') }
    @{ C = $cAdmin;        I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)', 'Audit Log (Historie změn)', 'Import/Export dat (CSV/Excel)') }
    @{ C = $cAuth;         I = @('RBAC (Admin/User/Moderator)', 'OAuth (Google, GitHub)', '2FA / TOTP', 'Session management', 'Refresh tokeny') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Obchodní podmínky', 'Cookies consent (Cookiebot)') }
    @{ C = $cSec;          I = @('T3 Env (Validace .env přes Zod)', 'Rate Limiting', 'CORS konfigurace', 'CSRF ochrana (SameSite)', 'Content Security Policy (CSP)') }
    @{ C = $cCompliance;   I = @('GDPR (cookie consent, RLS)', 'Audit trail (kdo co změnil)', 'Data retention policy', 'Backup & disaster recovery', 'SOC2 ready') }
    @{ C = $cObservability;I = @('Sentry (chyby)', 'OpenTelemetry (tracing)') }
    @{ C = $cLog;          I = @('Pino (JSON logy)') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Automatické testy na PR', 'Databázové migrace v CI', 'Semantic Release (auto-versioning)') }
    @{ C = $cTest;         I = @('Vitest', 'Playwright (E2E)', 'k6 / Artillery (load testing)') }
    @{ C = $cBuildValidation;  I = @('Spusťte testovací sadu', 'Spusťte linter a formátovač', 'Kontrola typů', 'Replikujte CI kontroly lokálně') }
    @{ C = $cSecurityBehavior; I = @('Ověřujte vstupy', 'Žádná tvrdá tajemství', 'Parametrizované dotazy') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Navigace klávesnicí', 'Štítky ARIA') }
    @{ C = $cDocsBehavior;     I = @('Dokumentace API', 'Aktualizace README') }
)

$script:presets['LMS (Learning Management System)'] = @(
    @{ C = $cLms;          I = @('Kurzy + lekce', 'Video streaming (Mux / Cloudflare)', 'Kvízy a testy', 'Certifikáty (PDF generování)', 'Progress tracking', 'Diskusní fórum', 'Live sessions (Zoom / Daily.co)', 'Předplatné kurzu', 'Drip content') }
    @{ C = $cCore;         I = @('Upload souborů (S3/Supabase/Blob)', 'Platby (Stripe)', 'E-maily (Resend / Postmark)', 'PDF generování', 'Notifikace (push/email/SMS)') }
    @{ C = $cIntegrations; I = @('Platby: Stripe', 'Email: Resend / Postmark', 'Marketing: Mailchimp / Klaviyo') }
    @{ C = $cCrm;          I = @('Email sekvence', 'Lead scoring') }
    @{ C = $cVercelFeatures; I = @('Vercel Blob (soubory)') }
    @{ C = $cAdmin;        I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)') }
    @{ C = $cAuth;         I = @('RBAC (Admin/User/Moderator)', 'OAuth (Google, GitHub)', 'Session management') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Obchodní podmínky', 'Cookies consent (Cookiebot)') }
    @{ C = $cSec;          I = @('T3 Env (Validace .env přes Zod)', 'Rate Limiting', 'CSRF ochrana (SameSite)') }
    @{ C = $cCompliance;   I = @('GDPR (cookie consent, RLS)', 'Backup & disaster recovery') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Automatické testy na PR', 'Preview deployment (Vercel)', 'Databázové migrace v CI', 'Semantic Release (auto-versioning)') }
    @{ C = $cTest;         I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cObservability;I = @('Sentry (chyby)') }
    @{ C = $cBuildValidation;  I = @('Spusťte testovací sadu', 'Spusťte linter a formátovač', 'Kontrola typů') }
    @{ C = $cSecurityBehavior; I = @('Ověřujte vstupy', 'Žádná tvrdá tajemství', 'Parametrizované dotazy') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Přístupná média a alt texty', 'Navigace klávesnicí') }
)

$script:presets['CRM / Interní nástroj'] = @(
    @{ C = $cCrm;          I = @('Kontakty + firmy', 'Pipeline / deals', 'Úkoly a aktivity', 'Reporty a dashboardy', 'Import/Export dat', 'Email sekvence', 'Lead scoring', 'Ticket systém') }
    @{ C = $cAdmin;        I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)', 'Audit Log (Historie změn)', 'Import/Export dat (CSV/Excel)') }
    @{ C = $cCore;         I = @('E-maily (Resend / Postmark)', 'PDF generování', 'Upload souborů (S3/Supabase/Blob)') }
    @{ C = $cIntegrations; I = @('Email: Resend / Postmark', 'Fakturace: Fakturoid') }
    @{ C = $cAuth;         I = @('RBAC (Admin/User/Moderator)', 'OAuth (Google, GitHub)', '2FA / TOTP', 'Session management', 'Device tracking') }
    @{ C = $cSec;          I = @('T3 Env (Validace .env přes Zod)', 'Rate Limiting', 'CSRF ochrana (SameSite)', 'Content Security Policy (CSP)') }
    @{ C = $cCompliance;   I = @('GDPR (cookie consent, RLS)', 'Audit trail (kdo co změnil)', 'Data retention policy', 'Backup & disaster recovery') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Ochrana osobních údajů') }
    @{ C = $cObservability;I = @('Sentry (chyby)') }
    @{ C = $cLog;          I = @('Pino (JSON logy)') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Automatické testy na PR') }
    @{ C = $cTest;         I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cBuildValidation;  I = @('Spusťte testovací sadu', 'Spusťte linter a formátovač', 'Kontrola typů') }
    @{ C = $cSecurityBehavior; I = @('Ověřujte vstupy', 'Žádná tvrdá tajemství', 'Parametrizované dotazy') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Navigace klávesnicí', 'Štítky ARIA') }
    @{ C = $cDocsBehavior;     I = @('Aktualizace README', 'Dokumentace API') }
)

$script:presets['Blog / Magazín / Média'] = @(
    @{ C = $cMarketing;    I = @('Newsletter', 'Blog s MDX', 'Landing pages builder', 'Structured data (JSON-LD)', 'Open Graph optimalizace', 'Sitemap + robots.txt', 'RSS feed', 'Affiliate program') }
    @{ C = $rCms;          I = @('Headless CMS (Sanity / Strapi / Payload)') }
    @{ C = $rSeo;          I = @('Nativní (Next.js metadata / Nuxt useHead)') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Cookies consent (Cookiebot)', 'Autorská práva a licence') }
    @{ C = $cCompliance;   I = @('GDPR (cookie consent, RLS)', 'Backup & disaster recovery') }
    @{ C = $cObservability;I = @('Vercel Analytics', 'Google Analytics 4', 'Vercel Speed Insights') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Preview deployment (Vercel)') }
    @{ C = $cTest;         I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cVercelFeatures; I = @('Preview Deployment na PR', 'Vercel Blob (soubory)') }
    @{ C = $cBuildValidation;  I = @('Spusťte linter a formátovač', 'Kontrola typů') }
    @{ C = $cSecurityBehavior; I = @('Prevence XSS', 'Žádná tvrdá tajemství') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Alternativní text u obrázků', 'Kontrast a vizuální přístupnost') }
    @{ C = $cPerformance;      I = @('Velikost svazku', 'Memoizace') }
    @{ C = $cDocsBehavior;     I = @('Aktualizace README') }
)

$script:presets['Portfolio / Prezentační web'] = @(
    @{ C = $cMarketing;    I = @('Sitemap + robots.txt', 'Structured data (JSON-LD)', 'Open Graph optimalizace', 'RSS feed') }
    @{ C = $rSeo;          I = @('Nativní (Next.js metadata / Nuxt useHead)') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Cookies consent (Cookiebot)', 'Obchodní podmínky', 'Autorská práva a licence') }
    @{ C = $cObservability;I = @('Vercel Analytics', 'Vercel Speed Insights') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Preview deployment (Vercel)') }
    @{ C = $cBuildValidation;  I = @('Spusťte linter a formátovač') }
    @{ C = $cSecurityBehavior; I = @('Žádná tvrdá tajemství', 'Prevence XSS') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Alternativní text u obrázků', 'Kontrast a vizuální přístupnost') }
    @{ C = $cPerformance;      I = @('Velikost svazku') }
)

$script:presets['Sociální síť / Komunita'] = @(
    @{ C = $cCore;         I = @('Upload souborů (S3/Supabase/Blob)', 'Notifikace (push/email/SMS)', 'E-maily (Resend / Postmark)', 'Full-text vyhledávání (Meilisearch)') }
    @{ C = $rRealtime;     I = @('WebSockets (Socket.io / nativní)', 'Supabase Realtime / Firebase') }
    @{ C = $cAdmin;        I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)', 'Audit Log (Historie změn)') }
    @{ C = $cAuth;         I = @('RBAC (Admin/User/Moderator)', 'OAuth (Google, GitHub)', '2FA / TOTP', 'Session management', 'Device tracking') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Obchodní podmínky', 'Cookies consent (Cookiebot)', 'Ochrana osobních údajů') }
    @{ C = $cSec;          I = @('T3 Env (Validace .env přes Zod)', 'Rate Limiting', 'CORS konfigurace', 'CSRF ochrana (SameSite)', 'Content Security Policy (CSP)') }
    @{ C = $cCompliance;   I = @('GDPR (cookie consent, RLS)', 'Audit trail (kdo co změnil)', 'Data retention policy', 'Backup & disaster recovery') }
    @{ C = $cAi;           I = @('OpenAI API') }
    @{ C = $cObservability;I = @('Sentry (chyby)') }
    @{ C = $cLog;          I = @('Pino (JSON logy)') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Automatické testy na PR', 'Preview deployment (Vercel)', 'Databázové migrace v CI', 'Semantic Release (auto-versioning)') }
    @{ C = $cTest;         I = @('Vitest', 'Playwright (E2E)', 'k6 / Artillery (load testing)') }
    @{ C = $cBuildValidation;  I = @('Spusťte testovací sadu', 'Spusťte linter a formátovač', 'Kontrola typů') }
    @{ C = $cSecurityBehavior; I = @('Ověřujte vstupy', 'Žádná tvrdá tajemství', 'Parametrizované dotazy', 'Prevence XSS') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Alternativní text u obrázků', 'Navigace klávesnicí', 'Štítky ARIA') }
)

$script:presets['Marketplace (více prodejců)'] = @(
    @{ C = $cEcommerce;    I = @('Product catalog (varianty, SKU)', 'Košík + checkout flow', 'Platební brána (Stripe / GoPay)', 'Doprava (Packeta / DPD / PPL)', 'Skladové hospodářství', 'Fakturace (Fakturoid / iDoklad)', 'Slevové kódy a akce', 'Recenze produktů', 'Wishlist / oblíbené', 'Porovnání produktů', 'Doporučovací engine', 'Abandoned cart recovery') }
    @{ C = $cSaas;         I = @('Multi-tenant architektura', 'Subscription billing (Stripe Billing)', 'Plány + feature gating', 'Trial + upgrade/downgrade', 'Usage-based billing', 'Invoice generování', 'Dunning management', 'Team / organizace', 'Invite systém', 'RBAC per tenant', 'White-label možnost') }
    @{ C = $cCore;         I = @('Upload souborů (S3/Supabase/Blob)', 'Platby (Stripe)', 'E-maily (Resend / Postmark)', 'PDF generování', 'Notifikace (push/email/SMS)', 'Full-text vyhledávání (Meilisearch)') }
    @{ C = $cIntegrations; I = @('Platby: Stripe', 'Doprava: Packeta / Zásilkovna', 'Fakturace: Fakturoid', 'Email: Resend / Postmark', 'Účetnictví: Pohoda / Money S3') }
    @{ C = $cAdmin;        I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)', 'Audit Log (Historie změn)', 'Import/Export dat (CSV/Excel)') }
    @{ C = $cAuth;         I = @('RBAC (Admin/User/Moderator)', 'OAuth (Google, GitHub)', '2FA / TOTP', 'Session management') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Obchodní podmínky', 'Cookies consent (Cookiebot)', 'Reklamační systém', '14 dní na vrácení (spotřebitel)', 'Ochrana osobních údajů', 'Autorská práva a licence', 'VAT / DPH kalkulace') }
    @{ C = $cSec;          I = @('T3 Env (Validace .env přes Zod)', 'Rate Limiting', 'CORS konfigurace', 'CSRF ochrana (SameSite)', 'Content Security Policy (CSP)') }
    @{ C = $cCompliance;   I = @('GDPR (cookie consent, RLS)', 'Audit trail (kdo co změnil)', 'Data retention policy', 'Backup & disaster recovery') }
    @{ C = $cObservability;I = @('Sentry (chyby)') }
    @{ C = $cLog;          I = @('Pino (JSON logy)') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Automatické testy na PR', 'Preview deployment (Vercel)', 'Databázové migrace v CI', 'Semantic Release (auto-versioning)') }
    @{ C = $cTest;         I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cBuildValidation;  I = @('Spusťte testovací sadu', 'Spusťte linter a formátovač', 'Kontrola typů') }
    @{ C = $cSecurityBehavior; I = @('Ověřujte vstupy', 'Žádná tvrdá tajemství', 'Parametrizované dotazy') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Navigace klávesnicí') }
)

$script:presets['Booking + platby (kombinace)'] = @(
    @{ C = $cBooking;      I = @('Kalendář s časovými sloty', 'Rezervace + platba (deposit)', 'Přesuny a storna', 'SMS / Email reminder', 'Google Calendar sync', 'Opakované rezervace', 'Waitlist (fronta čekajících)', 'Dárkové vouchery', 'Věrnostní program') }
    @{ C = $cCore;         I = @('Platby (Stripe)', 'E-maily (Resend / Postmark)', 'Notifikace (push/email/SMS)', 'PDF generování') }
    @{ C = $cIntegrations; I = @('Platby: Stripe', 'Platby: GoPay', 'SMS: Twilio / SMS.cz', 'Email: Resend / Postmark', 'Fakturace: Fakturoid') }
    @{ C = $cAdmin;        I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)', 'Import/Export dat (CSV/Excel)') }
    @{ C = $cAuth;         I = @('RBAC (Admin/User/Moderator)', 'Magic Links (bez hesla)', 'Session management') }
    @{ C = $cLegal;        I = @('GDPR (souhlasy, výmaz)', 'Obchodní podmínky', 'Cookies consent (Cookiebot)') }
    @{ C = $cSec;          I = @('T3 Env (Validace .env přes Zod)', 'Rate Limiting', 'CSRF ochrana (SameSite)') }
    @{ C = $cCompliance;   I = @('GDPR (cookie consent, RLS)', 'Backup & disaster recovery') }
    @{ C = $cCiCd;         I = @('GitHub Actions', 'Automatické testy na PR', 'Preview deployment (Vercel)', 'Databázové migrace v CI', 'Semantic Release (auto-versioning)') }
    @{ C = $cTest;         I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cObservability;I = @('Sentry (chyby)') }
    @{ C = $cBuildValidation;  I = @('Spusťte testovací sadu', 'Spusťte linter a formátovač', 'Kontrola typů') }
    @{ C = $cSecurityBehavior; I = @('Ověřujte vstupy', 'Žádná tvrdá tajemství', 'Parametrizované dotazy') }
    @{ C = $cAccessibility;    I = @('Sémantické HTML', 'Přístupné formuláře', 'Navigace klávesnicí') }
)

# Mobilní platforma -> doporučené mobilní funkce a knihovny
$script:presets['React Native + Expo (SDK 57+)'] = @(
    @{ C = $cMobileFeatures; I = @('Offline drafty (AsyncStorage)', 'SecureStore pro tokeny', 'Push notifikace (Expo Notifications)', 'Sdílené API s webem', 'Biometrické přihlášení') }
    @{ C = $rMobileNav;      I = @('Expo Router (file-based)') }
    @{ C = $rMobileUi;       I = @('React Native Paper') }
    @{ C = $rMobileState;    I = @('Zustand + TanStack Query') }
    @{ C = $rMobileAuth;     I = @('Expo AuthSession (OAuth)') }
    @{ C = $rMobileDeploy;   I = @('Expo EAS Build (cloud)') }
)
$script:presets['React Native (bare, bez Expo)'] = @(
    @{ C = $cMobileFeatures; I = @('SecureStore pro tokeny', 'Sdílené API s webem', 'Push notifikace (Expo Notifications)') }
    @{ C = $rMobileNav;      I = @('React Navigation') }
    @{ C = $rMobileState;    I = @('Zustand + TanStack Query') }
    @{ C = $rMobileAuth;     I = @('Bearer tokeny (vlastní JWT)') }
)
$script:presets['Flutter'] = @(
    @{ C = $cMobileFeatures; I = @('SecureStore pro tokeny', 'Sdílené API s webem', 'Push notifikace (Expo Notifications)', 'Dark/Light/System téma') }
    @{ C = $rMobileDeploy;   I = @('App Store / Google Play') }
)
$script:presets['Capacitor (web → nativní)'] = @(
    @{ C = $cMobileFeatures; I = @('SecureStore pro tokeny', 'Sdílené API s webem', 'Offline drafty (AsyncStorage)') }
    @{ C = $rMobileDeploy;   I = @('Interní distribuce (Firebase App Distribution)') }
)
$script:presets['PWA (Progressive Web App)'] = @(
    @{ C = $cMobileFeatures; I = @('Offline drafty (AsyncStorage)', 'Sdílené API s webem', 'Dark/Light/System téma', 'Deep linking', 'Photo picker / Camera') }
    @{ C = $cMarketing;      I = @('Push notifikace (web)') }
    @{ C = $cAccessibility;  I = @('Sémantické HTML', 'Navigace klávesnicí', 'Kontrast a vizuální přístupnost') }
)

# Frontend framework -> doporučené standardy a testovací nástroje
$script:presets['Next.js (App Router)'] = @(
    @{ C = $cLint;  I = @('ESLint', 'Prettier', 'Striktní TS (no implicit any)', 'Husky', 'Commitlint') }
    @{ C = $cFeUi;  I = @('Lucide Icons', 'Sonner (toast notifikace)', 'next-themes (dark mode)') }
    @{ C = $cTest;  I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)') }
    @{ C = $cCiCd;  I = @('GitHub Actions', 'Automatické testy na PR', 'Preview deployment (Vercel)') }
)
$script:presets['React + Vite'] = @(
    @{ C = $cLint;  I = @('ESLint', 'Prettier', 'Striktní TS (no implicit any)', 'Husky') }
    @{ C = $cFeUi;  I = @('Lucide Icons', 'Sonner (toast notifikace)', 'next-themes (dark mode)') }
    @{ C = $cTest;  I = @('Vitest', 'Testing Library (React/Vue)') }
    @{ C = $cCiCd;  I = @('GitHub Actions', 'Automatické testy na PR') }
)
$script:presets['Vue 3 + Vite'] = @(
    @{ C = $cLint;  I = @('ESLint', 'Prettier', 'Striktní TS (no implicit any)', 'Husky') }
    @{ C = $cFeUi;  I = @('Lucide Icons', 'Sonner (toast notifikace)') }
    @{ C = $cTest;  I = @('Vitest', 'Testing Library (React/Vue)') }
    @{ C = $cCiCd;  I = @('GitHub Actions', 'Automatické testy na PR') }
)
$script:presets['Nuxt 3/4'] = @(
    @{ C = $cLint;  I = @('ESLint', 'Prettier', 'Striktní TS (no implicit any)', 'Husky') }
    @{ C = $cFeUi;  I = @('Lucide Icons', 'Sonner (toast notifikace)') }
    @{ C = $cTest;  I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cCiCd;  I = @('GitHub Actions', 'Automatické testy na PR') }
)
$script:presets['SvelteKit'] = @(
    @{ C = $cLint;  I = @('ESLint', 'Prettier', 'Striktní TS (no implicit any)', 'Husky') }
    @{ C = $cTest;  I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cCiCd;  I = @('GitHub Actions', 'Automatické testy na PR') }
)
$script:presets['Astro (Islands Architecture)'] = @(
    @{ C = $cLint;  I = @('ESLint', 'Prettier', 'Striktní TS (no implicit any)') }
    @{ C = $cTest;  I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cCiCd;  I = @('GitHub Actions', 'Preview deployment (Vercel)') }
)
$script:presets['Angular 22'] = @(
    @{ C = $cLint;  I = @('ESLint', 'Prettier', 'Striktní TS (no implicit any)', 'Husky', 'Commitlint') }
    @{ C = $cTest;  I = @('Jest', 'Playwright (E2E)') }
    @{ C = $cCiCd;  I = @('GitHub Actions', 'Automatické testy na PR') }
)
$script:presets['React Router v8 (framework mode)'] = @(
    @{ C = $cLint;  I = @('ESLint', 'Prettier', 'Striktní TS (no implicit any)', 'Husky') }
    @{ C = $cTest;  I = @('Vitest', 'Playwright (E2E)', 'Testing Library (React/Vue)', 'MSW (Mock Service Worker)') }
    @{ C = $cCiCd;  I = @('GitHub Actions', 'Automatické testy na PR') }
)

# Cilove platformy -> doporucene moduly podle rozsahu aplikace
$script:presets['Web + Administrace'] = @(
    @{ C = $cAdmin; I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)', 'Audit Log (Historie změn)') }
    @{ C = $cAuth;  I = @('RBAC (Admin/User/Moderator)', 'OAuth (Google, GitHub)', '2FA / TOTP', 'Session management', 'Refresh tokeny', 'Device tracking') }
    @{ C = $cSec;   I = @('T3 Env (Validace .env přes Zod)', 'CSRF ochrana (SameSite)') }
    @{ C = $cCompliance; I = @('Audit trail (kdo co změnil)') }
)
$script:presets['Web + Administrace + Mobilní aplikace'] = @(
    @{ C = $cAdmin; I = @('Dashboard (Statistiky, grafy)', 'Správa uživatelů (Tabulky)', 'Audit Log (Historie změn)') }
    @{ C = $cMobileFeatures; I = @('SecureStore pro tokeny', 'Sdílené API s webem', 'Push notifikace (Expo Notifications)', 'Dark/Light/System téma') }
    @{ C = $rMobile; I = @('React Native + Expo (SDK 57+)') }
    @{ C = $rMobileNav; I = @('Expo Router (file-based)') }
    @{ C = $rMobileDeploy; I = @('Expo EAS Build (cloud)') }
    @{ C = $cAuth; I = @('RBAC (Admin/User/Moderator)', 'Refresh tokeny', 'Session management') }
)
$script:presets['Web + Mobilní aplikace (bez adminu)'] = @(
    @{ C = $cMobileFeatures; I = @('SecureStore pro tokeny', 'Sdílené API s webem', 'Push notifikace (Expo Notifications)', 'Dark/Light/System téma') }
    @{ C = $rMobile; I = @('React Native + Expo (SDK 57+)') }
    @{ C = $rMobileNav; I = @('Expo Router (file-based)') }
    @{ C = $rMobileDeploy; I = @('Expo EAS Build (cloud)') }
    @{ C = $cAuth; I = @('Refresh tokeny', 'Session management') }
)
$script:presets['Pouze web (desktop + mobil)'] = @(
    @{ C = $cFeUi; I = @('Lucide Icons', 'Sonner (toast notifikace)', 'next-themes (dark mode)') }
    @{ C = $cAccessibility; I = @('Sémantické HTML', 'Alternativní text u obrázků', 'Navigace klávesnicí') }
    @{ C = $cPerformance; I = @('Velikost svazku') }
)

# ==========================================
# TECHNOLOGICKÝ STACK PRESETU
# Aby se po volbě presetu předvyplnily i karty na záložce Architektura
# (a dalších), doplníme ke každému presetu doporučený technologický stack.
# Specifické volby jsou za obecným základem, takže mají přednost.
# ==========================================
$script:presetBaseStack = @(
    @{ C = $rArch;         I = @('Standardní (jedna aplikace)') }
    @{ C = $rArchType;     I = @('Modulární monolit (moduly s vlastními hranicemi)') }
    @{ C = $rRender;       I = @('SSR (Server-Side Rendering)') }
    @{ C = $rDesign;       I = @('Moderní & Minimalistický (Shadcn styl)') }
    @{ C = $rCss;          I = @('Tailwind CSS + Shadcn/UI') }
    @{ C = $rState;        I = @('Zustand / Pinia') }
    @{ C = $rForms;        I = @('React Hook Form + Zod') }
    @{ C = $rAnimation;    I = @('Framer Motion') }
    @{ C = $rI18n;         I = @('Bez i18n (jednojazyčná aplikace)') }
    @{ C = $rBe;           I = @('Next.js API Routes / Server Actions') }
    @{ C = $rDbStrategy;   I = @('Neon (serverless Postgres, vlastní Auth)') }
    @{ C = $rVercelDb;     I = @('Nativní integrace Neon (auto ENV inject)') }
    @{ C = $rOrm;          I = @('Prisma') }
    @{ C = $rFetch;        I = @('TanStack Query') }
    @{ C = $rRealtime;     I = @('Žádná (REST only)') }
    @{ C = $rPooling;      I = @('Neon serverless driver (HTTP, žádný pool)') }
    @{ C = $rCache;        I = @('Next.js unstable_cache / Data Cache') }
    @{ C = $rApiDesign;    I = @('REST + Zod validace') }
    @{ C = $rDeploy;       I = @('Vercel (BaaS + Edge)') }
    @{ C = $rIac;          I = @('Vercel CLI + vercel.json') }
    @{ C = $rAuthType;     I = @('NextAuth v5 / Auth.js') }
    @{ C = $rCms;          I = @('Vlastní DB + Administrace') }
    @{ C = $rCmsEditor;    I = @('TipTap (headless, vlastní UI)') }
    @{ C = $rAdminShell;   I = @('Vlastní admin-kit (custom)') }
    @{ C = $rSeo;          I = @('Nativní (Next.js metadata / Nuxt useHead)') }
    @{ C = $rAbTesting;    I = @('Žádné') }
    @{ C = $rMobileNav;    I = @('Expo Router (file-based)') }
    @{ C = $rMobileUi;     I = @('React Native Paper') }
    @{ C = $rMobileState;  I = @('Zustand + TanStack Query') }
    @{ C = $rMobileAuth;   I = @('Expo AuthSession (OAuth)') }
    @{ C = $rMobileDeploy; I = @('Expo EAS Build (cloud)') }
)

$script:presetTech = @{}

# --- Domény ---
$script:presetTech['E-shop / E-commerce'] = @(
    @{ C = $rRender;     I = @('ISR (Incremental Static Regeneration)') }
    @{ C = $rCache;      I = @('Vercel KV / Upstash Redis') }
    @{ C = $rApiDesign;  I = @('REST + OpenAPI spec') }
    @{ C = $rAdminShell; I = @('Refine.dev') }
    @{ C = $rAbTesting;  I = @('PostHog (feature flags + experiments)') }
)
$script:presetTech['Marketplace (více prodejců)'] = @(
    @{ C = $rRender;     I = @('ISR (Incremental Static Regeneration)') }
    @{ C = $rDbStrategy; I = @('Supabase (kompletní backend: DB + Auth + Storage)') }
    @{ C = $rVercelDb;   I = @('Supabase Marketplace (one-click)') }
    @{ C = $rOrm;        I = @('Drizzle ORM') }
    @{ C = $rPooling;    I = @('Supabase Supavisor (transaction mode)') }
    @{ C = $rAuthType;   I = @('Supabase Auth') }
    @{ C = $rCache;      I = @('Vercel KV / Upstash Redis') }
    @{ C = $rApiDesign;  I = @('REST + OpenAPI spec') }
    @{ C = $rAdminShell; I = @('Refine.dev') }
    @{ C = $rAbTesting;  I = @('PostHog (feature flags + experiments)') }
)
$script:presetTech['SaaS platforma'] = @(
    @{ C = $rDbStrategy; I = @('Supabase (kompletní backend: DB + Auth + Storage)') }
    @{ C = $rVercelDb;   I = @('Supabase Marketplace (one-click)') }
    @{ C = $rOrm;        I = @('Drizzle ORM') }
    @{ C = $rPooling;    I = @('Supabase Supavisor (transaction mode)') }
    @{ C = $rAuthType;   I = @('Supabase Auth') }
    @{ C = $rFetch;      I = @('tRPC') }
    @{ C = $rApiDesign;  I = @('tRPC (end-to-end typesafe)') }
    @{ C = $rCache;      I = @('Vercel KV / Upstash Redis') }
    @{ C = $rRealtime;   I = @('Supabase Realtime / Firebase') }
    @{ C = $rAdminShell; I = @('Refine.dev') }
    @{ C = $rAbTesting;  I = @('PostHog (feature flags + experiments)') }
)
$script:presetTech['Rezervační systém (salon, lékař, restaurace)'] = @(
    @{ C = $rApiDesign;  I = @('REST + Zod validace') }
    @{ C = $rAdminShell; I = @('Vlastní admin-kit (custom)') }
    @{ C = $rAbTesting;  I = @('Žádné') }
)
$script:presetTech['Booking + platby (kombinace)'] = @(
    @{ C = $rApiDesign;  I = @('REST + Zod validace') }
    @{ C = $rAdminShell; I = @('Vlastní admin-kit (custom)') }
    @{ C = $rAbTesting;  I = @('Žádné') }
)
$script:presetTech['LMS (Learning Management System)'] = @(
    @{ C = $rRender;     I = @('ISR (Incremental Static Regeneration)') }
    @{ C = $rDbStrategy; I = @('Supabase (kompletní backend: DB + Auth + Storage)') }
    @{ C = $rVercelDb;   I = @('Supabase Marketplace (one-click)') }
    @{ C = $rPooling;    I = @('Supabase Supavisor (transaction mode)') }
    @{ C = $rAuthType;   I = @('Supabase Auth') }
    @{ C = $rCms;        I = @('Headless CMS (Sanity / Strapi / Payload)') }
    @{ C = $rAdminShell; I = @('Payload CMS (admin v ceně)') }
    @{ C = $rAbTesting;  I = @('Žádné') }
)
$script:presetTech['CRM / Interní nástroj'] = @(
    @{ C = $rRender;     I = @('SPA (Single Page App)') }
    @{ C = $rDesign;     I = @('Enterprise (Korporátní data)') }
    @{ C = $rCss;        I = @('MUI') }
    @{ C = $rAdminShell; I = @('React Admin') }
    @{ C = $rAbTesting;  I = @('Žádné') }
)
$script:presetTech['Blog / Magazín / Média'] = @(
    @{ C = $rRender;     I = @('SSG (Static Site Generation)') }
    @{ C = $rArchType;   I = @('Monolit (jedna aplikace)') }
    @{ C = $rState;      I = @('Bez globálního stavu') }
    @{ C = $rAnimation;  I = @('CSS Animations (nativní)') }
    @{ C = $rCms;        I = @('Headless CMS (Sanity / Strapi / Payload)') }
    @{ C = $rCmsEditor;  I = @('Žádný (pouze MDX)') }
    @{ C = $rAbTesting;  I = @('Žádné') }
)
$script:presetTech['Portfolio / Prezentační web'] = @(
    @{ C = $rRender;     I = @('SSG (Static Site Generation)') }
    @{ C = $rArchType;   I = @('Monolit (jedna aplikace)') }
    @{ C = $rCms;        I = @('Lokální soubory (MDX / Markdown)') }
    @{ C = $rCmsEditor;  I = @('Žádný (pouze MDX)') }
    @{ C = $rState;      I = @('Bez globálního stavu') }
    @{ C = $rForms;      I = @('Čistý state') }
    @{ C = $rAnimation;  I = @('Framer Motion') }
    @{ C = $rAbTesting;  I = @('Žádné') }
)
$script:presetTech['Sociální síť / Komunita'] = @(
    @{ C = $rBe;         I = @('Oddělený Node.js (Express / NestJS)') }
    @{ C = $rDeploy;     I = @('Docker Container (VPS/AWS)') }
    @{ C = $rDbStrategy; I = @('Vlastní PostgreSQL (VPS)') }
    @{ C = $rVercelDb;   I = @('Nepoužívám Vercel') }
    @{ C = $rPooling;    I = @('Vlastní konfigurace poolu') }
    @{ C = $rRealtime;   I = @('WebSockets (Socket.io / nativní)') }
    @{ C = $rCache;      I = @('Vercel KV / Upstash Redis') }
    @{ C = $rApiDesign;  I = @('REST + OpenAPI spec') }
    @{ C = $rIac;        I = @('Terraform') }
    @{ C = $rAdminShell; I = @('Vlastní admin-kit (custom)') }
    @{ C = $rAbTesting;  I = @('Žádné') }
)

# --- Frontend frameworky ---
$script:presetTech['Next.js (App Router)'] = @(
    @{ C = $rCss;      I = @('Tailwind CSS + Shadcn/UI') }
    @{ C = $rI18n;     I = @('next-intl (Next.js App Router)') }
    @{ C = $rForms;    I = @('React Hook Form + Zod') }
    @{ C = $rState;    I = @('Zustand / Pinia') }
    @{ C = $rRender;   I = @('SSR (Server-Side Rendering)') }
    @{ C = $rSeo;      I = @('Nativní (Next.js metadata / Nuxt useHead)') }
    @{ C = $rBe;       I = @('Next.js API Routes / Server Actions') }
)
$script:presetTech['React + Vite'] = @(
    @{ C = $rCss;    I = @('Tailwind CSS + Shadcn/UI') }
    @{ C = $rForms;  I = @('React Hook Form + Zod') }
    @{ C = $rState;  I = @('Zustand / Pinia') }
    @{ C = $rRender; I = @('SPA (Single Page App)') }
    @{ C = $rSeo;    I = @('Ruční správa (vlastní komponenta)') }
)
$script:presetTech['Vue 3 + Vite'] = @(
    @{ C = $rCss;    I = @('Tailwind CSS + Shadcn/UI') }
    @{ C = $rForms;  I = @('VeeValidate + Zod') }
    @{ C = $rState;  I = @('Zustand / Pinia') }
    @{ C = $rI18n;   I = @('Vue I18n / SvelteKit i18n') }
    @{ C = $rRender; I = @('SPA (Single Page App)') }
)
$script:presetTech['Nuxt 3/4'] = @(
    @{ C = $rCss;    I = @('Tailwind CSS + Shadcn/UI') }
    @{ C = $rForms;  I = @('VeeValidate + Zod') }
    @{ C = $rState;  I = @('Zustand / Pinia') }
    @{ C = $rI18n;   I = @('Vue I18n / SvelteKit i18n') }
    @{ C = $rRender; I = @('SSR (Server-Side Rendering)') }
    @{ C = $rSeo;    I = @('Nativní (Next.js metadata / Nuxt useHead)') }
)
$script:presetTech['SvelteKit'] = @(
    @{ C = $rCss;    I = @('Tailwind CSS (čistý)') }
    @{ C = $rForms;  I = @('Čistý state') }
    @{ C = $rState;  I = @('Zustand / Pinia') }
    @{ C = $rI18n;   I = @('Vue I18n / SvelteKit i18n') }
    @{ C = $rRender; I = @('SSR (Server-Side Rendering)') }
)
$script:presetTech['Astro (Islands Architecture)'] = @(
    @{ C = $rCss;       I = @('Tailwind CSS (čistý)') }
    @{ C = $rRender;    I = @('SSG (Static Site Generation)') }
    @{ C = $rState;     I = @('Bez globálního stavu') }
    @{ C = $rForms;     I = @('Čistý state') }
    @{ C = $rAnimation; I = @('Žádná (minimalistické)') }
    @{ C = $rCms;       I = @('Lokální soubory (MDX / Markdown)') }
)
$script:presetTech['Angular 22'] = @(
    @{ C = $rCss;    I = @('CSS Modules + Vanilla Extract') }
    @{ C = $rForms;  I = @('Čistý state') }
    @{ C = $rState;  I = @('Bez globálního stavu') }
    @{ C = $rRender; I = @('SPA (Single Page App)') }
    @{ C = $rDesign; I = @('Enterprise (Korporátní data)') }
)
$script:presetTech['React Router v8 (framework mode)'] = @(
    @{ C = $rCss;    I = @('Tailwind CSS + Shadcn/UI') }
    @{ C = $rForms;  I = @('React Hook Form + Zod') }
    @{ C = $rState;  I = @('Zustand / Pinia') }
    @{ C = $rRender; I = @('SSR (Server-Side Rendering)') }
)

# --- Mobilní platformy ---
$script:presetTech['React Native + Expo (SDK 57+)'] = @(
    @{ C = $rMobileNav;    I = @('Expo Router (file-based)') }
    @{ C = $rMobileUi;     I = @('React Native Paper') }
    @{ C = $rMobileState;  I = @('Zustand + TanStack Query') }
    @{ C = $rMobileAuth;   I = @('Expo AuthSession (OAuth)') }
    @{ C = $rMobileDeploy; I = @('Expo EAS Build (cloud)') }
)
$script:presetTech['React Native (bare, bez Expo)'] = @(
    @{ C = $rMobileNav;    I = @('React Navigation') }
    @{ C = $rMobileUi;     I = @('React Native Paper') }
    @{ C = $rMobileState;  I = @('Zustand + TanStack Query') }
    @{ C = $rMobileAuth;   I = @('Bearer tokeny (vlastní JWT)') }
    @{ C = $rMobileDeploy; I = @('App Store / Google Play') }
)
$script:presetTech['Flutter'] = @(
    @{ C = $rMobileDeploy; I = @('App Store / Google Play') }
)
$script:presetTech['Capacitor (web → nativní)'] = @(
    @{ C = $rMobileDeploy; I = @('Interní distribuce (Firebase App Distribution)') }
)

# --- Cílové platformy ---
$script:presetTech['Web + Administrace + Mobilní aplikace'] = @(
    @{ C = $rMobile;       I = @('React Native + Expo (SDK 57+)') }
    @{ C = $rMobileNav;    I = @('Expo Router (file-based)') }
    @{ C = $rMobileDeploy; I = @('Expo EAS Build (cloud)') }
)
$script:presetTech['Web + Mobilní aplikace (bez adminu)'] = @(
    @{ C = $rMobile;       I = @('React Native + Expo (SDK 57+)') }
    @{ C = $rMobileNav;    I = @('Expo Router (file-based)') }
    @{ C = $rMobileDeploy; I = @('Expo EAS Build (cloud)') }
)

# Sloucit: obecny zaklad + specificke volby (maji prednost) + puvodni moduly
$mergedPresets = @{}
foreach ($lb in $script:presets.Keys) {
    $entries = @()
    $entries += $script:presetBaseStack
    if ($script:presetTech.ContainsKey($lb)) { $entries += $script:presetTech[$lb] }
    $entries += $script:presets[$lb]
    $mergedPresets[$lb] = $entries
}
$script:presets = $mergedPresets
$script:baseStackCount = $script:presetBaseStack.Count

# Skupiny voleb podle druhu presetu - aby volba frameworku nesmazala moduly domeny
Function Get-PresetKind([string]$label) {
    if (@($rAppDomain | Where-Object { $_.Text -eq $label }).Count -gt 0) { return 'domain' }
    if (@($rFe | Where-Object { $_.Text -eq $label }).Count -gt 0) { return 'framework' }
    if (@($rMobile | Where-Object { $_.Text -eq $label }).Count -gt 0) { return 'mobile' }
    if (@($rTarget | Where-Object { $_.Text -eq $label }).Count -gt 0) { return 'target' }
    return 'other'
}

$script:presetGroupsByKind = @{
    domain    = (New-Object System.Collections.ArrayList)
    framework = (New-Object System.Collections.ArrayList)
    mobile    = (New-Object System.Collections.ArrayList)
    target    = (New-Object System.Collections.ArrayList)
    other     = (New-Object System.Collections.ArrayList)
}
foreach ($lb in $script:presets.Keys) {
    $kind = Get-PresetKind $lb
    foreach ($e in $script:presets[$lb]) {
        $found = $false
        foreach ($g in $script:presetGroupsByKind[$kind]) { if ([object]::ReferenceEquals($g, $e.C)) { $found = $true; break } }
        if (-not $found) { [void]$script:presetGroupsByKind[$kind].Add($e.C) }
    }
}

Function Apply-Preset([string]$label) {
    if (-not $script:presets.ContainsKey($label)) { return 0 }
    # Volitelne nejdriv vycistit vsechny skupiny, kterych se tykaji presety
    $clearFirst = $false
    if ($script:cPresetOptions) {
        $clearFirst = (@($script:cPresetOptions | Where-Object { $_.Text -eq "Před aplikací vyčistit doporučené skupiny" -and $_.Checked }).Count -gt 0)
    }
    if ($clearFirst) {
        $kind = Get-PresetKind $label
        foreach ($g in $script:presetGroupsByKind[$kind]) { foreach ($c in $g) { $c.Checked = $false } }
    }
    $added = 0
    foreach ($entry in $script:presets[$label]) {
        $group = @($entry.C)
        if ($group.Count -eq 0) { continue }
        # U jednovyberovych karet nejdriv vycistit skupinu, aby nezustaly dva vybery
        if ($group[0].Tag -eq 'single') { foreach ($c in $group) { $c.Checked = $false } }
        foreach ($ctrl in $group) {
            if (($entry.I -contains $ctrl.Text) -and (-not $ctrl.Checked)) {
                $ctrl.Checked = $true
                $added++
            }
        }
    }
    return $added
}

Function Show-PresetHint([string]$message) {
    if ($lblPresetHint) { $lblPresetHint.Text = $message }
}

# ==========================================
# ZÁLOŽKA PRESETY - první volba při spuštění
# Vyberete šablonu a doporučené moduly se předvyplní.
# ==========================================
$presetHeader = New-Object System.Windows.Forms.Label
$presetHeader.Text = "Presety" + [char]10 + [char]10 + "Vyberte šablonu projektu a doporučené moduly se předvyplní ve všech záložkách. Cokoli pak můžete ručně odznačit nebo doplnit."
$presetHeader.Location = New-Object System.Drawing.Point(34, 24)
$presetHeader.Size = New-Object System.Drawing.Size(1300, 70)
$presetHeader.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$presetHeader.ForeColor = $script:colors.TextSecondary
$tabPreset.Controls.Add($presetHeader)

$presetTitle = New-Object System.Windows.Forms.Label
$presetTitle.Text = "Presety"
$presetTitle.Location = New-Object System.Drawing.Point(34, 22)
$presetTitle.Size = New-Object System.Drawing.Size(400, 26)
$presetTitle.Font = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
$presetTitle.ForeColor = $script:colors.TextPrimary
$tabPreset.Controls.Add($presetTitle)

$presetHeader.Top = 52

$rPresetDomain    = Add-RadioGroup $tabPreset "Preset: Doména projektu" $optDomains 0 0 440 400
$rPresetFramework = Add-RadioGroup $tabPreset "Preset: Frontend framework" $optFrameworks 460 0 440 320
$rPresetMobile    = Add-RadioGroup $tabPreset "Preset: Mobilní platforma" $optMobilePlat 920 0 440 270
$rPresetTargets   = Add-RadioGroup $tabPreset "Preset: Cílové platformy" $optTargets 0 440 440 240
$cPresetOptions   = Add-CheckGroup $tabPreset "Chování presetů" @("Před aplikací vyčistit doporučené skupiny") 460 440 440 200
$script:cPresetOptions = $cPresetOptions

# Nastavi jednovyberove skupine vybranou hodnotu (prazdny text = zadna volba)
Function Set-ChoiceByText($group, [string]$text) {
    foreach ($c in $group) { $c.Checked = ($c.Text -eq $text) }
}

Function Invoke-PresetChoice($mirrorGroup, $sourceGroup, [string]$text) {
    $n = Apply-Preset $text
    # Aplikace mohla pri cisteni odznacit i prave volenou hodnotu - nastavime ji znovu
    Set-ChoiceByText $sourceGroup $text
    Set-ChoiceByText $mirrorGroup $text
    if ($n -gt 0) {
        Update-Navigation
        Show-PresetHint "Preset '$text' aplikován: doplněno $n doporučených voleb. Můžete je odznačit."
    } else {
        Show-PresetHint "Preset '$text' nemá doporučené volby - vyplňte volby ručně."
    }
}

foreach ($opt in $rPresetDomain)    { $opt.Add_Click({ if ($this.Checked) { Invoke-PresetChoice $rPresetDomain    $rAppDomain $this.Text } else { Show-PresetHint "" } }) }
foreach ($opt in $rPresetFramework) { $opt.Add_Click({ if ($this.Checked) { Invoke-PresetChoice $rPresetFramework $rFe         $this.Text } else { Show-PresetHint "" } }) }
foreach ($opt in $rPresetMobile)    { $opt.Add_Click({ if ($this.Checked) { Invoke-PresetChoice $rPresetMobile    $rMobile    $this.Text } else { Show-PresetHint "" } }) }
foreach ($opt in $rPresetTargets)   { $opt.Add_Click({ if ($this.Checked) { Invoke-PresetChoice $rPresetTargets   $rTarget    $this.Text } else { Show-PresetHint "" } }) }

# ==========================================
# ULOŽENÍ A NAČTENÍ KONFIGURACE
# Stav všech karet se ukládá do JSON, aby se dal znovu načíst nebo sdílet.
# ==========================================
Function Get-CardTitle($card) {
    $lbl = @($card.Controls | Where-Object { $_ -is [System.Windows.Forms.Label] -and $_.Left -gt 70 -and $_.Top -eq 18 }) | Select-Object -First 1
    if ($lbl) { return $lbl.Text }
    return ""
}

Function Get-ConfigObject {
    $cards = [ordered]@{}
    foreach ($page in $tabControl.TabPages) {
        foreach ($card in @($page.Controls | Where-Object { $_ -is [System.Windows.Forms.Panel] })) {
            $title = Get-CardTitle $card
            if ([string]::IsNullOrWhiteSpace($title)) { continue }
            $checked = @($card.Controls | Where-Object { $_ -is [System.Windows.Forms.CheckBox] -and $_.Checked } | ForEach-Object { $_.Text })
            $cards["$($page.Text)|$title"] = $checked
        }
    }
    return [ordered]@{ version = 1; project = $txtProjectName.Text; cards = $cards }
}

Function Apply-ConfigObject($cfg) {
    if ($null -eq $cfg) { return 0 }
    if ($cfg.PSObject.Properties.Name -contains 'project' -and $cfg.project) { $txtProjectName.Text = $cfg.project }
    $cardsProp = $cfg.PSObject.Properties['cards']
    if ($null -eq $cardsProp) { return 0 }
    $map = @{}
    foreach ($p in $cardsProp.Value.PSObject.Properties) { $map[$p.Name] = @($p.Value) }
    $applied = 0
    foreach ($page in $tabControl.TabPages) {
        foreach ($card in @($page.Controls | Where-Object { $_ -is [System.Windows.Forms.Panel] })) {
            $title = Get-CardTitle $card
            if ([string]::IsNullOrWhiteSpace($title)) { continue }
            $key = "$($page.Text)|$title"
            if (-not $map.ContainsKey($key)) { continue }
            $wanted = @($map[$key])
            foreach ($c in @($card.Controls | Where-Object { $_ -is [System.Windows.Forms.CheckBox] })) {
                $c.Checked = ($wanted -contains $c.Text)
                if ($c.Checked) { $applied++ }
            }
        }
    }
    return $applied
}

Function Set-CurrentTabCleared {
    $page = $tabControl.SelectedTab
    if ($null -eq $page) { return 0 }
    $n = 0
    foreach ($card in @($page.Controls | Where-Object { $_ -is [System.Windows.Forms.Panel] })) {
        foreach ($c in @($card.Controls | Where-Object { $_ -is [System.Windows.Forms.CheckBox] -and $_.Checked })) {
            $c.Checked = $false
            $n++
        }
    }
    return $n
}

$btnSaveConfig.Add_Click({
    $dlg = New-Object System.Windows.Forms.SaveFileDialog
    $dlg.Filter = "Konfigurace (*.json)|*.json"
    $dlg.FileName = "copilot-builder-config.json"
    if ($dlg.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) { return }
    try {
        $json = (Get-ConfigObject) | ConvertTo-Json -Depth 8
        [System.IO.File]::WriteAllText($dlg.FileName, $json, (New-Object System.Text.UTF8Encoding $false))
        $cnt = ([regex]::Matches($json, '\[\]')).Count
        Show-PresetHint "Konfigurace uložena: $($dlg.FileName)"
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Uložení selhalo: $($_.Exception.Message)", "Chyba", 0, 16)
    }
})

$btnLoadConfig.Add_Click({
    $dlg = New-Object System.Windows.Forms.OpenFileDialog
    $dlg.Filter = "Konfigurace (*.json)|*.json"
    if ($dlg.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) { return }
    try {
        $cfg = (Get-Content $dlg.FileName -Raw -Encoding UTF8) | ConvertFrom-Json
        $n = Apply-ConfigObject $cfg
        Update-Navigation
        Show-PresetHint "Konfigurace načtena z '$([System.IO.Path]::GetFileName($dlg.FileName))': obnoveno $n voleb."
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Načtení selhalo: $($_.Exception.Message)", "Chyba", 0, 16)
    }
})

$btnClearTab.Add_Click({
    $n = Set-CurrentTabCleared
    Update-Navigation
    Show-PresetHint "Záložka '$($tabControl.SelectedTab.Text)' vyčištěna: odznačeno $n voleb."
})

# Volba domény -> doplni doporucene moduly
foreach ($opt in $rAppDomain) {
    $opt.Add_Click({
        if (-not $this.Checked) { Show-PresetHint ""; return }
        $added = Apply-Preset $this.Text
        Update-Navigation
        # Aplikace mohla pri cisteni odznacit i kliknutou volbu - nastavime ji znovu
        Set-ChoiceByText $rAppDomain $this.Text
        Set-ChoiceByText $rPresetDomain $this.Text
        if ($added -gt 0) {
            Show-PresetHint "Doporučení doplněno: $added voleb pro '$($this.Text)'. Můžete je kdykoli odznačit."
        } else {
            Show-PresetHint "Doména '$($this.Text)' nemá doporučený preset."
        }
    })
}

# Volba mobilni platformy -> doplnit mobilni funkce
foreach ($opt in $rMobile) {
    $opt.Add_Click({
        if (-not $this.Checked) { Show-PresetHint ""; return }
        $added = Apply-Preset $this.Text
        Set-ChoiceByText $rMobile $this.Text
        Set-ChoiceByText $rPresetMobile $this.Text
        if ($added -gt 0) { Show-PresetHint "Doporučení doplněno: $added mobilních voleb pro '$($this.Text)'." }
    })
}

# Volba frontend frameworku -> doplnit standardy kodu a testovani
foreach ($opt in $rFe) {
    $opt.Add_Click({
        if (-not $this.Checked) { Show-PresetHint ""; return }
        $added = Apply-Preset $this.Text
        Set-ChoiceByText $rFe $this.Text
        Set-ChoiceByText $rPresetFramework $this.Text
        if ($added -gt 0) { Show-PresetHint "Doporučení doplněno: $added voleb pro '$($this.Text)'." }
    })
}

# Volba cilovych platform -> doplnit moduly podle rozsahu aplikace
foreach ($opt in $rTarget) {
    $opt.Add_Click({
        if (-not $this.Checked) { Show-PresetHint ""; return }
        $added = Apply-Preset $this.Text
        Set-ChoiceByText $rTarget $this.Text
        Set-ChoiceByText $rPresetTargets $this.Text
        if ($added -gt 0) { Show-PresetHint "Doporučení doplněno: $added voleb pro '$($this.Text)'." }
    })
}

$dictHeader = New-Object System.Windows.Forms.Label
$dictHeader.Text = "Slovník nápovědy"
$dictHeader.Location = New-Object System.Drawing.Point(34, 24)
$dictHeader.Size = New-Object System.Drawing.Size(420, 28)
$dictHeader.Font = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
$dictHeader.ForeColor = $script:colors.TextPrimary
$tab9.Controls.Add($dictHeader)

$dictHint = New-Object System.Windows.Forms.Label
$dictHint.Text = "Vyhledej volbu vlevo a zobrazí se plné vysvětlení. Stejný text se zobrazuje i v tooltipu u voleb (přidrž kurzor nad volbou)."
$dictHint.Location = New-Object System.Drawing.Point(34, 54)
$dictHint.Size = New-Object System.Drawing.Size(1240, 22)
$dictHint.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$dictHint.ForeColor = $script:colors.TextSecondary
$tab9.Controls.Add($dictHint)

$dictSearch = New-Object System.Windows.Forms.TextBox
$dictSearch.Location = New-Object System.Drawing.Point(34, 84)
$dictSearch.Size = New-Object System.Drawing.Size(420, 26)
$dictSearch.BackColor = $script:colors.Surface
$dictSearch.ForeColor = $script:colors.TextPrimary
$dictSearch.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$dictSearch.Font = New-Object System.Drawing.Font("Segoe UI", 10.5)
$tab9.Controls.Add($dictSearch)

$dictCount = New-Object System.Windows.Forms.Label
$dictCount.Location = New-Object System.Drawing.Point(34, 114)
$dictCount.Size = New-Object System.Drawing.Size(420, 20)
$dictCount.Font = New-Object System.Drawing.Font("Segoe UI", 8.5)
$dictCount.ForeColor = $script:colors.TextMuted
$tab9.Controls.Add($dictCount)

$dictList = New-Object System.Windows.Forms.ListBox
$dictList.Location = New-Object System.Drawing.Point(34, 136)
$dictList.Size = New-Object System.Drawing.Size(420, 520)
$dictList.BackColor = $script:colors.Surface
$dictList.ForeColor = $script:colors.TextPrimary
$dictList.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$dictList.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$dictList.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left
$dictList.IntegralHeight = $false
$tab9.Controls.Add($dictList)

$dictDetail = New-Object System.Windows.Forms.TextBox
$dictDetail.Location = New-Object System.Drawing.Point(474, 84)
$dictDetail.Size = New-Object System.Drawing.Size(886, 572)
$dictDetail.Multiline = $true
$dictDetail.ReadOnly = $true
$dictDetail.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
$dictDetail.WordWrap = $true
$dictDetail.BackColor = $script:colors.Surface
$dictDetail.ForeColor = $script:colors.TextPrimary
$dictDetail.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$dictDetail.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$dictDetail.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
$tab9.Controls.Add($dictDetail)

Function Update-DictionaryList {
    $q = $dictSearch.Text.Trim()
    $dictList.BeginUpdate()
    $dictList.Items.Clear()
    foreach ($key in ($script:helpText.Keys | Sort-Object)) {
        if ([string]::IsNullOrWhiteSpace($q) -or $key -like "*$q*") { [void]$dictList.Items.Add($key) }
    }
    $dictList.EndUpdate()
    $dictCount.Text = "Nalezeno: $($dictList.Items.Count) z $($script:helpText.Keys.Count) voleb"
    if ($dictList.Items.Count -gt 0) { $dictList.SelectedIndex = 0 } else { $dictDetail.Text = "" }
}

$dictSearch.Add_TextChanged({ Update-DictionaryList })
$dictList.Add_SelectedIndexChanged({
    if ($dictList.SelectedItem) {
        $key = $dictList.SelectedItem.ToString()
        $dictDetail.Text = $key + "`r`n" + ("-" * [Math]::Min(60, [Math]::Max(10, $key.Length))) + "`r`n`r`n" + $script:helpText[$key]
        $dictDetail.SelectionStart = 0
        $dictDetail.ScrollToCaret()
    }
})
Update-DictionaryList
$tabControl.Add_SelectedIndexChanged({
    $tabControl.SelectedTab.AutoScrollPosition = New-Object System.Drawing.Point(0, 0)
    Update-Navigation
})
$tab1.AutoScrollPosition = New-Object System.Drawing.Point(0, 0)
$tabControl.SelectedIndex = 0
Update-Navigation

# ---- Preuspořádání karet podle skutečné potřeby místa (zabrání ořezu obsahu) ----
foreach ($page in $tabControl.TabPages) {
    $contentHeight = Repair-PageLayout $page
    if ($contentHeight -gt 0) {
        $page.AutoScrollMinSize = New-Object System.Drawing.Size(1400, [Math]::Max(420, $contentHeight))
    }
}

# ==========================================
# LOGIKA GENEROVÁNÍ
# ==========================================
$btnOk.Add_Click({
    $projName = $txtProjectName.Text
    if ([string]::IsNullOrWhiteSpace($projName)) { $projName = "EnterpriseProject" }

    Function Get-Radio($group) {
        $sel = @($group | Where-Object { $_.Checked }) | Select-Object -First 1
        if ($sel) { return $sel.Text }
        return "Nespecifikováno"
    }
    Function Get-List($controls) {
        $arr = @()
        foreach ($c in $controls) { if ($c.Checked) { $arr += "- $($c.Text)" } }
        if ($arr.Count -eq 0) { return "*(Není vyžadováno)*" }
        return $arr -join "`n"
    }
    Function Test-Checked($controls, $label) {
        return (@($controls | Where-Object { $_.Text -eq $label -and $_.Checked }).Count -gt 0)
    }

    $vals = @{
        Arch = Get-Radio $rArch; Render = Get-Radio $rRender; Design = Get-Radio $rDesign
        ArchType = Get-Radio $rArchType; Target = Get-Radio $rTarget
        Fe = Get-Radio $rFe; Css = Get-Radio $rCss; I18n = Get-Radio $rI18n
        State = Get-Radio $rState; Forms = Get-Radio $rForms; Animation = Get-Radio $rAnimation
        Be = Get-Radio $rBe; DbStrategy = Get-Radio $rDbStrategy; VercelDb = Get-Radio $rVercelDb
        Orm = Get-Radio $rOrm; Fetch = Get-Radio $rFetch; Realtime = Get-Radio $rRealtime
        Pooling = Get-Radio $rPooling; Cache = Get-Radio $rCache; ApiDesign = Get-Radio $rApiDesign
        Deploy = Get-Radio $rDeploy; Iac = Get-Radio $rIac
        AuthType = Get-Radio $rAuthType
        Cms = Get-Radio $rCms; CmsEditor = Get-Radio $rCmsEditor; AdminShell = Get-Radio $rAdminShell
        Seo = Get-Radio $rSeo; AbTesting = Get-Radio $rAbTesting
        Mobile = Get-Radio $rMobile; MobileDeploy = Get-Radio $rMobileDeploy
        MobileNav = Get-Radio $rMobileNav; MobileUi = Get-Radio $rMobileUi
        MobileState = Get-Radio $rMobileState; MobileAuth = Get-Radio $rMobileAuth
        AppDomain = Get-Radio $rAppDomain
        SkillOutput = Get-Radio $rSkillOutput; SkillScope = Get-Radio $rSkillScope
    }
    
    $lists = @{
        Lint = Get-List $cLint; Test = Get-List $cTest
        Auth = Get-List $cAuth; Sec = Get-List $cSec; Log = Get-List $cLog
        Observability = Get-List $cObservability; Compliance = Get-List $cCompliance
        Core = Get-List $cCore; Admin = Get-List $cAdmin; Ai = Get-List $cAi
        CiCd = Get-List $cCiCd; VercelFeatures = Get-List $cVercelFeatures
        FeUi = Get-List $cFeUi
        MobileFeatures = Get-List $cMobileFeatures
        Ecommerce = Get-List $cEcommerce
        Booking = Get-List $cBooking
        Saas = Get-List $cSaas
        Lms = Get-List $cLms
        Crm = Get-List $cCrm
        Integrations = Get-List $cIntegrations
        Marketing = Get-List $cMarketing
        Legal = Get-List $cLegal
        BuildValidation = Get-List $cBuildValidation
        ProjectLayout = Get-List $cProjectLayout
        CodeStyleBehavior = Get-List $cCodeStyle
        TestingBehavior = Get-List $cTestingBehavior
        DocsBehavior = Get-List $cDocsBehavior
        SecurityBehavior = Get-List $cSecurityBehavior
        Accessibility = Get-List $cAccessibility
        Performance = Get-List $cPerformance
    }

    # --- Kontrola konzistence voleb (neplatne kombinace) ---
    $warnings = @()
    $dbIsNeon = ($vals.DbStrategy -match "Neon")
    $dbIsSupabase = ($vals.DbStrategy -match "Supabase")
    if ($vals.DbStrategy -match "Neon.*Supabase|Supabase.*Neon") { $warnings += "Databáze obsahuje Neon i Supabase zároveň - vyberte jednu strategii." }
    if ($vals.Orm -match "Supabase Client" -and $dbIsNeon) { $warnings += "ORM 'Supabase Client' neodpovídá zvolené databázi Neon." }
    if ($vals.Orm -match "Mongoose" -and -not ($vals.DbStrategy -match "MongoDB")) { $warnings += "ORM 'Mongoose' je určen pro MongoDB, ale databáze je $($vals.DbStrategy)." }
    if ($vals.Pooling -match "Supabase Supavisor" -and $dbIsNeon) { $warnings += "Connection pooling 'Supabase Supavisor' neodpovídá databázi Neon." }
    if ($vals.Pooling -match "Neon serverless driver" -and $dbIsSupabase) { $warnings += "Connection pooling 'Neon serverless driver' neodpovídá databázi Supabase." }
    if ($vals.AuthType -match "Supabase Auth" -and $dbIsNeon) { $warnings += "Autentizace 'Supabase Auth' vyžaduje databázi Supabase." }
    if ($vals.VercelDb -match "Neon" -and $vals.Deploy -notmatch "Vercel") { $warnings += "Integrace 'Nativní Neon' funguje jen s nasazením na Vercel." }
    if ($vals.VercelDb -match "Supabase Marketplace" -and $vals.Deploy -notmatch "Vercel") { $warnings += "Integrace 'Supabase Marketplace' funguje jen s nasazením na Vercel." }
    if ($vals.Arch -match "Standardní" -and $vals.ArchType -match "Mikroservisy") { $warnings += "Mikroservisy obvykle potřebují monorepo, ne standardní jednu aplikaci." }
    if ($vals.ArchType -match "Mikroservisy|Serverless" -and $vals.Deploy -match "Docker Container") { $warnings += "Mikroservisy nebo serverless se hůř provozují v jednom Docker kontejneru." }
    $mb = $vals.Mobile
    $mbNone = ($mb -match "Žádná|Nespecifikováno")
    if ($mbNone -and $lists.MobileFeatures -notmatch "Není vyžadováno") { $warnings += "Máte vybrané mobilní funkce, ale mobilní platforma je 'Žádná'." }
    if ($mbNone -and $lists.CiCd -match "Build APK|Build IPA") { $warnings += "CI/CD obsahuje build APK nebo IPA, ale mobilní platforma je 'Žádná'." }
    if ($mb -match "React Native|Flutter|Capacitor" -and $vals.Target -match "Pouze web") { $warnings += "Mobilní platforma je vybraná, ale cílové platformy říkají 'Pouze web'." }
    if ($vals.Target -match "Mobilní aplikace" -and $mbNone) { $warnings += "Cílové platformy obsahují mobilní aplikaci, ale platforma je 'Žádná'." }
    if ($vals.Render -match "SSG" -and $vals.Realtime -match "WebSockets|SSE|Realtime") { $warnings += "Statické generování (SSG) se neslučuje s real-time komunikací." }
    if ($vals.Iac -match "Terraform" -and $vals.Deploy -match "Vercel") { $warnings += "Terraform pro Vercel je obvykle zbytečný - postačí vercel.json." }
    if ($vals.Css -match "MUI" -and $vals.Design -match "Moderní & Minimalistický") { $warnings += "Styling MUI (Material) koliduje s designovým vibe 'Moderní & Minimalistický'." }
    if ($vals.Cms -match "Hardcoded" -and $vals.CmsEditor -match "TipTap|Lexical|Slate") { $warnings += "CMS je 'Hardcoded', ale je zvolený WYSIWYG editor." }
    if ($warnings.Count -gt 0) {
        $answer = [System.Windows.Forms.MessageBox]::Show(
            "Kontrola konzistence našla $($warnings.Count) pravděpodobných nesrovnalostí:`n`n- " + ($warnings -join "`n- ") + "`n`nPřesto vygenerovat?",
            "Kontrola konzistence",
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        if ($answer -eq [System.Windows.Forms.DialogResult]::No) { return }
    }

    # --- Kontrola nevyplnenych voleb (vse je volitelne, ale prazdny vystup nema smysl) ---
    $unspecified = @($vals.Values | Where-Object { $_ -eq "Nespecifikováno" })
    if ($unspecified.Count -gt 0 -and $unspecified.Count -ge [Math]::Ceiling($vals.Count / 2)) {
        $answer = [System.Windows.Forms.MessageBox]::Show(
            "Nevybrali jste $($unspecified.Count) z $($vals.Count) klíčových voleb.`n`nVygenerovaný kontext bude na mnoha místech obsahovat 'Nespecifikováno'.`n`nPřesto pokračovat?",
            "Nevyplněné volby",
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        if ($answer -eq [System.Windows.Forms.DialogResult]::No) { return }
    }

    # --- Podmíněné sekce ---
    $neonSection = ""
    if ($vals.DbStrategy -match "Neon") {
        $neonSection = @"

### Neon konfigurace (serverless Postgres)
- Používej **@neondatabase/serverless** driver v HTTP režimu (žádný connection pool)
- V serverless funkcích používej ``neon()`` z ``@neondatabase/serverless``
- Databázové větve (branches) se vytvářejí automaticky pro každý Preview Deployment
- Pro migrace použij ``drizzle-kit`` nebo ``prisma migrate`` s přímým (ne-pooled) připojením
- V produkci použij pooled connection string (``-pooler`` sufix)
- Scale-to-zero: neaktivní větve se po 5 minutách pozastaví
"@
    }
    
    $supabaseSection = ""
    if ($vals.DbStrategy -match "Supabase") {
        $supabaseSection = @"

### Supabase konfigurace (all-in-one BaaS)
- Používej **Supavisor connection pooler** (transaction mode) pro serverless funkce
- Direct connection používej POUZE pro migrace
- Row Level Security (RLS) je povinná pro všechny tabulky s uživatelskými daty
- Auth: používej Supabase Auth s vlastními claims pro RBAC
- Storage: použij Supabase Storage pro soubory (alternativa k Vercel Blob)
- Realtime: Supabase Realtime pro live updates (Postgres changes)
- **Neprováděj dual-write stejných dat do Neon i Supabase**
"@
    }
    
    $mobileSection = ""
    if ($vals.Mobile -notmatch "Žádná|PWA") {
        $mobileSection = @"

## 7. Mobilní aplikace
* **Platforma:** $($vals.Mobile)
* **Distribuce:** $($vals.MobileDeploy)
* **Navigace:** $($vals.MobileNav)
* **UI knihovna:** $($vals.MobileUi)
* **State & Data:** $($vals.MobileState)
* **Autentizace:** $($vals.MobileAuth)

### Mobilní funkce:
$($lists.MobileFeatures)

### Pravidla pro mobilní část:
- **Sdílené typy:** Vytvoř ``packages/shared-types/`` s TypeScript typy sdílenými mezi webem a mobilem
- **API klient:** Sdílený API klient s automatickým refresh token flow
- **Offline-first:** Drafty a kritická data ukládej do AsyncStorage, synchronizuj při připojení
- **Bezpečnost:** Tokeny VŽDY v SecureStore (nikdy AsyncStorage)
- **Build:** ``eas build --platform android --profile preview`` pro testovací APK
"@
    }
    
    $tipTapSection = ""
    if ($vals.CmsEditor -match "TipTap") {
        $tipTapSection = @"

### TipTap editor konfigurace
- Použij **@tiptap/react** + **@tiptap/starter-kit** jako základ
- Pro uložení používej **JSON formát** (ne HTML)
- Vlastní extensiony: vytvoř ``extensions/`` složku pro vlastní node/mark typy
- Renderuj obsah bezpečně pomocí **generateHTML()** z ``@tiptap/html`` na serveru
- **Nikdy nepoužívej dangerouslySetInnerHTML** bez předchozí sanitizace
"@
    }
    
    $vercelSection = ""
    if ($vals.Deploy -match "Vercel") {
        $vercelSection = @"

### Vercel konfigurace
- Používej ``vercel.json`` pro rewrite rules a environment-specific nastavení
- Preview Deployments: automaticky pro každý PR (integrace s Neon branching)
- Edge Functions: pro geograficky distribuované API endpointy
- Blob Storage: pro uživatelské soubory (alternativa k S3)
- Analytics + Speed Insights: povinné pro monitoring produkce
- **Cron Jobs:** pro plánované úlohy (cleanup, e-maily, reporty)
"@
    }

    $specializedSection = ""
    $hasSpecialized = ($lists.Ecommerce -notmatch "Není vyžadováno") `
        -or ($lists.Booking -notmatch "Není vyžadováno") `
        -or ($lists.Saas -notmatch "Není vyžadováno") `
        -or ($lists.Lms -notmatch "Není vyžadováno") `
        -or ($lists.Crm -notmatch "Není vyžadováno")

    if ($hasSpecialized -or ($vals.AppDomain -notmatch "Obecná|Portfolio")) {
        $specializedSection = @"

## 8. Specializované moduly a doména
* **Primární doména aplikace:** $($vals.AppDomain)

**E-shop moduly:**
$($lists.Ecommerce)

**Rezervační moduly:**
$($lists.Booking)

**SaaS moduly:**
$($lists.Saas)

**LMS moduly:**
$($lists.Lms)

**CRM moduly:**
$($lists.Crm)

**Integrace třetích stran:**
$($lists.Integrations)

**Marketing & Growth:**
$($lists.Marketing)

**Právní & Compliance:**
$($lists.Legal)
"@
    }

    $domainPersona = ""
    if ($vals.AppDomain -match "E-shop|Marketplace") {
        $domainPersona += @"

### E-commerce pravidla (Kritická)
- Ceny VŽDY v minor units (haléře) jako ``integer``, nikdy ``float``
- Skladové množství ověřuj **atomicky** (SELECT FOR UPDATE nebo optimistic locking)
- Order je **immutable** po zaplacení
- Webhooky platebních bran MUSÍ být **idempotentní**
- Doprava a DPH se počítají **VŽDY na serveru**
- GDPR: ukládej pouze nezbytné údaje
"@
    }
    if ($vals.AppDomain -match "Rezerva|Booking") {
        $domainPersona += @"

### Rezervační pravidla (Kritická)
- Všechny časy v **UTC** v DB
- Race conditions: rezervaci VŽDY přes **transaction** s unique constraint
- Overbooking: zabraň na **DB úrovni** (exclusion constraint)
- Storno policy: definuj okno (např. 24h předem)
- Notifikace: T-24h reminder + T-1h confirmation
"@
    }
    if ($vals.AppDomain -match "SaaS") {
        $domainPersona += @"

### SaaS pravidla (Kritická)
- Multi-tenancy: každý záznam má ``tenant_id``
- Subscription stav VŽDY ověřuj na **serveru**
- Webhooky Stripe: **verify signature**, idempotence
- Feature gating: **deklarativní**
- Dunning: selhání platby → 3 pokusy → downgrade
"@
    }
    if ($vals.AppDomain -match "LMS") {
        $domainPersona += @"

### LMS pravidla
- Video obsah: **signed URLs** s expirací
- Progress tracking: per-user
- Certifikáty: PDF s **verifikačním kódem**
- Kvízy: server-side validace
"@
    }
    if ($lists.Crm -notmatch "Není vyžadováno") {
        $domainPersona += @"

### CRM pravidla
- Soft delete pro kontakty
- Deduplikace podle emailu
- Audit log: immutable append-only
"@
    }

    $legalSection = ""
    if ($lists.Legal -notmatch "Není vyžadováno") {
        $legalSection = @"

### Právní a compliance (CZ/SK specifika)
- **GDPR:** souhlas s cookies musí být **opt-in**
- **14 dní na vrácení:** stav objednávky ``RETURN_REQUESTED``
- **Reklamace:** zákonná lhůta 30 dní
- **DPH:** kalkulace vč. reverse charge pro EU B2B
- **Obchodní podmínky:** verzované
"@
    }

    # ---- Bezpečný název projektu (odstranění neplatných znaků z cesty) ----
    Function Get-SafeName([string]$name) {
        $invalidChars = [System.IO.Path]::GetInvalidFileNameChars() -join ''
        $escaped = [System.Text.RegularExpressions.Regex]::Escape($invalidChars)
        $safe = [System.Text.RegularExpressions.Regex]::Replace($name, "[$escaped]", '_')
        $safe = ($safe -replace '\s+', '_').Trim('_')
        if ([string]::IsNullOrWhiteSpace($safe)) { $safe = "EnterpriseProject" }
        return $safe
    }
    $projName = Get-SafeName $projName

    # ---- Výběr cílového repozitáře (kam se zapíše .github složka) ----
    $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderDialog.Description = "Vyber kořenovou složku repozitáře (vytvoří se v ní .github/copilot-instructions.md a .github/instructions/)."
    $folderDialog.ShowNewFolderButton = $true
    $repoRoot = $null
    if ($folderDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $repoRoot = $folderDialog.SelectedPath
    } else {
        $desktop = [System.Environment]::GetFolderPath("Desktop")
        $repoRoot = Join-Path $desktop "CopilotContext_$projName"
        if (-not (Test-Path $repoRoot)) { New-Item -ItemType Directory -Path $repoRoot | Out-Null }
    }

    $githubDir = Join-Path $repoRoot ".github"
    $rootInstructionsPath = Join-Path $githubDir "copilot-instructions.md"

    if (Test-Path $rootInstructionsPath) {
        $overwrite = [System.Windows.Forms.MessageBox]::Show(
            "V cílové složce už existuje '.github/copilot-instructions.md'.`n`nPřepsat existující soubory?",
            "Soubory již existují",
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        if ($overwrite -eq [System.Windows.Forms.DialogResult]::No) { return }
    }

    if (-not (Test-Path $githubDir)) { New-Item -ItemType Directory -Path $githubDir | Out-Null }

    # ---- 1. Instrukce (podklad pro copilot-instructions.md) ----
    $instrukce = @"
# Architektonická specifikace: $($projName)

Jsi v kontextu moderního, enterprise-ready projektu. Následující direktivy definují strukturu a nástroje, které **MUSÍŠ** při generování dodržovat.

## 1. Základní Architektura
* **Repozitář:** $($vals.Arch)
* **Typ architektury:** $($vals.ArchType)
* **Rendering strategie:** $($vals.Render)
* **Cílové platformy:** $($vals.Target)
* **Cílové nasazení:** $($vals.Deploy)
* **IaC:** $($vals.Iac)

## 2. Správa obsahu, Meta dat a i18n
* **Strategie textového obsahu:** $($vals.Cms)
* **CMS Editor:** $($vals.CmsEditor)
* **Admin Shell:** $($vals.AdminShell)
* **Správa Meta Tagů (SEO):** $($vals.Seo)
* **Internacionalizace:** $($vals.I18n)

**Kritické pravidlo pro UI:** UI komponenty nesmí obsahovat "hardcoded" texty. Veškerý textový obsah musí být načítán dynamicky.

## 3. Tech Stack
* **Frontend:** $($vals.Fe) + $($vals.Css)
* **Design System & Vibe:** $($vals.Design)
* **State Management:** $($vals.State)
* **Formuláře a validace:** $($vals.Forms)
* **Animace:** $($vals.Animation)
* **Backend:** $($vals.Be)
* **Databázová strategie:** $($vals.DbStrategy)
* **Integrace s Vercel DB:** $($vals.VercelDb)
* **ORM / Data Layer:** $($vals.Orm)
* **Data Fetching:** $($vals.Fetch)
* **Real-time komunikace:** $($vals.Realtime)
* **Connection Pooling:** $($vals.Pooling)
* **Cache strategie:** $($vals.Cache)
* **API Design:** $($vals.ApiDesign)

## 4. Kvalita, Bezpečnost a Observability
* **Standardy kódu:**
$($lists.Lint)

* **Testování:**
$($lists.Test)

* **Typ autentizace:** $($vals.AuthType)
* **Autentizace & Role:**
$($lists.Auth)

* **Bezpečnostní moduly:**
$($lists.Sec)

* **Observability & Analytics:**
$($lists.Observability)

* **Logování:**
$($lists.Log)

* **Compliance:**
$($lists.Compliance)

## 5. DevOps a CI/CD
* **CI/CD Pipeline:**
$($lists.CiCd)

* **Vercel konfigurace:**
$($lists.VercelFeatures)

## 6. Implementované Moduly
**Administrace:**
$($lists.Admin)

**Byznys Funkce:**
$($lists.Core)

**AI Moduly:**
$($lists.Ai)

**A/B Testování:** $($vals.AbTesting)

**Frontend UI utility:**
$($lists.FeUi)
$($mobileSection)
$($neonSection)
$($supabaseSection)
$($vercelSection)
$($tipTapSection)
$($specializedSection)
$($legalSection)
"@

    # ---- 2. vlastnostiagenta.md ----
    $persona = @"
# Persona: Lead Enterprise Architect & DevOps Engineer

V tomto repozitáři přebíráš roli zkušeného softwarového architekta.

## Zásadní Pravidla (Never Break These):

1. **Decoupling obsahu:** Veškerý textový obsah musí být odděleny od souborů s pohledy/logikou.

2. **Type Safety & Zod:** Typový systém je absolutně striktní. Žádné ``any``.

3. **Zabezpečený Backend & Práva:** Zero-trust model. Oprávnění (RBAC) ověřuj na úrovni serveru.

4. **Error Handling & Observability:** Nikdy nepolykej chyby. Zabal do ``try/catch``, zaloguj, bezpečně vrať chybový stav.

5. **Databázová hygiena (Neon/Supabase):** 
   - Neon: HTTP driver, žádný pool
   - Supabase: RLS policies, Supavisor pro serverless
   - **NIKDY neprováděj dual-write mezi Neon a Supabase**

6. **Sanitizace uživatelského vstupu:** HTML z CMS MUSÍ projít sanitizací před renderem.

7. **Nezávislost na LLM poskytovateli:** AI integrace abstrahuj přes vrstvu.

8. **Bezpečnost mobilní aplikace:** Tokeny VŽDY v SecureStore.
$($domainPersona)
"@

    # ---- 3. schopnosti.md ----
    $skills = @"
# Očekávané dovednosti pro Copilot Workspace

## Datová a Backend vrstva
* Sestaví datové schéma pro **$($vals.Orm)** nad **$($vals.DbStrategy)**.
* Připraví autentizační middleware (**$($vals.AuthType)**).
* Implementuje cache strategii (**$($vals.Cache)**).
* Connection pooling (**$($vals.Pooling)**).

## Frontend a Obsah
* Sanitizace HTML přes ``isomorphic-dompurify``.
* Pro **$($vals.Seo)** připraví dynamické hlavičky.
* Využívá pokročilé funkce **$($vals.Fe)**.
* i18n (**$($vals.I18n)**): typované překladové klíče.

## Infrastructure as Code & DevOps
* Vygeneruje konfigurační soubory pro **$($vals.Deploy)**.
* Nastaví ``tsconfig.json`` se striktním režimem.
* CI/CD pipeline (**$($lists.CiCd)**).

## Mobilní aplikace (pokud aktivní)
* Sdílené typy v ``packages/shared/``.
* Expo konfigurace s EAS Build profily.
* Offline sync s konflikt resolution.

## AI integrace (pokud aktivní)
* Abstrakce LLM poskytovatele.
* Streaming odpovědí (SSE).
* RAG: chunking + embedding.
* Cost tracking.

## Bezpečnost a compliance
* Rate limiting.
* CSP hlavičky.
* Audit log (hash-chained).
* GDPR compliance.

## Specializované domény (pokud aktivní)
* **E-shop:** košík persistence, idempotentní webhooky.
* **Rezervace:** timezone handling, race condition prevence.
* **SaaS:** multi-tenant izolace, subscription middleware.
* **LMS:** signed URLs, server-side progress tracking.
* **CRM:** soft delete, deduplikace.
"@

    # ---- 4. databaze.md ----
    $dbDoc = @"
# Databázová konfigurace: $($projName)

## Vybraná strategie
**$($vals.DbStrategy)**

## Integrace s Vercel
**$($vals.VercelDb)**

## Connection Pooling
**$($vals.Pooling)**

## Cache
**$($vals.Cache)**

## Klíčová pravidla

### Neon
- Driver: ``@neondatabase/serverless`` v HTTP režimu
- Preview branches automaticky pro každý PR
- Migrace: ``drizzle-kit push`` nebo ``prisma migrate deploy``
- Production: pooled URL s ``-pooler`` sufixem

### Supabase
- Connection: **Supavisor** transaction mode
- Direct connection POUZE pro migrace
- RLS: povinné pro všechny tabulky
- Auth: ``@supabase/ssr`` pro Next.js

### Dual-stack
- Preview: Neon branches
- Produkce: Supabase
- **Nikdy nesynchronizuj data mezi Neon a Supabase**

## Zakázané vzory
- ❌ Přímé ``new Pool()`` v serverless funkci
- ❌ Dlouhotrvající transakce přes více requestů
- ❌ Raw SQL bez prepared statements
- ❌ Secrets v kódu
- ❌ Migrace z pooled připojení
"@

    # ---- 5. specializace.md ----
    $specializationDoc = @"
# Specializované moduly: $($projName)

## Primární doména
**$($vals.AppDomain)**

## Aktivní moduly

### E-shop
$($lists.Ecommerce)

### Rezervace
$($lists.Booking)

### SaaS
$($lists.Saas)

### LMS
$($lists.Lms)

### CRM
$($lists.Crm)

## Externí integrace
$($lists.Integrations)

## Marketing
$($lists.Marketing)

## Právní požadavky
$($lists.Legal)

## Doporučené knihovny

| Modul | Knihovna | Účel |
|-------|----------|------|
| E-shop platby | ``stripe`` | Platební brána |
| E-shop platby CZ | ``gopay-sdk`` | CZ platební brána |
| Doprava CZ | ``packeta-api`` | Integrace Packeta |
| Fakturace | ``fakturoid-client`` | Fakturace CZ |
| Email | ``resend`` | Transakční e-maily |
| SMS | ``twilio`` | SMS notifikace |
| Rezervace | ``date-fns-tz`` | Timezone handling |
| Rezervace | ``rrule`` | Opakované události |
| SaaS billing | ``@stripe/stripe-js`` | Client-side checkout |
| SaaS multi-tenant | ``@supabase/ssr`` | RLS + tenant isolation |
| LMS video | ``@mux/mux-node`` | Video streaming |
| CRM pipeline | ``@dnd-kit/core`` | Drag & drop deals |
| Marketing | ``@react-email/components`` | Email šablony |
| Compliance | ``cookiebot`` | GDPR cookies |
"@

    # ==========================================
    # CHOVÁNÍ AGENTA - mapování zaškrtnutých voleb na konkrétní akční pokyny
    # ==========================================
    # ---- Mapování zaškrtnutých položek chování agenta na konkrétní, akční pokyny ----
    # Poznámka: hodnoty jsou v jednoduchých uvozovkách (literal), aby zpětná lomítka
    # uvnitř (napr. `npm install`) nebyla PowerShellem chybně interpretována jako escape sekvence.
    $behaviorMap = @{
        'Nikdy neinstalujte nedeklarované závislosti' = 'Nikdy neinstaluj závislosti, které nejsou deklarované v manifestu (např. `npm install`, `pip install`, přidání balíčku).'
        'Spusťte testovací sadu' = 'Před odevzdáním změn spusť celou (nebo relevantní) testovací sadu.'
        'Spusťte linter a formátovač' = 'Spusť linter a formátovač před dokončením úlohy a oprav nahlášené problémy.'
        'Kontrola typů' = 'Spusť typovou kontrolu (`tsc`, `mypy` apod.) a oprav všechny chyby.'
        'Replikujte CI kontroly lokálně' = 'Před odevzdáním ověř stejné kroky, jaké spouští CI pipeline.'
        'Dodržujte stávající strukturu' = 'Neprováděj reorganizaci složek/architektury bez explicitního zadání.'
        'Společné umístění testů' = 'Umísťuj nové testy podle stávající konvence (vedle kódu nebo v `tests/`).'
        'Vyhněte se novým závislostem' = 'Preferuj existující knihovny před přidáváním nových balíčků.'
        'Respektujte konfigurační soubory' = 'Dodržuj nastavení v `tsconfig`, `eslint`, `.editorconfig` a `pyproject`.'
        'Preferujte konst' = 'Preferuj `const`/immutable proměnné před `let`/`var`, kde je to možné.'
        'Předsazené výrazy (early returns)' = 'Používej early return a vyhýbej se hlubokému zanoření podmínek.'
        'Popisné pojmenování' = 'Volí jednoznačné, popisné názvy proměnných a funkcí.'
        'Malé funkce' = 'Udržuj funkce krátké a zaměřené na jednu odpovědnost.'
        'Autodokumentační kód' = "Piš samovysvětlující kód; komentáře jen pro vysvětlení 'proč', ne 'co'."
        'Pokrytí pro nové kódy' = 'Ke každé nové/změněné funkcionalitě přidej odpovídající testy.'
        'Jednotkové testy' = 'Pokrývej novou logiku jednotkovými testy.'
        'Okrajové případy' = "Testuj i hraniční a chybové stavy, ne jen 'happy path'."
        'Testovací názvy' = 'Používej popisné názvy testů vysvětlující očekávané chování.'
        'AAA vzor' = 'Strukturuj testy podle vzoru Arrange-Act-Assert.'
        'JSDoc/Docstringy' = 'Dokumentuj veřejné funkce/třídy pomocí JSDoc nebo docstringů.'
        'Aktualizace README' = 'Aktualizuj README při přidání nové funkce nebo změně chování.'
        'Složitá logika' = 'Přidej inline komentáře u netriviálních algoritmů.'
        'Dokumentace API' = 'Dokumentuj API endpointy, request/response tvary a chybové kódy.'
        'Ověřujte vstupy' = 'Validuj a sanitizuj veškerý uživatelský vstup na serveru.'
        'Žádná tvrdá tajemství' = 'Nikdy nevkládej API klíče/hesla/tokeny do kódu; používej ENV proměnné.'
        'Parametrizované dotazy' = 'Používej parametrizované dotazy/ORM, nikdy string-konkatenaci SQL.'
        'Prevence XSS' = 'Escapuj/sanitizuj výstupy do HTML, aby ses vyhnul XSS.'
        'Sémantické HTML' = 'Používej sémantické značky (`nav`, `main`, `button`) místo obecných `div`/`span`.'
        'Alternativní text u obrázků' = 'Ke každému obrázku doplň smysluplný `alt` text.'
        'Navigace klávesnicí' = 'Zajisti, že všechny interaktivní prvky jsou ovladatelné klávesnicí.'
        'Štítky ARIA' = 'Doplň ARIA atributy u vlastních/netriviálních UI komponent.'
        'Lint pravidla pro výkon' = 'Dodržuj výkonnostní lint pravidla (např. `exhaustive-deps`, `no-unused-vars`).'
        'Memoizace' = 'Používej memoizaci (`useMemo`/`useCallback` apod.) u nákladných výpočtů a renderů.'
        'Vyhněte se N+1 dotazům' = 'Používej eager loading / JOIN místo N+1 dotazů do databáze.'
        'Velikost svazku' = 'Sleduj velikost výsledného JS bundlu, vyhýbej se zbytečným závislostem.'
    }
    Function Get-BehaviorBullets([string]$rawList) {
        if ($rawList -match "Není vyžadováno") { return $rawList }
        $lines = $rawList -split "`n"
        $out = @()
        foreach ($line in $lines) {
            $label = $line -replace '^- ', ''
            if ($behaviorMap.ContainsKey($label)) { $out += "- $($behaviorMap[$label])" } else { $out += $line }
        }
        return $out -join "`n"
    }

    $behaviorDoc = @"
# Chování agenta: $($projName)

Tyto pokyny platí pro celý repozitář bez ohledu na zvolený tech stack. Popisují, jak se má Copilot chovat
při psaní, úpravě a validaci kódu.

## Sestavení a validace
$(Get-BehaviorBullets $lists.BuildValidation)

## Rozložení projektu
$(Get-BehaviorBullets $lists.ProjectLayout)

## Styl kódu
$(Get-BehaviorBullets $lists.CodeStyleBehavior)

## Testování
$(Get-BehaviorBullets $lists.TestingBehavior)

## Dokumentace
$(Get-BehaviorBullets $lists.DocsBehavior)

## Zabezpečení (obecné)
$(Get-BehaviorBullets $lists.SecurityBehavior)

## Přístupnost
$(Get-BehaviorBullets $lists.Accessibility)

## Výkon
$(Get-BehaviorBullets $lists.Performance)
"@

    # ==========================================
    # SESTAVENÍ VÝSTUPU
    # Výstup je ucelený: místo desítek dílčích souborů vzniká malá sada
    # konsolidovaných souborů podle zvoleného formátu.
    #   Instrukce  -> .github/copilot-instructions.md
    #   Agent      -> AGENTS.md
    #   Copilot    -> .github/workflows/copilot-setup-steps.yml
    #   Skills     -> .github/skills/SKILL.md            (jen rozšířený formát)
    #   Agent-task -> .github/agents/agent-task.agent.md (jen rozšířený formát)
    # ==========================================
    $utf8 = New-Object System.Text.UTF8Encoding $false
    $writtenFiles = @()

    $modeExtended     = ($vals.SkillOutput -match "Rozšířený")
    $modeInstructions = ($vals.SkillOutput -match "Jen instrukce")

    # --- Vybrane skilly ---
    $selectedSkills = @()
    if ($vals.SkillScope -notmatch "Bez skills") {
        $allSkills = $vals.SkillScope -match "Všechny"
        foreach ($sk in $script:skillCatalog) {
            $grp = $skillGroups[$sk.C]
            $isChecked = $false
            if ($grp) { $isChecked = (@($grp | Where-Object { $_.Text -eq $sk.T -and $_.Checked }).Count -gt 0) }
            if ($allSkills -or $isChecked) { $selectedSkills += $sk }
        }
    }

    $incChecklist = Test-Checked $cSkillContent "Kontrolní seznam (checklist)"
    $incExample   = Test-Checked $cSkillContent "Příklad použití"
    $incRelated   = Test-Checked $cSkillContent "Odkazy na související soubory"
    $incMetadata  = Test-Checked $cSkillFrontMatter "Frontmatter s metadaty"
    $incSummary   = Test-Checked $cSkillFrontMatter "Souhrnná tabulka skills"
    $incTaskInDoc = Test-Checked $cSkillFrontMatter "Úkolový prompt v instrukcích"
    $incTaskFile  = Test-Checked $cSkillFrontMatter "Úkolový prompt jako samostatný soubor"

    # ==========================================
    # ÚKOLOVÝ PROMPT
    # Role agenta a konkrétní úkoly odvozené z vybrané domény, modulů a stacku.
    # ==========================================
    Function Get-RoleName([string]$domain) {
        switch -Regex ($domain) {
            'E-shop'            { return "Full Stack E-commerce Developer" }
            'Marketplace'       { return "Full Stack Marketplace Developer" }
            'SaaS'              { return "Full Stack SaaS Developer" }
            'Rezerva|Booking'   { return "Full Stack Developer pro rezervační systémy" }
            'LMS'               { return "Full Stack EdTech Developer" }
            'CRM'               { return "Full Stack Developer pro interní nástroje" }
            'Blog|Magazín'      { return "Full Stack Web Developer se zaměřením na obsah a SEO" }
            'Portfolio'         { return "Frontend Developer se zaměřením na výkon a SEO" }
            'Sociální'          { return "Full Stack Developer pro komunitní platformy" }
            default             { return "Full Stack Developer" }
        }
    }

    # Sekce ukolu z vybranych modulu; prazdne skupiny se vynechaji
    Function Get-TaskSection([string]$title, $listValues) {
        $parts = @()
        foreach ($v in $listValues) {
            if ($v -and $v -notmatch "Není vyžadováno") { $parts += $v }
        }
        if ($parts.Count -eq 0) { return "" }
        return "### $title`n`n" + ($parts -join "`n")
    }

    Function Get-TaskPrompt {
        $role = Get-RoleName $vals.AppDomain
        $hasMobile = ($vals.Mobile -notmatch "Žádná|PWA|Nespecifikováno")
        $sections = @()
        $sections += Get-TaskSection "Doménové funkce" @($lists.Ecommerce, $lists.Booking, $lists.Saas, $lists.Lms, $lists.Crm)
        $sections += Get-TaskSection "Aplikace, správa a obsah" @($lists.Admin, $lists.Core, $lists.Ai)
        $sections += Get-TaskSection "Externí integrace" @($lists.Integrations)
        $sections += Get-TaskSection "Marketing a růst" @($lists.Marketing)
        $sections += Get-TaskSection "Právo, soukromí a soulad" @($lists.Legal, $lists.Compliance)
        $sections += Get-TaskSection "Kvalita, testování a provoz" @($lists.Test, $lists.CiCd, $lists.Observability, $lists.Log, $lists.VercelFeatures)
        $sections += Get-TaskSection "Autentizace, role a zabezpečení" @($lists.Auth, $lists.Sec)
        $sections += Get-TaskSection "Frontend a UX" @($lists.FeUi)
        if ($hasMobile) { $sections += Get-TaskSection "Mobilní aplikace" @($lists.MobileFeatures) }
        $sections += Get-TaskSection "Chování při práci s kódem" @($lists.BuildValidation, $lists.ProjectLayout, $lists.CodeStyleBehavior, $lists.TestingBehavior, $lists.DocsBehavior, $lists.SecurityBehavior, $lists.Accessibility, $lists.Performance)
        $taskBody = (@($sections | Where-Object { $_ -ne "" }) -join "`n`n")

        $stackLines = @(
            "* **Doména:** $($vals.AppDomain)"
            "* **Architektura:** $($vals.Arch) — $($vals.ArchType)"
            "* **Rendering:** $($vals.Render)"
            "* **Frontend:** $($vals.Fe) + $($vals.Css)"
            "* **Backend:** $($vals.Be)"
            "* **Databáze:** $($vals.DbStrategy) + $($vals.Orm)"
            "* **Autentizace:** $($vals.AuthType)"
            "* **Nasazení:** $($vals.Deploy)"
        )
        if ($hasMobile) { $stackLines += "* **Mobil:** $($vals.Mobile) ($($vals.MobileNav), $($vals.MobileState))" }

        $py = @"
# Úkolový prompt: $projName

Od teď v tomto repozitáři vystupuješ jako **$role**. Neodpovídej obecně - dodávej
konkrétní, otestovaný a nasaditelný kód, který respektuje níže uvedený kontext.

## Tvoje role
* Navrhuj a implementuj funkce od databáze po UI.
* Drž se zvoleného tech stacku a architektury, nevnucuj alternativy.
* Piš kód tak, aby mu rozuměl i někdo, kdo projekt vidí poprvé.
* U každé změny vysvětli dopad a rizika.

## Kontext projektu
$($stackLines -join "`n")

## Hlavní úkoly

$taskBody

### Průběžné úkoly (platí vždy)
- Udržuj build, typovou kontrolu a lint zelené.
- Ke každé nové nebo změněné funkci přidej test.
- Neměň strukturu repozitáře ani závislosti bez výslovného zadání.
- Nikdy necommituj tajemství, klíče ani soubory ``.env``.
- Validuj a sanitizuj veškerý vstup na serveru.
- Zapisuj chyby do logu, nepolykej je.

## Jak postupovat
1. Přečti ``.github/copilot-instructions.md`` a případně ``.github/skills/SKILL.md``.
2. Prozkoumej relevantní část kódu, než cokoli změníš.
3. Navrhni nejmenší funkční změnu a krátce ji popiš.
4. Implementuj ji včetně testů.
5. Spusť lint, typovou kontrolu a testy.
6. Shrň, co se změnilo, proč a jaké to má dopady.

## Když si nejsi jistý
- Zeptej se místo domýšlení. Uveď, co přesně potřebuješ vyjasnit.
- Když najdeš v zadání rozpor, upozorni na něj a navrhni řešení.

## Co nikdy nedělat
- Nepřidávej závislosti, které nejsou v manifestu.
- Neobcházej ověřování oprávnění na serveru.
- Nevypínej testy ani kontroly, abys "prošel".
- Nepřepisuj cizí funkční kód bez důvodu.

## Kritéria hotovo
- [ ] Zadání je splněno a popsáno.
- [ ] Testy procházejí a pokrývají nové chování.
- [ ] Lint a typová kontrola bez chyb.
- [ ] Žádné nové nedeklarované závislosti ani tajemství.
- [ ] Dopady a případná migrace jsou popsané.
"@
        return $py
    }
    $fence = [string]::new([char]96, 3)

    # Uvodni H1 bloku snizi na H2, aby v jednom souboru byla jen jedna hlavicka
    Function As-Section([string]$text) {
        if ([string]::IsNullOrWhiteSpace($text)) { return "" }
        return [regex]::Replace($text.Trim(), '(?m)^# ', '## ', 1)
    }

    # Nevyplnene volby zcitelni a slouci opakovani
    Function Polish([string]$text) {
        $r = $text -replace 'Nespecifikováno — Nespecifikováno', 'neuvedeno'
        $r = $r -replace 'Nespecifikováno', 'neuvedeno'
        return $r
    }

    # ==========================================
    # SLOUČENÍ MÍSTO PŘEPSÁNÍ
    # Vygenerovaný obsah se uzavře do markerů. Pokud soubor existuje a markery
    # obsahuje, přepíše se jen blok mezi nimi a ruční úpravy mimo markery zůstanou.
    # ==========================================
    Function Merge-GeneratedContent([string]$existing, [string]$newContent, [string]$startMarker, [string]$endMarker) {
        $block = $startMarker + "`n" + $newContent.TrimEnd() + "`n" + $endMarker + "`n"
        if ([string]::IsNullOrWhiteSpace($existing)) { return $block }
        $si = $existing.IndexOf($startMarker)
        $ei = $existing.IndexOf($endMarker)
        if ($si -ge 0 -and $ei -gt $si) {
            $before = $existing.Substring(0, $si)
            $after = $existing.Substring($ei + $endMarker.Length)
            return $before + $block + $after
        }
        # Soubor bez markerů: vygenerovaný blok nahoru, původní obsah zůstává pod ním
        return $block + "`n" + $existing
    }

    Function Write-MergedFile([string]$filePath, [string]$content, [bool]$isYaml) {
        $startMarker = if ($isYaml) { '# copilot-builder:start' } else { '<!-- copilot-builder:start -->' }
        $endMarker   = if ($isYaml) { '# copilot-builder:end' } else { '<!-- copilot-builder:end -->' }
        $clean = Polish $content
        $existing = ""
        if (Test-Path $filePath) { $existing = [System.IO.File]::ReadAllText($filePath) }
        $merged = Merge-GeneratedContent $existing $clean $startMarker $endMarker
        $dir = Split-Path $filePath -Parent
        if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
        [System.IO.File]::WriteAllText($filePath, $merged, $utf8)
        return $merged
    }

    # Postup a checklist jednoho skillu
    Function Get-SkillBlock($sk, [int]$level) {
        $h = [string]::new('#', $level)
        $parts = @("$h $($sk.T)", "", $sk.D, "", "$h# Postup")
        foreach ($step in $script:skillCategorySteps[$sk.C]) { $parts += "- $step" }
        if ($incChecklist) {
            $parts += @("", "$h# Kontrolní seznam")
            foreach ($item in $sk.K) { $parts += "- [ ] $item" }
        }
        if ($incExample) {
            $parts += @("", "$h# Příklad použití", "", $fence, "Uživatel: Potřebuji aplikovat: $($sk.T).", "Agent: Projde Postup, ověří Kontrolní seznam a teprve pak upraví kód.", $fence)
        }
        if ($incRelated) {
            $parts += @("", "$h# Související soubory", "- ``.github/copilot-instructions.md``", "- ``AGENTS.md``", "- ``.github/workflows/copilot-setup-steps.yml``")
        }
        return ($parts -join "`n")
    }

    # --- Souhrnna tabulka skillu ---
    $skillsSummaryTable = ""
    if ($selectedSkills.Count -gt 0) {
        $st = @("| Skill | Kategorie | Zaměření |", "|-------|-----------|----------|")
        foreach ($sk in $selectedSkills) { $st += "| ``$($sk.S)`` | $($sk.C) | $($sk.T) |" }
        $skillsSummaryTable = ($st -join "`n")
    }

    # --- Sekce skills pro vlozeni do instrukci ---
    $skillsSection = ""
    if ($selectedSkills.Count -gt 0) {
        if ($modeExtended) {
            $skillsSection = @"
## Skills

Podrobné postupy jsou v ``.github/skills/SKILL.md``. Načti je, když úloha odpovídá některému ze skillů.

$(if ($incSummary) { "### Přehled`n`n$skillsSummaryTable`n" })
"@
        } else {
            $sb = @("## Skills", "", "Následující postupy použij, když úloha odpovídá některému ze skillů.", "")
            if ($incSummary) { $sb += $skillsSummaryTable; $sb += "" }
            foreach ($sk in $selectedSkills) { $sb += (Get-SkillBlock $sk 3); $sb += "" }
            $skillsSection = ($sb -join "`n")
        }
    }
    if ($selectedSkills.Count -eq 0) {
        $skillsSection = "## Skills`n`n*(Nejsou vybrány žádné skills.)*"
    }

    # --- Agent-task sekce ---
    $agentTaskSection = @"
## Agent Task

### Cíl
Doplňovat a udržovat projekt podle specifikace výše: **$($vals.AppDomain)** postavená nad $($vals.Fe), $($vals.Be) a $($vals.DbStrategy).

### Rozsah práce
- Dodržuj architekturu, tech stack a databázová pravidla z tohoto souboru, případně z ``.github/skills/SKILL.md``.
- Neměň strukturu repozitáře ani závislosti, pokud to zadání explicitně nevyžaduje.
- Malé, soustředěné změny s testy a popisem v pull requestu.

### Kroky
1. Načti tento soubor a relevantní skilly.
2. Ověř, že rozumíš zadání; při nejasnosti se zeptej, nedomýšlej si.
3. Implementuj nejmenší funkční změnu.
4. Přidej nebo uprav testy.
5. Spusť lint, typovou kontrolu a testy.
6. Shrň změnu a její dopady.

### Kritéria hotovo
- [ ] Kód je typově bezpečný a prochází lintem.
- [ ] Testy pokrývají nové nebo změněné chování.
- [ ] Nejsou přidány nedeklarované závislosti ani tajemství.
- [ ] Změna je popsána v pull requestu včetně dopadů.
"@

    # --- AGENTS.md (agent pro vsechny nastroje) ---
    Function Get-AgentsMd {
        $usePnpm = ($vals.Arch -match "pnpm|Turborepo|Nx")
        if ($usePnpm) {
            $ci = "pnpm install"; $cd = "pnpm dev"; $cb = "pnpm build"
            $ct = "pnpm test"; $cl = "pnpm lint"; $cy = "pnpm typecheck"
        } else {
            $ci = "npm install"; $cd = "npm run dev"; $cb = "npm run build"
            $ct = "npm test"; $cl = "npm run lint"; $cy = "npm run typecheck"
        }
        $py = @"
# AGENTS.md — $projName

Univerzální instrukce pro AI coding agenty (Copilot, Codex, Cursor, Claude Code, Gemini CLI, Aider).
Soubor leží v kořeni repozitáře; agent použije nejbližší ``AGENTS.md`` v adresářovém stromu.

## Přehled projektu
* **Architektura:** $($vals.Arch) — $($vals.ArchType)
* **Cílové platformy:** $($vals.Target)
* **Frontend:** $($vals.Fe) + $($vals.Css)
* **Backend:** $($vals.Be)
* **Databáze:** $($vals.DbStrategy)
* **Doména:** $($vals.AppDomain)
* **Nasazení:** $($vals.Deploy)

## Příkazy
- Instalace závislostí: ``$ci``
- Vývojový server: ``$cd``
- Produkční build: ``$cb``
- Testy: ``$ct``
- Lint a formát: ``$cl``
- Typová kontrola: ``$cy``

> Ověř názvy skriptů ve ``package.json`` a tento seznam uprav podle skutečnosti.

## Konvence kódu
- Striktní typy, žádné ``any``.
- Validuj vstup na serveru, nikdy nedůvěřuj klientu.
- Texty nepatří do komponent, ale do i18n slovníků.
- Nikdy necommituj tajemství ani soubory ``.env``.
- Nové chování vždy doplň testem.

## Kde jsou instrukce
* ``.github/copilot-instructions.md`` — plný kontext projektu (vždy aktivní pro Copilot)
$(if ($modeExtended) { "* ``.github/skills/SKILL.md`` — postupy a kontrolní seznamy (načítané podle potřeby)`n" })* ``AGENTS.md`` — tento soubor, společný pro všechny agenty
"@
        return $py
    }

    # --- copilot-setup-steps.yml podle zvoleneho stacku ---
    Function Get-SetupSteps {
        $usePnpm = ($vals.Arch -match "pnpm|Turborepo|Nx")
        $be = $vals.Be
        $header = @"
name: "Copilot Setup Steps"

# Prostředí pro Copilot coding agent. Název jobu MUSÍ být 'copilot-setup-steps'.
on:
  workflow_dispatch:
  push:
    paths:
      - .github/workflows/copilot-setup-steps.yml
  pull_request:
    paths:
      - .github/workflows/copilot-setup-steps.yml

jobs:
  copilot-setup-steps:
    runs-on: ubuntu-latest
    permissions:
      contents: read
    steps:
      - name: Checkout
        uses: actions/checkout@v4
"@
        $body = ""
        if ($be -match "Python") {
            $body = @"
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'
          cache: pip

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
          if [ -f pyproject.toml ]; then pip install -e .; fi

      - name: Lint
        run: |
          if command -v ruff >/dev/null 2>&1; then ruff check .; fi

      - name: Type check
        run: |
          if command -v mypy >/dev/null 2>&1; then mypy .; fi

      - name: Test
        run: |
          if [ -f pytest.ini ] || [ -d tests ]; then pytest -q; fi
"@
        } elseif ($be -match "Go \(") {
            $body = @"
      - name: Setup Go
        uses: actions/setup-go@v5
        with:
          go-version: '1.23'
          cache: true

      - name: Install dependencies
        run: go mod download

      - name: Build
        run: go build ./...

      - name: Vet
        run: go vet ./...

      - name: Test
        run: go test ./...
"@
        } elseif ($be -match "Rust") {
            $body = @"
      - name: Setup Rust
        uses: dtolnay/rust-toolchain@stable
        with:
          components: clippy, rustfmt

      - name: Install dependencies
        run: cargo fetch

      - name: Format check
        run: cargo fmt --all -- --check

      - name: Clippy
        run: cargo clippy --all-targets -- -D warnings

      - name: Test
        run: cargo test --all
"@
        } elseif ($be -match "Hono|Edge Functions") {
            $body = @"
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: $(if ($usePnpm) { 'pnpm' } else { 'npm' })
$(if ($usePnpm) { "`n      - name: Setup pnpm`n        uses: pnpm/action-setup@v4`n        with:`n          version: 9`n" })
      - name: Install dependencies
        run: $(if ($usePnpm) { 'pnpm install --frozen-lockfile' } else { 'npm ci' })

      - name: Type check
        run: $(if ($usePnpm) { 'pnpm typecheck' } else { 'npm run typecheck' })

      - name: Lint
        run: $(if ($usePnpm) { 'pnpm lint' } else { 'npm run lint' })

      - name: Test
        run: $(if ($usePnpm) { 'pnpm test' } else { 'npm test' })
"@
        } else {
            $body = @"
$(if ($usePnpm) { "      - name: Setup pnpm`n        uses: pnpm/action-setup@v4`n        with:`n          version: 9`n`n" })      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: $(if ($usePnpm) { 'pnpm' } else { 'npm' })

      - name: Install dependencies
        run: $(if ($usePnpm) { 'pnpm install --frozen-lockfile' } else { 'npm ci' })

      - name: Type check
        run: $(if ($usePnpm) { 'pnpm typecheck' } else { 'npm run typecheck' })

      - name: Lint
        run: $(if ($usePnpm) { 'pnpm lint' } else { 'npm run lint' })

      - name: Test
        run: $(if ($usePnpm) { 'pnpm test' } else { 'npm test' })
"@
        }
        return $header + $body
    }

    # --- agent-task.agent.md ---
    Function Get-AgentTaskMd {
        $py = @"
---
name: agent-task-$($projName.ToLower() -replace '[^a-z0-9]+','-')
description: Provádí zadané úlohy v projektu $projName podle pravidel v .github/copilot-instructions.md.
---

# Agent Task: $projName

## Účel
Samostatný agent pro plnění zadaných úloh v tomto repozitáři. Pracuje podle
``.github/copilot-instructions.md`` a případně ``.github/skills/SKILL.md``.

## Kontext projektu
* **Doména:** $($vals.AppDomain)
* **Architektura:** $($vals.Arch) — $($vals.ArchType)
* **Frontend:** $($vals.Fe) + $($vals.Css)
* **Backend:** $($vals.Be)
* **Databáze:** $($vals.DbStrategy)

## Pravidla
1. Nejdřív si přečti instrukce a relevantní skilly, teprve pak měň kód.
2. Drž se zvoleného tech stacku, nepřidávej závislosti bez schválení.
3. Nikdy necommituj tajemství ani soubory ``.env``.
4. Validuj vstup na serveru, ošetři chyby a zaloguj je.
5. Změny dělej malé a srozumitelné, s testy.

## Postup
1. Přečti zadání a instrukce.
2. Prozkoumej relevantní část kódu.
3. Naplánuj nejmenší funkční změnu.
4. Implementuj a přidej testy.
5. Spusť lint, typovou kontrolu a testy.
6. Vytvoř pull request s popisem změny a dopadů.

## Kritéria hotovo
- [ ] Zadání je splněno a popsáno v pull requestu.
- [ ] Testy procházejí a pokrývají nové chování.
- [ ] Lint a typová kontrola bez chyb.
- [ ] Žádné nové nedeklarované závislosti ani tajemství.
"@
        return $py
    }

    # --- SKILL.md (konsolidovany soubor vsech vybranych skillu) ---
    Function Get-SkillMd {
        $head = @('---', "name: $($projName.ToLower() -replace '[^a-z0-9]+','-')-skills",
            "description: Postupy a kontrolní seznamy pro projekt $projName. Načti příslušný skill, když úloha odpovídá jeho zaměření.")
        if ($incMetadata) {
            $head += 'metadata:'
            $head += "  projekt: $projName"
            $head += "  architektura: $($vals.Arch)"
            $head += "  skills: $($selectedSkills.Count)"
        }
        $head += '---'
        $body = @("", "# Skills: $projName", "",
            "Soubor obsahuje $($selectedSkills.Count) postupů. Každý skill má své zaměření, postup a kontrolní seznam.",
            "")
        if ($incSummary) { $body += "## Přehled"; $body += ""; $body += $skillsSummaryTable; $body += "" }
        foreach ($sk in $selectedSkills) { $body += (Get-SkillBlock $sk 2); $body += "" }
        return (($head -join "`n") + "`n" + (($body -join "`n").TrimEnd()) + "`n")
    }

    # ---- 1. .github/copilot-instructions.md (instrukce + agent-task + skills) ----
    $rootOverview = @"
# Copilot Instructions: $projName

Tento soubor je vždy aktivní repozitářový kontext pro GitHub Copilot (Chat, Coding Agent, PR review).

## Project Overview
* **Repozitář / architektura:** $($vals.Arch) — $($vals.ArchType)
* **Rendering strategie:** $($vals.Render)
* **Cílové platformy:** $($vals.Target)
* **Design systém a vibe:** $($vals.Design)
* **Frontend:** $($vals.Fe) + $($vals.Css)
* **Backend:** $($vals.Be)
* **Databáze:** $($vals.DbStrategy)
* **Doména:** $($vals.AppDomain)
* **Nasazení:** $($vals.Deploy)

---

$(As-Section $instrukce)

---

$(As-Section $persona)

---

$(As-Section $dbDoc)

---

$(As-Section $behaviorDoc)
$(if ($hasSpecialized -or ($vals.AppDomain -notmatch "Obecná|Portfolio")) { "`n---`n`n$(As-Section $specializationDoc)`n" })$(if ($vals.Mobile -notmatch "Žádná|PWA") { "`n---`n`n$(As-Section $mobileSection)`n" })
---

$skillsSection

---

$agentTaskSection
$(if ($incTaskInDoc) { "`n---`n`n$(Get-TaskPrompt)`n" })

---

## References
* ``.github/copilot-instructions.md`` — tento soubor
$(if ($modeExtended) { "* ``.github/skills/SKILL.md`` — postupy a kontrolní seznamy`n" })* ``AGENTS.md`` — instrukce pro ostatní AI agenty
* ``.github/workflows/copilot-setup-steps.yml`` — prostředí pro coding agenta
$(if ($incTaskFile) { "* ``.github/prompts/agent-task.prompt.md`` — úkolový prompt ke vložení do chatu`n" })$(if ($modeExtended) { "* ``.github/agents/agent-task.agent.md`` — definice agenta pro plnění úloh`n" })
"@
    [void](Write-MergedFile $rootInstructionsPath $rootOverview $false)
    $writtenFiles += ".github/copilot-instructions.md"

    # ---- 2. AGENTS.md (agent) ----
    if (-not $modeInstructions) {
        [void](Write-MergedFile (Join-Path $repoRoot "AGENTS.md") (Get-AgentsMd) $false)
        $writtenFiles += "AGENTS.md"
    }

    # ---- 3. copilot-setup-steps.yml (copilot-setup) ----
    if (-not $modeInstructions) {
        $workflowsDir = Join-Path $githubDir "workflows"
        if (-not (Test-Path $workflowsDir)) { New-Item -ItemType Directory -Path $workflowsDir | Out-Null }
        [void](Write-MergedFile (Join-Path $workflowsDir "copilot-setup-steps.yml") (Get-SetupSteps) $true)
        $writtenFiles += ".github/workflows/copilot-setup-steps.yml"
    }

    # ---- 4. a 5. Rozšířený formát: SKILL.md a agent-task ----
    if ($modeExtended) {        if ($selectedSkills.Count -gt 0) {
            $skillsDir = Join-Path $githubDir "skills"
            if (-not (Test-Path $skillsDir)) { New-Item -ItemType Directory -Path $skillsDir | Out-Null }
            [void](Write-MergedFile (Join-Path $skillsDir "SKILL.md") (Get-SkillMd) $false)
            $writtenFiles += ".github/skills/SKILL.md"
        }
        $agentsDir = Join-Path $githubDir "agents"
        if (-not (Test-Path $agentsDir)) { New-Item -ItemType Directory -Path $agentsDir | Out-Null }
        [void](Write-MergedFile (Join-Path $agentsDir "agent-task.agent.md") (Get-AgentTaskMd) $false)
        $writtenFiles += ".github/agents/agent-task.agent.md"
    }

    # ---- Samostatný úkolový prompt pro vložení do chatu (volitelné) ----
    if ($incTaskFile) {
        $promptsDir = Join-Path $githubDir "prompts"
        if (-not (Test-Path $promptsDir)) { New-Item -ItemType Directory -Path $promptsDir | Out-Null }
        $promptSlug = ($projName.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')
        if ([string]::IsNullOrWhiteSpace($promptSlug)) { $promptSlug = "projekt" }
        $promptFm = @(
            '---'
            'mode: agent'
            "description: 'Úkolový prompt pro projekt $projName - role $(Get-RoleName $vals.AppDomain)'"
            '---'
            ''
        ) -join "`n"
        [void](Write-MergedFile (Join-Path $promptsDir "$promptSlug.prompt.md") ($promptFm + (Get-TaskPrompt)) $false)
        $writtenFiles += ".github/prompts/$promptSlug.prompt.md"
    }

    [System.Windows.Forms.MessageBox]::Show(
        "Copilot custom instructions vygenerovány!`n`nSložka: $githubDir`n`nSoubory:`n- $($writtenFiles -join "`n- ")",
        "Architektura Hotova",
        0,
        64
    )
    $form.Close()
})

$form.ShowDialog() | Out-Null
