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
$script:tooltip.AutoPopDelay = 20000
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
    @("⌘", "Architektura"), @("</>", "Frontend"), @("▤", "Backend"), @("☁", "DevOps"),
    @("♢", "Bezpečnost"), @("✚", "Funkce"), @("▯", "Mobil"), @("◇", "Moduly"), @("▱", "Slovník")
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
        $control = if ($kind -eq "radio") { New-Object System.Windows.Forms.RadioButton } else { New-Object System.Windows.Forms.CheckBox }
        $control.Text = $item
        $control.Location = New-Object System.Drawing.Point(28, $curY)
        $control.Size = New-Object System.Drawing.Size(($w - 48), 27)
        $control.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
        $control.ForeColor = $script:colors.TextPrimary
        $control.BackColor = $script:colors.Surface
        $control.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
        $control.Cursor = [System.Windows.Forms.Cursors]::Hand
        if ($kind -eq "radio" -and $controls.Count -eq 0) { $control.Checked = $true }
        $script:tooltip.SetToolTip($control, (Get-HelpText $item))
        $card.Controls.Add($control)
        $controls += $control
        $curY += 27
    }
    return $controls
}

Function Add-RadioGroup($parent, $title, $items, $x, $y, $w, $h) {
    return Add-ReferenceCard $parent $title "Vyberte jednu možnost." "○" $items "radio" $x $y $w $h
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

$tab1 = New-ReferencePage "Architektura"
$tab2 = New-ReferencePage "Frontend"
$tab3 = New-ReferencePage "Backend"
$tab4 = New-ReferencePage "DevOps"
$tab5 = New-ReferencePage "Bezpečnost"
$tab6 = New-ReferencePage "Funkce"
$tab7 = New-ReferencePage "Mobil"
$tab8 = New-ReferencePage "Moduly"
$tab9 = New-ReferencePage "Slovník"

$txtProjectName = New-Object System.Windows.Forms.TextBox
$txtProjectName.Text = "EnterpriseProject"
$txtProjectName.Visible = $false
$form.Controls.Add($txtProjectName)

$rArch = Add-RadioGroup $tab1 "Struktura Repozitáře" @("Standardní (jedna aplikace)", "pnpm workspaces + apps/ (monorepo)", "Turborepo (pnpm workspaces)", "Modulární monolit (čisté hranice)") 0 0 440 200
$rFe = Add-RadioGroup $tab1 "Frontend Framework" @("Next.js (App Router)", "React + Vite", "Vue 3 + Vite", "Nuxt 3/4") 460 0 440 200
$cLint = Add-CheckGroup $tab1 "Standardy Kódu" @("ESLint", "Prettier", "Biome", "Striktní TS (no implicit any)", "Knip", "Husky", "Commitlint") 920 0 440 200
$rAuthType = Add-RadioGroup $tab1 "Autentizace" @("NextAuth v5 / Auth.js", "Vlastní JWT + bearer tokeny", "Clerk (hosted)", "Supabase Auth") 0 220 440 200
$rDbStrategy = Add-RadioGroup $tab1 "Databáze" @("Neon (serverless Postgres, vlastní Auth)", "Supabase (kompletní backend: DB + Auth + Storage)", "Vlastní PostgreSQL (VPS)", "PlanetScale (MySQL)") 460 220 440 200
$rDeploy = Add-RadioGroup $tab1 "Nasazení" @("Vercel (BaaS + Edge)", "Netlify", "Docker Container (VPS/AWS)", "AWS ECS / Fargate (Enterprise)") 920 220 440 200

$rRender = Add-RadioGroup $tab2 "Rendering Strategie" @("SSR (Server-Side Rendering)", "SPA (Single Page App)", "SSG (Static Site Generation)", "ISR (Incremental Static Regeneration)") 0 0 440 200
$rCss = Add-RadioGroup $tab2 "Styling" @("Tailwind CSS + Shadcn/UI", "Tailwind CSS (čistý)", "MUI", "CSS Modules + Vanilla Extract") 460 0 440 200
$rI18n = Add-RadioGroup $tab2 "Internacionalizace" @("Bez i18n (jednojazyčná aplikace)", "next-intl (Next.js App Router)", "Vlastní JSON slovník", "Vue I18n / SvelteKit i18n") 920 0 440 200
$rState = Add-RadioGroup $tab2 "State Management" @("Zustand / Pinia", "Redux Toolkit", "Context API", "Bez globálního stavu") 0 220 440 200
$rForms = Add-RadioGroup $tab2 "Formuláře a Validace" @("React Hook Form + Zod", "VeeValidate + Zod", "Server Actions (Nativní)", "Čistý state") 460 220 440 200
$rAnimation = Add-RadioGroup $tab2 "Animace" @("Žádná (minimalistické)", "Framer Motion", "GSAP", "CSS Animations (nativní)") 920 220 440 200
$cFeUi = Add-CheckGroup $tab2 "UI Knihovny" @("Lucide Icons", "Sonner (toast notifikace)", "next-themes (dark mode)", "Recharts (grafy)") 0 440 440 200

$rBe = Add-RadioGroup $tab3 "Backend Jádro" @("Next.js API Routes / Server Actions", "Oddělený Node.js (Express / NestJS)", "Hono", "Python (FastAPI / Django)") 0 0 440 200
$rVercelDb = Add-RadioGroup $tab3 "Integrace DB" @("Nativní integrace Neon (auto ENV inject)", "Supabase Marketplace (one-click)", "Manuální správa ENV", "Nepoužívám Vercel") 460 0 440 200
$rOrm = Add-RadioGroup $tab3 "ORM / Data Layer" @("Prisma", "Drizzle ORM", "Supabase Client", "Raw SQL + prepared statements") 920 0 440 200
$rFetch = Add-RadioGroup $tab3 "Data Fetching" @("TanStack Query", "SWR", "tRPC", "Nativní fetch()") 0 220 440 200
$rRealtime = Add-RadioGroup $tab3 "Real-time komunikace" @("Žádná (REST only)", "WebSockets (Socket.io / nativní)", "Server-Sent Events (SSE)", "Supabase Realtime / Firebase") 460 220 440 200
$rPooling = Add-RadioGroup $tab3 "Connection Pooling" @("Neon serverless driver (HTTP, žádný pool)", "Supabase Supavisor (transaction mode)", "Prisma Accelerate", "Vlastní konfigurace poolu") 920 220 440 200
$rCache = Add-RadioGroup $tab3 "Cache strategie" @("Žádná (fresh data)", "Vercel KV / Upstash Redis", "Next.js unstable_cache / Data Cache", "React Query cache (client-side)") 0 440 440 200
$rApiDesign = Add-RadioGroup $tab3 "API Design" @("REST + OpenAPI spec", "REST + Zod validace", "GraphQL (Cursor Connections)", "tRPC (end-to-end typesafe)") 460 440 440 200

$cTest = Add-CheckGroup $tab4 "Testování" @("Vitest", "Playwright (E2E)", "Jest", "Testing Library (React/Vue)") 0 0 440 200
$cCiCd = Add-CheckGroup $tab4 "CI/CD Pipeline" @("GitHub Actions", "Automatické testy na PR", "Preview deployment (Vercel)", "Databázové migrace v CI") 460 0 440 200
$cVercelFeatures = Add-CheckGroup $tab4 "Vercel konfigurace" @("Preview Deployment na PR", "Edge Functions", "Vercel Blob (soubory)", "Cron Jobs") 920 0 440 200
$rIac = Add-RadioGroup $tab4 "Infrastructure as Code" @("Žádné (manuální správa)", "Terraform", "Pulumi", "Vercel CLI + vercel.json") 0 220 440 200
$cObservability = Add-CheckGroup $tab4 "Observability" @("Vercel Analytics", "Sentry (chyby)", "OpenTelemetry (tracing)", "Grafana / Prometheus (metriky)") 460 220 440 200
$cLog = Add-CheckGroup $tab4 "Logování" @("Pino (JSON logy)", "Winston", "Datadog", "Loki") 920 220 440 200

$cAuth = Add-CheckGroup $tab5 "Autentizace & Role" @("RBAC (Admin/User/Moderator)", "OAuth (Google, GitHub)", "Magic Links (bez hesla)", "2FA / TOTP", "Session management") 0 0 440 230
$cSec = Add-CheckGroup $tab5 "Bezpečnostní moduly" @("T3 Env (Validace .env přes Zod)", "Rate Limiting", "CORS konfigurace", "CSRF ochrana (SameSite)", "Content Security Policy (CSP)") 460 0 440 230
$cCompliance = Add-CheckGroup $tab5 "Compliance" @("GDPR (cookie consent, RLS)", "Audit trail (kdo co změnil)", "Data retention policy", "Backup & disaster recovery", "AI cost tracking") 920 0 440 230

$rCms = Add-RadioGroup $tab6 "Správa obsahu" @("Vlastní DB + Administrace", "Lokální soubory (MDX / Markdown)", "Headless CMS (Sanity / Strapi / Payload)", "Hardcoded (neřešit)") 0 0 440 200
$rCmsEditor = Add-RadioGroup $tab6 "CMS Editor" @("TipTap (headless, vlastní UI)", "Lexical (Meta)", "Slate.js", "Žádný (pouze MDX)") 460 0 440 200
$rAdminShell = Add-RadioGroup $tab6 "Admin Shell" @("Vlastní admin-kit (custom)", "Refine.dev", "React Admin", "Payload CMS (admin v ceně)") 920 0 440 200
$rSeo = Add-RadioGroup $tab6 "SEO" @("Nativní (Next.js metadata / Nuxt useHead)", "Unhead (deduplikace + async aware)", "next-seo / vue-seo", "Ruční správa (vlastní komponenta)") 0 220 440 200
$cAdmin = Add-CheckGroup $tab6 "Administrace" @("Dashboard (Statistiky, grafy)", "Správa uživatelů (Tabulky)", "Audit Log (Historie změn)", "Import/Export dat (CSV/Excel)") 460 220 440 200
$cCore = Add-CheckGroup $tab6 "Byznys Funkce" @("Upload souborů (S3/Supabase/Blob)", "Platby (Stripe)", "E-maily (Resend / Postmark)", "PDF generování", "Notifikace (push/email/SMS)") 920 220 440 230
$cAi = Add-CheckGroup $tab6 "AI Integrace" @("Vercel AI SDK", "OpenAI API", "Anthropic Claude API", "RAG (Vektorová databáze)") 0 440 440 200
$rAbTesting = Add-RadioGroup $tab6 "A/B Testování" @("Žádné", "PostHog (feature flags + experiments)", "GrowthBook (self-hosted)", "Statsig") 460 440 440 200

$rMobile = Add-RadioGroup $tab7 "Mobilní platforma" @("Žádná (pouze web)", "React Native + Expo (SDK 57+)", "React Native (bare, bez Expo)", "Flutter", "PWA (Progressive Web App)") 0 0 440 230
$cMobileFeatures = Add-CheckGroup $tab7 "Mobilní funkce" @("Offline drafty (AsyncStorage)", "SecureStore pro tokeny", "Push notifikace (Expo Notifications)", "Sdílené API s webem", "Biometrické přihlášení") 460 0 440 230
$rMobileDeploy = Add-RadioGroup $tab7 "Distribuce mobilu" @("Expo EAS Build (cloud)", "App Store / Google Play", "Interní distribuce (Firebase App Distribution)") 920 0 440 200
$rMobileNav = Add-RadioGroup $tab7 "Mobilní navigace" @("Expo Router (file-based)", "React Navigation", "Vlastní stack", "Tabs + Stack kombinace") 0 250 440 200
$rMobileUi = Add-RadioGroup $tab7 "Mobilní UI" @("React Native Paper", "NativeBase", "Tamagui", "Vlastní komponenty") 460 250 440 200
$rMobileState = Add-RadioGroup $tab7 "Mobilní state" @("Zustand + TanStack Query", "Redux Toolkit + RTK Query", "Jotai + SWR", "Context + vlastní fetch") 920 250 440 200
$rMobileAuth = Add-RadioGroup $tab7 "Mobilní autentizace" @("Bearer tokeny (vlastní JWT)", "Expo AuthSession (OAuth)", "Supabase Auth (shared)", "Biometrické + PIN") 0 470 440 200

$rAppDomain = Add-RadioGroup $tab8 "Primární doména" @("Obecná / Univerzální", "E-shop / E-commerce", "Rezervační systém (salon, lékař, restaurace)", "SaaS platforma", "CRM / Interní nástroj") 0 0 440 230
$cEcommerce = Add-CheckGroup $tab8 "E-shop moduly" @("Product catalog (varianty, SKU)", "Košík + checkout flow", "Platební brána (Stripe / GoPay)", "Doprava (Packeta / DPD / PPL)", "Skladové hospodářství") 460 0 440 230
$cBooking = Add-CheckGroup $tab8 "Rezervační moduly" @("Kalendář s časovými sloty", "Správa zaměstnanců / specialistů", "Rezervace + platba (deposit)", "Přesuny a storna", "SMS / Email reminder") 920 0 440 230
$cSaas = Add-CheckGroup $tab8 "SaaS moduly" @("Multi-tenant architektura", "Subscription billing (Stripe Billing)", "Plány + feature gating", "Team / organizace", "RBAC per tenant") 0 250 440 230
$cLms = Add-CheckGroup $tab8 "LMS / Vzdělávání" @("Kurzy + lekce", "Video streaming (Mux / Cloudflare)", "Kvízy a testy", "Certifikáty (PDF generování)") 460 250 440 200
$cCrm = Add-CheckGroup $tab8 "CRM / Interní nástroje" @("Kontakty + firmy", "Pipeline / deals", "Úkoly a aktivity", "Reporty a dashboardy") 920 250 440 200
$cIntegrations = Add-CheckGroup $tab8 "Integrace třetích stran" @("Platby: Stripe", "Platby: GoPay", "Doprava: Packeta / Zásilkovna", "Fakturace: Fakturoid", "Email: Resend / Postmark") 0 500 440 230
$cMarketing = Add-CheckGroup $tab8 "Marketing & Growth" @("Newsletter", "Blog s MDX", "Landing pages builder", "Referral systém", "Sitemap + robots.txt") 460 500 440 230
$cLegal = Add-CheckGroup $tab8 "Právní & Compliance" @("GDPR (souhlasy, výmaz)", "Obchodní podmínky", "Cookies consent (Cookiebot)", "14 dní na vrácení (spotřebitel)") 920 500 440 200

$dictLabel = New-Object System.Windows.Forms.Label
$dictLabel.Text = "Slovník nápovědy`n`nNajeďte kurzorem na volbu v ostatních záložkách. Zobrazí se krátké vysvětlení a doporučení."
$dictLabel.Location = New-Object System.Drawing.Point(40, 40)
$dictLabel.Size = New-Object System.Drawing.Size(700, 100)
$dictLabel.Font = New-Object System.Drawing.Font("Segoe UI", 12)
$dictLabel.ForeColor = $script:colors.TextSecondary
$tab9.Controls.Add($dictLabel)
$tabControl.Add_SelectedIndexChanged({
    $tabControl.SelectedTab.AutoScrollPosition = New-Object System.Drawing.Point(0, 0)
    Update-Navigation
})
$tab1.AutoScrollPosition = New-Object System.Drawing.Point(0, 0)
$tabControl.SelectedIndex = 0
Update-Navigation

# ==========================================
# LOGIKA GENEROVÁNÍ
# ==========================================
$btnOk.Add_Click({
    $projName = $txtProjectName.Text
    if ([string]::IsNullOrWhiteSpace($projName)) { $projName = "EnterpriseProject" }

    Function Get-Radio($group) { 
        $sel = $group | Where-Object { $_.Checked }
        if ($sel) { return $sel.Text }
        return "Nespecifikováno"
    }
    Function Get-List($controls) {
        $arr = @()
        foreach ($c in $controls) { if ($c.Checked) { $arr += "- $($c.Text)" } }
        if ($arr.Count -eq 0) { return "*(Není vyžadováno)*" }
        return $arr -join "`n"
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
    }

    # --- Podmíněné sekce ---
    $neonSection = ""
    if ($vals.DbStrategy -match "Neon") {
        $neonSection = @"

### Neon konfigurace (serverless Postgres)
- Používej **@neondatabase/serverless** driver v HTTP režimu (žádný connection pool)
- V serverless funkcích používej `neon()` z `@neondatabase/serverless`
- Databázové větve (branches) se vytvářejí automaticky pro každý Preview Deployment
- Pro migrace použij `drizzle-kit` nebo `prisma migrate` s přímým (ne-pooled) připojením
- V produkci použij pooled connection string (`-pooler` sufix)
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
- **Sdílené typy:** Vytvoř `packages/shared-types/` s TypeScript typy sdílenými mezi webem a mobilem
- **API klient:** Sdílený API klient s automatickým refresh token flow
- **Offline-first:** Drafty a kritická data ukládej do AsyncStorage, synchronizuj při připojení
- **Bezpečnost:** Tokeny VŽDY v SecureStore (nikdy AsyncStorage)
- **Build:** `eas build --platform android --profile preview` pro testovací APK
"@
    }
    
    $tipTapSection = ""
    if ($vals.CmsEditor -match "TipTap") {
        $tipTapSection = @"

### TipTap editor konfigurace
- Použij **@tiptap/react** + **@tiptap/starter-kit** jako základ
- Pro uložení používej **JSON formát** (ne HTML)
- Vlastní extensiony: vytvoř `extensions/` složku pro vlastní node/mark typy
- Renderuj obsah bezpečně pomocí **generateHTML()** z `@tiptap/html` na serveru
- **Nikdy nepoužívej dangerouslySetInnerHTML** bez předchozí sanitizace
"@
    }
    
    $vercelSection = ""
    if ($vals.Deploy -match "Vercel") {
        $vercelSection = @"

### Vercel konfigurace
- Používej `vercel.json` pro rewrite rules a environment-specific nastavení
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
- Ceny VŽDY v minor units (haléře) jako `integer`, nikdy `float`
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
- Multi-tenancy: každý záznam má `tenant_id`
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
- **14 dní na vrácení:** stav objednávky `RETURN_REQUESTED`
- **Reklamace:** zákonná lhůta 30 dní
- **DPH:** kalkulace vč. reverse charge pro EU B2B
- **Obchodní podmínky:** verzované
"@
    }

    $desktop = [System.Environment]::GetFolderPath("Desktop")
    $outputDir = Join-Path $desktop "CopilotContext_$($projName -replace ' ', '_')"
    if (-not (Test-Path $outputDir)) { New-Item -ItemType Directory -Path $outputDir | Out-Null }

    # ---- 1. Instrukce.md ----
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

2. **Type Safety & Zod:** Typový systém je absolutně striktní. Žádné `any`.

3. **Zabezpečený Backend & Práva:** Zero-trust model. Oprávnění (RBAC) ověřuj na úrovni serveru.

4. **Error Handling & Observability:** Nikdy nepolykej chyby. Zabal do `try/catch`, zaloguj, bezpečně vrať chybový stav.

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
* Sanitizace HTML přes `isomorphic-dompurify`.
* Pro **$($vals.Seo)** připraví dynamické hlavičky.
* Využívá pokročilé funkce **$($vals.Fe)**.
* i18n (**$($vals.I18n)**): typované překladové klíče.

## Infrastructure as Code & DevOps
* Vygeneruje konfigurační soubory pro **$($vals.Deploy)**.
* Nastaví `tsconfig.json` se striktním režimem.
* CI/CD pipeline (**$($lists.CiCd)**).

## Mobilní aplikace (pokud aktivní)
* Sdílené typy v `packages/shared/`.
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
- Driver: `@neondatabase/serverless` v HTTP režimu
- Preview branches automaticky pro každý PR
- Migrace: `drizzle-kit push` nebo `prisma migrate deploy`
- Production: pooled URL s `-pooler` sufixem

### Supabase
- Connection: **Supavisor** transaction mode
- Direct connection POUZE pro migrace
- RLS: povinné pro všechny tabulky
- Auth: `@supabase/ssr` pro Next.js

### Dual-stack
- Preview: Neon branches
- Produkce: Supabase
- **Nikdy nesynchronizuj data mezi Neon a Supabase**

## Zakázané vzory
- ❌ Přímé `new Pool()` v serverless funkci
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
| E-shop platby | `stripe` | Platební brána |
| E-shop platby CZ | `gopay-sdk` | CZ platební brána |
| Doprava CZ | `packeta-api` | Integrace Packeta |
| Fakturace | `fakturoid-client` | Fakturace CZ |
| Email | `resend` | Transakční e-maily |
| SMS | `twilio` | SMS notifikace |
| Rezervace | `date-fns-tz` | Timezone handling |
| Rezervace | `rrule` | Opakované události |
| SaaS billing | `@stripe/stripe-js` | Client-side checkout |
| SaaS multi-tenant | `@supabase/ssr` | RLS + tenant isolation |
| LMS video | `@mux/mux-node` | Video streaming |
| CRM pipeline | `@dnd-kit/core` | Drag & drop deals |
| Marketing | `@react-email/components` | Email šablony |
| Compliance | `cookiebot` | GDPR cookies |
"@

    $utf8 = New-Object System.Text.UTF8Encoding $true
    [System.IO.File]::WriteAllText("$outputDir\Instrukce.md", $instrukce, $utf8)
    [System.IO.File]::WriteAllText("$outputDir\vlastnostiagenta.md", $persona, $utf8)
    [System.IO.File]::WriteAllText("$outputDir\schopnosti.md", $skills, $utf8)
    [System.IO.File]::WriteAllText("$outputDir\databaze.md", $dbDoc, $utf8)
    [System.IO.File]::WriteAllText("$outputDir\specializace.md", $specializationDoc, $utf8)

    [System.Windows.Forms.MessageBox]::Show(
        "Master Enterprise Kontext vygenerován!`n`nSložka: $outputDir`n`nSoubory:`n- Instrukce.md`n- vlastnostiagenta.md`n- schopnosti.md`n- databaze.md`n- specializace.md",
        "Architektura Hotova",
        0,
        64
    )
    $form.Close()
})

$form.ShowDialog() | Out-Null