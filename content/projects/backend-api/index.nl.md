---
title: "Backend Financiële API & Observability Stack"
description: "FastAPI REST API op een 10-container Docker Compose setup met complete observability (Prometheus pull via custom ASGI-middleware, Jaeger OTel push, Loki log streaming) en DevSecOps pipelines."
date: 2026-09-24
tags: ["FastAPI", "Python", "Docker", "Docker Compose", "PostgreSQL", "Observability", "Prometheus", "Grafana", "Jaeger", "Loki", "Vault"]
featureimage: "./feature.png"
---

**Toegepaste Vaardigheden:** FastAPI, Python 3.10+, Docker Compose (Dual Dev/Prod opzet), PostgreSQL, REST API Architectuur, In-Memory Caching & Limiting, JWT Authenticatie & Refresh Tokens, DevSecOps (Bandit SAST, Trivy Container Scanning, Gitleaks, Sigstore Cosign), HashiCorp Vault, Enterprise Observability (Custom ASGI Prometheus Metrics, Jaeger OTel Spans, Loki Direct Logging Handler, Grafana Dashboards, Alertmanager Webhooks), E2E Testautomatisering (Bash).

---

## 📌 Over dit project

Als student **Toegepaste Informatica** aan Odisee Brussel wilde ik met **AlphaTracer** verder kijken dan een standaard CRUD-applicatie. Mijn doel was om praktisch te leren hoe moderne backend-engineering, telemetrie en container-beveiliging onder de motorkap samenwerken.

In plaats van alleen een API te bouwen, heb ik een complete lokale microservice-omgeving neergezet. Hierin verwerkt FastAPI realtime beursdata, terwijl een observability-stack (Prometheus, Jaeger, Loki, Grafana) elke request, runtime metrics en logregel realtime traceert.

---

## ⚖️ Waarom Docker Compose en de rol van Kubernetes?

Een belangrijk inzicht tijdens dit project was het maken van realistische architectuurkeuzes:

### 1. Runtime executie via Docker Compose (10 microservices)
Om de complete stack soepel op een lokaal werkstation te draaien zonder dure cloudfacturen of zware geneste virtualisatie, draait het platform als een **10-container Docker Compose appliance**.
* **Snelle iteratie:** `docker-compose.yml` mount `./app` lokaal voor hot-reloading en start binnen enkele seconden op voor development.
* **Productie-opzet:** `docker-compose.prod.yml` draait een geharde stack op basis van geverifieerde GHCR-containerimages (waar de FastAPI-applicatie via `USER appuser` in de Dockerfile als non-root draait) met een volledig geïntegreerde monitoring- en observability-stack (Prometheus, Grafana, Alertmanager, Jaeger en Loki).

### 2. De rol van Kubernetes (Toekomstig Cloud-Native Migratieconcept)
Ik draai bewust geen zwaar Kubernetes cluster 24/7 lokaal. Het platform is ontworpen als een complete, zelfstandige Docker Compose stack.
* In een toekomstige enterprise cloud-migratiestap (volledig uit eigen initiatief en nieuwsgierigheid onderzocht) kan deze stack geëvolueerd worden naar een Kubernetes cluster: met StatefulSets voor persistente PostgreSQL-opslag, de External Secrets Operator om HashiCorp Vault credentials te koppelen, en geautomatiseerde GitOps synchronisatie via ArgoCD.

---

## 🏛️ Systeemarchitectuur

{{< mermaid >}}
graph TD
    Client["Client: Android App / Web / Curl"] -->|"HTTP / Direct Port :8011"| FastAPI["FastAPI Backend Application"]
    FastAPI -->|"In-Memory TTL Cache & Limiter"| InMem["In-Memory Dict & RateLimiter"]
    FastAPI -->|"SQLAlchemy ORM"| Postgres[("PostgreSQL Database")]
    FastAPI -->|"Financiële Datastream"| YFinance["Yahoo Finance Stream (Gecached)"]
    
    subgraph Pipeline ["DevSecOps & Validatie Pipeline"]
        Pytest["Pytest Unit & Mock Tests"] -.-> CI["dev-check & CI"]
        Gitleaks["Gitleaks Secret Scanning"] -.-> CI
        Bandit["Bandit Python SAST"] -.-> CI
        Trivy["Trivy Container Scan"] -.-> CI
        Cosign["Sigstore Cosign Signing"] -.-> CI
    end
{{< /mermaid >}}

