---
title: "AlphaTracer Mobile"
description: "Een intelligente Android-applicatie voor beursportfoliobeheer en realtime koersnotificaties, native gebouwd met Jetpack Compose."
date: 2026-05-30
tags: ["Android", "Kotlin", "Jetpack Compose"]
featureimage: "./feature.png"
imageContain: true
---

AlphaTracer is een intelligente, native Android-applicatie voor het beheren van aandelenportfolio's en het ontvangen van geautomatiseerde koersnotificaties.

**Aangetoonde Vaardigheden:** Android SDK, Kotlin, Jetpack Compose, MVVM-Architectuur, Retrofit + OkHttp, Android WorkManager, Biometrics API, ProGuard Obfuscation, GitHub Actions CI.

> *"AlphaTracer biedt realtime marktinzichten, intelligent portfoliobeheer en instelbare koerswaarschuwingen. Zowel voor beginnende als ervaren beleggers zorgt het voor een direct overzicht over marktbewegingen."*

---

## 📸 Interface Showcase

{{< gallery >}}
  <img src="/images/alphatracer_0.png" class="grid-w33" />
  <img src="/images/alphatracer_1.png" class="grid-w33" />
  <img src="/images/alphatracer_2.png" class="grid-w33" />
  <img src="/images/alphatracer_3.png" class="grid-w33" />
{{< /gallery >}}

---

## ✨ Belangrijkste Functionaliteiten

- **Live Marktdata** – Zoek aandelen op en bekijk gedetailleerde financiële kerncijfers, technische analyses en handelssignalen.
- **Portfoliobeheer** – Registreer koop- en verkooptransacties, bekijk de totale portefeuillewaarde, winst/verlies-percentages en volg prestaties in realtime.
- **Slimme Koersnotificaties** – Ontvang pushmeldingen wanneer een aandeel over een glijdend tijdsvenster (bijv. de afgelopen 3 dagen) met een ingesteld percentage daalt. Notificaties zijn individueel of in bulk in te stellen.
- **Veilig & Toegankelijk** – Biometrische login (vingerafdruk / gezichtsherkenning) beveiligt gevoelige financiële gegevens. Sessies blijven naadloos behouden via automatische JWT-tokenvernieuwing.
- **Moderne, Vloeiende UI** – Volledig gebouwd met **Jetpack Compose**, inclusief dark mode en interactieve grafieken.

---

## 🏛️ Systeemarchitectuur

AlphaTracer is opgesplitst in een native Android-frontend en een high-performance FastAPI-backend.

### 1. Algemene Systeemtopologie

{{< mermaid >}}
graph TD
    Client["📱 Android Client<br><b>Jetpack Compose & Kotlin MVVM</b>"]
    Gateway["🛡️ API Gateway<br><b>Nginx Reverse Proxy & TLS</b>"]
    Backend["⚡ Application Tier<br><b>FastAPI Backend (Python)</b>"]
    DB[("💾 Data Tier<br><b>PostgreSQL Database</b>")]
    Finance["🌐 Externe Integratie<br><b>Yahoo Finance API</b>"]

    Client -->|"HTTPS / TLS"| Gateway
    Gateway -->|"HTTP"| Backend
    Backend -->|"SQL Queries"| DB
    Backend -->|"yfinance Stream"| Finance

    style Client fill:#1e3a8a,stroke:#3b82f6,stroke-width:2px,color:#fff
    style Gateway fill:#1e293b,stroke:#475569,stroke-width:1px,color:#fff
    style Backend fill:#047857,stroke:#10b981,stroke-width:2px,color:#fff
    style DB fill:#1e293b,stroke:#64748b,stroke-width:1px,color:#fff
    style Finance fill:#581c87,stroke:#a855f7,stroke-width:1px,color:#fff
{{< /mermaid >}}

### 2. Android App-Architectuur (MVVM)

De Android-frontend volgt het **MVVM (Model-View-ViewModel)** ontwerppatroon met een strikte scheiding van verantwoordelijkheden:

| Laag | Componenten & Verantwoordelijkheid |
|---|---|
| **UI (Composables)** | `AuthScreen`, `PortfolioUi`, `StockDetailScreen`, `AlertListView` – herbruikbare en reactieve componenten. |
| **State (ViewModels)** | `MainViewModel` (algemene navigatie en auth-state), `PortfolioViewModel`, `StockDetailViewModel`. |
| **Network (API)** | Retrofit + OkHttp. Een `AuthInterceptor` vangt 401 Unauthorized-fouten op, vernieuwt het JWT-token op de achtergrond en voert het verzoek opnieuw uit. |
| **Background (Worker)** | `WorkManager` plant elke 15 minuten een idempotente `AlertWorker` in om glijdende koersdalingen te evalueren en notificaties te triggeren. |

---

## 💾 Backend Datastructuur

*Opmerking: Portfolioholdings worden dynamisch berekend vanuit de `Transaction`-tabel (som van aankopen minus verkopen) in plaats van statisch opgeslagen.*

{{< mermaid >}}
erDiagram
    USER ||--o{ PORTFOLIO : "heeft"
    PORTFOLIO ||--o{ TRANSACTION : "bevat"
    USER ||--o{ ALERT_RULE : "configureert"

    USER {
        string id PK
        string email
        string access_token
    }
    PORTFOLIO {
        string id PK
        string user_id FK
    }
    TRANSACTION {
        string id PK
        string portfolio_id FK
        string ticker
        int quantity
    }
    ALERT_RULE {
        string id PK
        string ticker
        int rolling_days
        float threshold_percent
    }
    STOCK_DATA {
        string ticker PK
        json metrics
        array candles
    }
{{< /mermaid >}}

---

## 🤖 AI-Integratie & Methodologie

Bij dit project is een **"human-in-the-loop"** methodologie gehanteerd. AI fungeerde als versneller, terwijl de architecturale controle te allen tijde handmatig bleef.

- **Geen AI-gegenereerde frontend:** Hoewel AI hielp bij boilerplate (zoals data classes), werd de volledige Jetpack Compose-architectuur (UI-code, navigatie, thema's) handmatig geschreven.
- **Geen "Vibe Coding":** Elk voorstel van AI werd kritisch getoetst, getest en geoptimaliseerd.
- **Backend Evolutie & Beveiligingsharding:** De initiële FastAPI-backend werd gegenereerd via OpenHands en gehost via een Cloudflare Tunnel. Vervolgens is deze architectuur door mijzelf volledig handmatig gehardened en uitgebouwd ter voorbereiding op mijn stage: implementatie van geautomatiseerde beveiligingspipelines (Bandit SAST, Trivy vulnerability scanning), HashiCorp Vault secrets management, volledige observability (Prometheus, Grafana, Alertmanager, Jaeger tracing, Loki) en K3s Kubernetes-orkestratie.
- **Code Review (Gemini & DeepSeek):** Ingezet voor het oplossen van complexe randgevallen (zoals concurrency en state management in de AuthInterceptor).

---

## 🚀 Aan de Slag

**Vereisten:** Android Studio Ladybug (2024.2.1+), JDK 17, Android SDK API 26+.

1. Kloon de repository: `git clone https://github.com/sebian-lab/AlphaTracer.git`
2. Synchroniseer Gradle in Android Studio.
3. *Opmerking:* De base URL van de backend is geconfigureerd in `RetrofitClient.BASE_URL`. Pas deze aan bij een eigen backend-instantie.
4. Bouw en draai de app op een emulator of fysiek Android-toestel (met biometrische hardware/emulatie).
