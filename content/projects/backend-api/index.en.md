---
title: "Backend Financial API & Cloud Platform"
description: "High-performance FastAPI gateway for the AlphaTracer system with automated CI/CD pipelines, full-stack observability, and Kubernetes orchestration."
date: 2026-09-24
tags: ["FastAPI", "Python", "Docker", "Kubernetes", "PostgreSQL", "Observability", "CI/CD", "Prometheus", "Grafana"]
featureimage: "./feature.png"
---

**Skills Demonstrated:** FastAPI, Python 3.10+, Docker Compose, Kubernetes (K3s), PostgreSQL, Redis, REST API Architecture, JWT Authentication & Refresh Tokens, Rate Limiting, Automated CI/CD Pipelines (Bandit SAST & Trivy Container Scanning), HashiCorp Vault Secrets Management, Full Observability (Prometheus, Grafana, Alertmanager, Jaeger, Loki), Staging Promotion, E2E Test Automation.

---

## 🏛️ System Overview

The **AlphaTracer Financial API** is a production-grade, asynchronous REST API gateway that powers the AlphaTracer stock tracking and portfolio management ecosystem. It provides real-time market data ingestion, dynamic portfolio calculations, automated transaction processing, and multi-tenant user authentication.

{{< mermaid >}}
graph TD
    Client["Client Tier: Android App / Web"] -->|"TLS / HTTPS"| Nginx["Nginx Reverse Proxy & SSL"]
    Nginx -->|"Reverse Proxy :8011"| FastAPI["FastAPI Backend Application"]
    FastAPI -->|"Caching & Rate Limiting"| Redis[("Redis Cache")]
    FastAPI -->|"Dynamic SQL / Migrations"| Postgres[("PostgreSQL Database")]
    FastAPI -->|"Financial Data Stream"| YFinance["Yahoo Finance Stream"]
    
    subgraph Pipeline ["Automation & Observability Pipeline"]
        Bandit["Bandit SAST Scanner"] -.-> CI["GitHub Actions CI/CD"]
        Trivy["Trivy Container Scanner"] -.-> CI
        E2E["E2E Verification Suite"] -.-> CI
        CI --> Staging["Automated Staging Promotion"]
    end
{{< /mermaid >}}

---

## ✨ Key Features & Capabilities

- **Real-Time Financial Engine:** Asynchronous stock price retrieval, technical indicators, and dynamic portfolio profit/loss computations.
- **Robust Authentication & Security:** JWT tokens with secure refresh token rotation, bcrypt password hashing, and endpoint rate limiting (5 attempts/min on auth endpoints).
- **Integrated Observability & Tracing:** Health-check and metrics endpoints (`/api/v1/health`, `/metrics`), Prometheus scraping, Grafana dashboards, Jaeger distributed tracing, and Loki log streaming.
- **Automated CI/CD Pipeline:**
  - **Bandit (SAST):** Automated static code analysis for security vulnerabilities on every pull request.
  - **Trivy (Container Security):** Automated vulnerability scanning for base image packages and CVEs before deployment.
  - **Automated Staging Promotion:** Automated container image tagging and promotion from `dev` to `staging` environments.
- **Comprehensive E2E Test Suite (`test_deployment_to_running.sh`):** Automated end-to-end verification script testing the entire lifecycle: container boot, database migrations, authentication, watchlist CRUD, and market data queries.

---

## 🛠️ Tech Stack & Architecture

| Component | Technology | Role |
| :--- | :--- | :--- |
| **Backend Framework** | **FastAPI** (Python 3.10+) | High-throughput async REST endpoints with Pydantic validation |
| **ORM & Database** | **SQLAlchemy** + **PostgreSQL** | Dynamic portfolio and transaction modeling with persistence |
| **Caching & Limiting** | **Redis** | In-memory token blacklisting and rate-limit state |
| **Observability & Tracing** | **Prometheus + Grafana + Jaeger + Loki** | Complete telemetry, tracing, and centralized streaming log aggregation |
| **Secrets Management** | **HashiCorp Vault** | Centralized encrypted secret and credential storage |
| **Container Orchestration** | **K3s + Docker Compose** | Multi-service orchestration, pod lifecycle, and isolated networking |
| **CI/CD & Security** | **GitHub Actions + Trivy** | Automated linting, pytest, Bandit SAST, and vulnerability scanning |

