---
title: "Backend Financiële API & DevSecOps"
description: "High-performance FastAPI-gateway voor het AlphaTracer-systeem met geautomatiseerde DevSecOps-pipelines en continue observability."
date: 2026-09-24
tags: ["FastAPI", "Python", "Docker", "DevSecOps", "PostgreSQL", "Observability", "CI/CD"]
featureimage: "./image.png"
---

**Aangetoonde Vaardigheden:** FastAPI, Python 3.10+, Docker Compose, PostgreSQL, Redis, REST API Architectuur, JWT Authenticatie & Refresh Tokens, Rate Limiting, Geautomatiseerde DevSecOps Pipelines (Bandit SAST & Trivy Container Scanning), Staging Promotie, E2E Testautomatisering, Observability & Container Health Monitoring.

---

## 📸 Bewijs & Technische Validatie (Screenshots)

> **FastAPI Swagger UI & OpenAPI 3.1 Bewijs:** Onderstaande screenshot toont de actieve, lokaal draaiende API-documentatie op `localhost:8011/docs`. Dit verifieert de werking van de authenticatiemodules (OAuth2 password flow, JWT token renewal via `/api/v1/auth/refresh`), beveiligde gebruikersendpoints (`/api/v1/users/me`) en financiële beursdata-integraties.

![AlphaTracer FastAPI Swagger UI Docs](./image.png)

---

## 🏛️ Systeemoverzicht

De **AlphaTracer Financial API** is een asynchrone REST API-gateway van productieniveau die het AlphaTracer-ecosysteem van data voorziet. Het verzorgt realtime marktdatastromen, dynamische portfolioberekeningen, geautomatiseerde transactieverwerking en multi-tenant gebruikersauthenticatie.

{{< mermaid >}}
graph TD
    Client[Client Tier: Android App / Web] -->|TLS / HTTPS| Nginx[Nginx Reverse Proxy & SSL]
    Nginx -->|Reverse Proxy :8011| FastAPI[FastAPI Backend Application]
    FastAPI -->|Caching & Rate Limiting| Redis[(Redis Cache)]
    FastAPI -->|Dynamische SQL / Migraties| Postgres[(PostgreSQL Database)]
    FastAPI -->|Financiële Datastream| YFinance[Yahoo Finance Stream]
    
    subgraph "DevSecOps & Observability Pipeline"
        Bandit[Bandit SAST Scanner] -.-> CI[GitHub Actions CI/CD]
        Trivy[Trivy Container Scanner] -.-> CI
        E2E[E2E Verificatie Suite] -.-> CI
        CI --> Staging[Automatische Staging Promotie]
    end
{{< /mermaid >}}

---

## ✨ Belangrijkste Functionaliteiten

- **Realtime Financiële Engine:** Asynchrone koersdata-ophaling, technische indicatoren en dynamische winst/verliesberekeningen van portfolio's.
- **Robuuste Authenticatie & Beveiliging:** JWT-tokens met veilige refresh token-rotatie, bcrypt wachtwoordhashing en endpoint rate limiting (maximaal 5 pogingen per minuut op authenticatie-endpoints).
- **Geïntegreerde Observability:** Health-check en metrics-endpoints (`/api/v1/health`, `/metrics`) voor containerstatussen, databaseconnectiviteit en responstijden.
- **Enterprise DevSecOps Pipeline:**
  - **Bandit (SAST):** Geautomatiseerde statische code-analyse op beveiligingskwetsbaarheden bij elke pull request.
  - **Trivy (Containerbeveiliging):** Geautomatiseerde vulnerability-scans voor base images en bekende CVE's vóór uitrol.
  - **Geautomatiseerde Staging Promotie:** Automatische tagging en promotie van containerimages van `dev` naar `staging`.
- **Uitgebreide E2E Testsuite (`test_deployment_to_running.sh`):** Geautomatiseerd end-to-end verificatiescript dat de volledige levenscyclus test: container boot, databasemigraties, authenticatie, watchlist CRUD en realtime beursdata-queries.

---

## 🛠️ Tech Stack & Architectuur

| Component | Technologie | Rol |
| :--- | :--- | :--- |
| **Backend Framework** | **FastAPI** (Python 3.10+) | Asynchrone REST-endpoints met Pydantic-validatie |
| **ORM & Database** | **SQLAlchemy** + **PostgreSQL** | Datamodellering en persistente transactie-opslag |
| **Caching & Limiting** | **Redis** | In-memory token blacklisting en rate-limit statusbeheer |
| **Reverse Proxy** | **NGINX** | SSL/TLS-terminatie, HSTS en HTTP security headers |
| **Containerisatie** | **Docker Compose** | Multi-service orkestratie en geïsoleerde netwerken |
| **CI/CD & Security** | **GitHub Actions** | Automatische linting, pytest, Bandit SAST en Trivy scans |

---

## 🔒 Beveiligingsharding

- **HTTP Security Headers:** Afgedwongen `Strict-Transport-Security` (HSTS), `X-Frame-Options: DENY`, `X-Content-Type-Options: nosniff`.
- **Dynamische CORS-Configuratie:** Strikte whitelisting van origins zonder permissieve wildcards.
- **Niet-blokkerende Platform-opstart:** Geoptimaliseerde opstartscripts (`setup-platform.ps1`) met snelle clusterdetectie en fail-safes.

---

## 🚀 Repositories & Bronnen

- [**Bekijk AlphaTracer Financial API op GitHub**](https://github.com/sebian-lab/alphatracer-financial-api)
- [**AlphaTracer Mobile Android Client**](https://github.com/sebian-lab/alphatracer-mobile)
- [**Download CV (PDF)**](/resume.pdf)