---

## ✨ Functionaliteiten & Technische Werking

- **Gecachete Batch-Ophaling van Marktdatastromen:** Koersdata wordt opgehaald via Yahoo Finance (`yfinance`) met batch-fetching en een in-memory cache (TTL 60 seconden) in `price_service.py` om rate limits te voorkomen.
- **Technische Indicatoren:** Automatische berekening van RSI-14, MACD, Stochastic %K/%D, CCI-20, Williams %R en SMA/EMA via `market_data_service.py`.
- **Dynamische Portfolio P&L:** Realtime berekening van actuele winst/verlies (P&L), weighted P/E en portfoliowaarde tegen live marktprijzen in `portfolio.py` en `metrics_service.py`.
- **Authenticatie & Rate Limiting:** JWT-authenticatie (PyJWT), bcrypt wachtwoordhashing met 12 salt rounds, refresh token-vernieuwing via `POST /api/v1/auth/refresh`, en endpoint rate limiting via `InMemoryLimiter` (maximaal 5 pogingen per minuut op login-routes).
- **Health-check & Telemetrie:** Systeembewaking via root-endpoint `/health` en Prometheus scraping via `/metrics`.
- **Geautomatiseerde Staging Promotie:** Automatische update van de container image-tag in `docker-compose.prod.yml` bij pushes naar de main/staging of prod branch in `main-ci.yml`.

---

## 🔭 Observability Deep-Dive: Hoe telemetrie echt werkt

Om dieper te begrijpen hoe distributed systems gemonitord worden, heb ik gekozen voor een gescheiden pull- en push-architectuur:

### 1. Prometheus (Pull Architectuur via Custom ASGI-Middleware)
Prometheus draait **geen agent** in de FastAPI-container.
* In plaats van een zware externe dependency zoals `prometheus-fastapi-instrumentator`, maakt de applicatie gebruik van een op maat gemaakte, thread-safe ASGI-middleware in `app/main.py`.
* Met behulp van een interne `defaultdict(int)` en een `threading.Lock()` worden HTTP-requests per methode, pad en statuscode realtime geteld en worden uptime- en statusmetrics bijgehouden (`http_requests_total`, `app_uptime_seconds`, `app_status`).
* Prometheus leest zijn configuratie (`infrastructure/prometheus/prometheus.yml`), zoekt de hostname `web:8011` op via Docker's ingebouwde DNS, stuurt elke 15 seconden een HTTP GET naar `/metrics` en slaat de verzamelde metric-regels op in zijn lokale time-series database (TSDB).

### 2. Jaeger (Push Architectuur via OpenTelemetry)
Voor distributed tracing is de OpenTelemetry (OTel) Python SDK direct in de code geïntegreerd via `FastAPIInstrumentor` in `app/core/telemetry.py`:
* **HTTP Endpoint Spans:** Zodra een client een request stuurt naar FastAPI, start de OTel middleware een trace span met routing-, method- en statuscode-attributen.
* **Batch Processing:** Zodra de request is afgehandeld, buffert en serialiseert de background `BatchSpanProcessor` deze traces en pusht ze via HTTP POST direct naar `http://jaeger:4318/v1/traces`.

### 3. Grafana Loki (Push Architectuur voor Logs)
In grote enterprise clusters leest een node daemon (zoals Promtail of Fluentbit) container-logbestanden uit van de host disk. In deze Compose setup wilde ik het directer en lichter aanpakken:
* De environment variabele `LOKI_URL: http://loki:3100/loki/api/v1/push` wordt direct meegegeven aan de web container.
* Een custom Python logging handler in `app/core/logging_loki.py` pusht gestructureerde JSON-logs rechtstreeks over het Docker bridge netwerk naar Loki's REST API.

