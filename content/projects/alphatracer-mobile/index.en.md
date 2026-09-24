---
title: "AlphaTracer Mobile"
description: "A smart stock portfolio and price alerting application built natively for Android with Jetpack Compose."
date: 2026-05-30
tags: ["Android", "Kotlin", "Jetpack Compose"]
featureimage: "./feature.png"
imageContain: true
---

AlphaTracer is an intelligent native Android application for stock portfolio management and automated price drop alerts.

**Skills Demonstrated:** Android SDK, Kotlin, Jetpack Compose, MVVM Architecture, Retrofit + OkHttp, Android WorkManager, Biometrics API, ProGuard Obfuscation, GitHub Actions CI.

> *"AlphaTracer provides real-time market insights, intelligent portfolio management, and customizable price alerts. Whether you're a beginner or an experienced investor, you won't miss a single market movement."*

---

## 📸 Interface Showcase

{{< gallery >}}
  <img src="/images/alphatracer_0.png" class="grid-w33" />
  <img src="/images/alphatracer_1.png" class="grid-w33" />
  <img src="/images/alphatracer_2.png" class="grid-w33" />
  <img src="/images/alphatracer_3.png" class="grid-w33" />
{{< /gallery >}}

---

## ✨ Key Features

- **Live Market Data** – Search for any stock and view detailed financial figures, technical analysis, and trading signals.
- **Portfolio Management** – Add buy and sell transactions, view total value, profit/loss percentages, and track performance in real time.
- **Smart Alerts** – Receive push notifications when a stock drops by a specific percentage over a sliding window (e.g., the last 3 days). Set alerts individually or in bulk.
- **Secure & Convenient** – Biometric login (fingerprint/face) keeps your data safe. Your session remains active thanks to automatic JWT token renewal.
- **Modern, Fluid Interface** – Built entirely with **Jetpack Compose**, featuring a dark theme and interactive charts.

---

## 🏛️ System Architecture

AlphaTracer is split into a native Android frontend and a high-performance FastAPI backend.

### 1. Overall System Topology

{{< mermaid >}}
graph TD
    Client["📱 Android Client<br><b>Jetpack Compose & Kotlin MVVM</b>"]
    Gateway["🛡️ API Gateway<br><b>Nginx Reverse Proxy & TLS</b>"]
    Backend["⚡ Application Tier<br><b>FastAPI Backend (Python)</b>"]
    DB[("💾 Data Tier<br><b>PostgreSQL Database</b>")]
    Finance["🌐 External Integration<br><b>Yahoo Finance API</b>"]

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

### 2. Android App Architecture (MVVM)

The Android frontend follows the strict **MVVM (Model-View-ViewModel)** pattern with a clear separation of responsibilities:

| Layer | Components & Responsibility |
|---|---|
| **UI (Composables)** | `AuthScreen`, `PortfolioUi`, `StockDetailScreen`, `AlertListView` – fully reusable components. |
| **State (ViewModels)** | `MainViewModel` (global navigation/login), `PortfolioViewModel`, `StockDetailViewModel`. |
| **Network (API)** | Retrofit + OkHttp. An `AuthInterceptor` gracefully catches 401 errors, refreshes the JWT, and retries. |
| **Background (Worker)** | `WorkManager` schedules an idempotent `AlertWorker` every 15 minutes to evaluate sliding-window price drops. |

---

## 💾 Backend Data Structure

*Note: Portfolio holdings are calculated dynamically from the `Transaction` table (sum of buys minus sells) rather than stored persistently.*

{{< mermaid >}}
erDiagram
    USER ||--o{ PORTFOLIO : "has"
    PORTFOLIO ||--o{ TRANSACTION : "contains"
    USER ||--o{ ALERT_RULE : "configures"

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

## 🤖 AI Integration & Methodology

This project embraced a **"human-in-the-loop"** AI development methodology. AI acted as an accelerator, but full architectural control remained manual.

- **No AI-generated Frontend:** While AI helped with boilerplate (data classes), the entire Jetpack Compose architecture (UI code, navigation, themes) was hand-written from scratch.
- **No "Vibe Coding":** Every AI suggestion was critically evaluated, tested, and refined. No blind copy-pasting was permitted.
- **Backend Evolution & Security Hardening:** The initial FastAPI backend was generated via OpenHands and hosted through a Cloudflare Tunnel. Subsequently, this architecture was thoroughly hardened, secured, and expanded by myself in preparation for my internship: implementing automated security pipelines (Bandit SAST, Trivy container scanning), HashiCorp Vault secrets management, full observability (Prometheus, Grafana, Alertmanager, Jaeger tracing, Loki), and K3s Kubernetes orchestration.
- **Code Review (Gemini & DeepSeek):** Used to resolve complex logic (e.g., AuthInterceptor state exceptions) and identify missing state collections.

---

## 🚀 Getting Started

**Requirements:** Android Studio Ladybug (2024.2.1+), JDK 17, Android SDK API 26+.

1. Clone the repository: `git clone https://github.com/sebian-lab/AlphaTracer.git`
2. Sync Gradle in Android Studio.
3. *Note:* The backend base URL is hardcoded in `RetrofitClient.BASE_URL`. Change this if hosting your own backend instance.
4. Build and run on an emulator or physical Android device (Biometric hardware/emulation required).