---

## 🔒 Security Hardening

- **HTTP Security Headers:** Enforced `Strict-Transport-Security` (HSTS), `X-Frame-Options: DENY`, `X-Content-Type-Options: nosniff`.
- **Dynamic CORS Configuration:** Stricter origin whitelisting avoiding permissive wildcard defaults.
- **Non-blocking Platform Boot:** Optimized platform startup scripts (`setup-platform.ps1`) with fast cluster detection and fail-safes.

---

## 📸 Technical Proof & System Validation (Screenshots)

The screenshots below highlight the active, locally running microservice architecture, observability stack, container security, and Kubernetes orchestration:

### 1. API Gateway & OpenAPI Documentation
> **FastAPI Swagger UI & OpenAPI 3.1:** Active API documentation running locally at `localhost:8011/docs`. Verifies the authentication modules (OAuth2 password flow, JWT token renewal via `/api/v1/auth/refresh`), secured user endpoints (`/api/v1/users/me`), and market data integrations.

![FastAPI Swagger UI Documentation](./01_fastapi_swagger.png)

---

### 2. Observability & Telemetry (Grafana, Prometheus & Alertmanager)
> **Grafana Telemetry Dashboard:** Real-time observability dashboard in Grafana visualizing live HTTP response times, throughput per endpoint, and error rates, fed by Prometheus metric scrapes across all active services.

![Grafana Observability Dashboard](./02_grafana_ui.png)

> **Prometheus Query Visualisation & Scrape Targets:** PromQL query analysis of API traffic alongside healthy 'UP' statuses across all microservice scrape targets.

{{< gallery >}}
  <img src="./03_prometheus_graph.png" class="grid-w50" />
  <img src="./03_prometheus_targets.png" class="grid-w50" />
{{< /gallery >}}

> **Alertmanager Notification Management:** Active configuration for automated incident routing and alerts triggered by container degradation or latency threshold breaches.

![Alertmanager UI](./04_alertmanager_ui.png)

---

### 3. Distributed Tracing & Centralized Logging (Jaeger & Loki)
> **Jaeger Distributed Tracing:** End-to-end trace analysis across microservice calls, database query timings, and market data queries to diagnose latency and bottlenecks.

![Jaeger Distributed Tracing](./05_jaeger_tracing.png)

> **Grafana Loki Log Aggregation:** Live readiness verification (`ready`) of the central streaming log aggregator indexing logs from all containers in real time.

![Grafana Loki Status](./09_loki_ready.png)

---

### 4. Security, Secrets & Container Registry (Vault, Trivy & Private Registry)
> **HashiCorp Vault Secrets Engine:** Centralized, encrypted management of database credentials, JWT secrets, and API tokens with strict role-based access.

![HashiCorp Vault UI](./06_vault_ui.png)

> **Private Docker Registry & Trivy Container Scanning:** Locally hosted private container registry (`localhost:5000`) for safe image storage, paired with an active Trivy server continuously scanning images for known vulnerabilities (CVEs).

{{< gallery >}}
  <img src="./07_local_registry.png" class="grid-w50" />
  <img src="./08_trivy_server.png" class="grid-w50" />
{{< /gallery >}}

---

### 5. Kubernetes Container Orchestration (K3s Cluster)
> **K3s Kubernetes Cluster:** Fully operational lightweight Kubernetes cluster managing Pods, Services, Deployments, and ConfigMaps for scalable container orchestration.

![K3s Kubernetes Cluster Status](./10_k3s_cluster.png)

---

## 🚀 Repositories & Resources

- [**View AlphaTracer Financial API on GitHub**](https://github.com/sebian-lab/alphatracer-financial-api)
- [**AlphaTracer Mobile Android Client**](https://github.com/sebian-lab/alphatracer-mobile)
- [**Download CV / Resume (PDF)**](/resume.pdf)