### 4. Alertmanager
Alertmanager schraapt de app niet zelf. Prometheus evalueert de scrape metrics continu tegen alert rule bestanden (zoals `up == 0` of `http_requests_5xx > 5%`).
* Blijft een conditie gedurende de ingestelde tijd waar, dan stuurt Prometheus een alert payload naar Alertmanager op poort 9093.
* Alertmanager groepeert identieke meldingen, controleert of er actieve silence-windows zijn, en kan webhooks uitsturen naar externe kanalen.

### 5. Grafana
Grafana dient puur als visualisatielaag. Het verbindt met Prometheus (:9090), Loki (:3100) en Jaeger (:16686) en voert realtime PromQL- en LogQL-queries uit wanneer een dashboard geopend wordt.

---

## 🔐 Secrets & Beveiliging: Wat werkt en wat zijn de valkuilen?

Tijdens het bouwen ben ik bewust in de details van secrets management en security gedoken:

### 1. HashiCorp Vault: Dev Mode vs. Echte Productie
In deze Compose lab-omgeving draait Vault in dev mode. Dat was ideaal om de Vault API te leren kennen, maar brengt duidelijke technische beperkingen met zich mee:
* **Vluchtig geheugen (`inmem`):** Herstart de container (bijv. bij een reboot), dan verdampt alle data en moet `seed-vault.ps1` opnieuw draaien. Echte productie vereist een Integrated Raft cluster met persistente disk mounts.
* **Unsealing & Authenticatie:** Dev mode gebruikt een vaste master key en een statische root token (`VAULT_DEV_ROOT_TOKEN_ID: "root"`). In productie ontgrendelt men via AWS KMS of Azure Key Vault HSM en authenticeert de app via AppRole of Kubernetes ServiceAccounts.
* **Dynamic Database Secrets:** Het doel in productie is dat Vault dynamische PostgreSQL gebruikers aanmaakt met een korte lease (bijv. 1 uur, `v-app-trade-xyz123`), waarna Vault de rechten automatisch intrekt.
* **Valkuil met hardcoded env vars:** Als een Compose-bestand tegelijk Vault draait én hardcoded `DATABASE_URL` variabelen doorgeeft, heeft de app Vault in feite niet nodig. Professioneler is het gebruik van `${VAR:?Error: verplicht}` zodat Compose faalt als een variabele ontbreekt, of bestandsgebaseerde Docker Secrets (`/run/secrets/`).

### 2. Tailscale Mesh vs. Echte Zero Trust
Ik gebruik Tailscale (WireGuard) voor veilige toegang op afstand tot mijn machines. Maar het is belangrijk om te beseffen dat een mesh VPN op zichzelf nog geen **Zero Trust Architecture (NIST SP 800-207)** is:
* Tailscale beveiligt het transport en geeft vertrouwde nodes een 100.x.y.z IP.
* Echte Zero Trust gaat ervan uit dat het netwerk al gecompromitteerd kan zijn: het vereist mTLS (microservices die elkaar met x509-certificaten verifiëren), expliciete autorisatie per individueel request, en kortlevende identity tokens volgens least-privilege.

---

## 🛠️ Software Supply Chain Security in CI/CD

