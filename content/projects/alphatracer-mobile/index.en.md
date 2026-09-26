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

---

## 📋 Executive Summary (Management & Recruiter Overview)

<div style="background:#0d1117; border:1px solid #30363d; border-radius:10px; padding:20px; margin-bottom:24px;">
  <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(240px, 1fr)); gap:16px;">
    <div>
      <h4 style="color:#58a6ff; margin:0 0 8px 0; font-size:15px;">🎯 Business Challenge (The Problem)</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        Retail investors and portfolio managers miss critical market opportunities due to fragmented data sources and clunky mobile experiences. How to design a secure, high-framerate mobile app combining real-time financial tracking with autonomous background price drop alerts?
      </p>
    </div>
    <div>
      <h4 style="color:#3fb950; margin:0 0 8px 0; font-size:15px;">👤 My Role & Engineering Ownership</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        Full-lifecycle native Android development: created the Jetpack Compose user interface, established a robust MVVM pattern using reactive ViewModels and StateFlows, integrated hardware biometric security, and scheduled battery-efficient background evaluations via Android WorkManager.
      </p>
    </div>
    <div>
      <h4 style="color:#a855f7; margin:0 0 8px 0; font-size:15px;">📈 Business Impact & Measurable Outcome</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        A silky 60 FPS native experience, zero-interruption session persistence via automated background JWT token refresh, reliable 15-minute scheduled price evaluations, and protection against reverse engineering via ProGuard bytecode obfuscation.
      </p>
    </div>
  </div>
</div>

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

## 🛠️ Software Engineering, Architecture & Code Quality

This project demonstrates modern software engineering lifecycle standards: from MVVM architectural segregation and API-contract testing to enterprise-level hardening (non-root transport, biometric cryptography, and automated CI via GitHub Actions).

- **Strict MVVM Segregation:** Clean boundary between the reactive Jetpack Compose UI composables and business logic encapsulated within StateFlow-driven ViewModels for optimal testability and maintainability.
- **Secure Network Interceptor & Session Lifecycle:** A custom `AuthInterceptor` gracefully catches 401 Unauthorized responses, executes asynchronous JWT refresh token rotation, and retries original requests transparently without degrading user experience.
- **Reliable Background Execution:** Powered by Android `WorkManager` for idempotent, battery-conscious evaluation runs (PeriodicWorkRequest every 15 minutes) respecting OS-level constraints.
- **ProGuard Code Obfuscation & CI Pipeline:** Automated GitHub Actions workflows executing continuous linting, unit tests, and release compilation with ProGuard bytecode obfuscation to protect API contracts and sensitive client-side logic.

---

## 🚀 Getting Started

**Requirements:** Android Studio Ladybug (2024.2.1+), JDK 17, Android SDK API 26+.

1. Clone the repository: `git clone https://github.com/sebian-lab/AlphaTracer.git`
2. Sync Gradle in Android Studio.
3. *Note:* The backend base URL is hardcoded in `RetrofitClient.BASE_URL`. Change this if hosting your own backend instance.
4. Build and run on an emulator or physical Android device (Biometric hardware/emulation required).