Bij elke pull request en commit draait een geautomatiseerde pipeline:
1. **Pre-commit hooks:** Gitleaks scant op per ongeluk gecommitte secrets en credentials, terwijl Ruff snelle syntax- en kwaliteitslinting uitvoert.
2. **Lokaal verificatiescript (`dev-check.ps1`):** Voert 5 geautomatiseerde stappen uit: Pytest unit tests, Bandit SAST security scans, Gitleaks detectie, en configuratievalidatie van zowel de dev- als prod-compose stacks.
3. **GitHub Actions CI/CD:** Bandit voert geautomatiseerde SAST-analyses uit (`main-ci.yml`), en Trivy scant de containerlagen en base images op bekende CVE's (met SARIF-rapportage naar GitHub Security in `reusable-security.yml`).
4. **Cryptografische signing:** Release-images worden cryptografisch ondertekend met **Sigstore Cosign** via keyless GitHub OIDC tokens.
5. **E2E Testsuite (`tests/test_deployment_to_running.sh`):** 456 regels Bash die de volledige levenscyclus testen: wachten tot de server reageert op `/health` en `/docs`, databasemigraties (Alembic) verifiëren, testgebruikers registreren/inloggen, watchlist CRUD uitvoeren en portfolio-transacties testen met live beursdata.

---

## 📸 Technische Validatie & Screenshots

Onderstaande screenshots tonen de lokaal draaiende stack, telemetrie en cluster-experimenten:

### 1. API Gateway & OpenAPI Documentatie
> **FastAPI Swagger UI & OpenAPI 3.1:** Draaiend op `localhost:8011/docs`. Toont de authenticatie-endpoints (OAuth2 password flow, JWT refresh rotatie), beveiligde endpoints en marktdatastromen.

![FastAPI Swagger UI Documentatie](./01_fastapi_swagger.png)

---

### 2. Observability & Telemetrie (Grafana, Prometheus & Alertmanager)
> **Grafana Telemetrie Dashboard:** Realtime visualisatie van HTTP-responstijden, statuscodes en foutpercentages, gevoed door Prometheus scrapes.

![Grafana Observability Dashboard](./02_grafana_ui.png)

> **Prometheus Query Visualisatie & Scrape Targets:** PromQL query-analyse en overzicht van alle gezonde 'UP' targets in het Docker-netwerk.

{{< gallery >}}
  <img src="./03_prometheus_graph.png" class="grid-w50" />
  <img src="./03_prometheus_targets.png" class="grid-w50" />
{{< /gallery >}}

> **Alertmanager Notificatiebeheer:** Configuratie voor alert grouping en webhook-routering bij servicestoringen.

![Alertmanager UI](./04_alertmanager_ui.png)

---

### 3. Distributed Tracing & Centralized Logging (Jaeger & Loki)
> **Jaeger Distributed Tracing:** End-to-end trace analyse over FastAPI endpoints en HTTP responstijden om latentie op te sporen.

![Jaeger Distributed Tracing](./05_jaeger_tracing.png)

> **Grafana Loki Log Aggregatie:** Live statusverificatie (`ready`) van de centrale log streaming server.

![Grafana Loki Status](./09_loki_ready.png)

---

### 4. Secrets & Private Container Registry
> **HashiCorp Vault UI:** Web interface van de lokale Vault server voor credential-opslag.

![HashiCorp Vault UI](./06_vault_ui.png)

> **Private Docker Registry & Trivy Container Scanning:** Lokaal gehoste registry (`localhost:5000`) gecombineerd met Trivy voor CVE-scans op container-images.

{{< gallery >}}
  <img src="./07_local_registry.png" class="grid-w50" />
  <img src="./08_trivy_server.png" class="grid-w50" />
{{< /gallery >}}

---

### 5. Cloud-Native Migratieconcepten (Kubernetes & Clusters)
> **Kubernetes / K3s Cluster Experimenten:** Verificatie van cluster-communicatie en container-orkestratie ter voorbereiding op toekomstige enterprise cloud-migraties.

![K3s Kubernetes Cluster Status](./10_k3s_cluster.png)

---

## 🚀 Bronnen & Code

- [**AlphaTracer Financial API op GitHub**](https://github.com/sebian-lab/alphatracer-financial-api)
- [**AlphaTracer Mobile Android Client**](https://github.com/sebian-lab/alphatracer-mobile)
- [**Download CV (PDF)**](/resume.pdf)
