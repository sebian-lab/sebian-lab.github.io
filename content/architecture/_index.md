---
title: "Architecture"
---

## Full-System Diagram

{{< mermaid >}}
flowchart TD
    Android[Android app] -->|JWT / HTTPS| CF[Cloudflare Tunnel]
    CF --> Nginx[Nginx]
    Nginx --> FastAPI[FastAPI]
    
    FastAPI --> Postgres[(PostgreSQL)]
    FastAPI --> Redis[(Redis Cache)]
    FastAPI --> YF[Yahoo Finance]
{{< /mermaid >}}

## Data Flow
- **User authentication**: JWT validation via FastAPI.
- **Portfolio transactions**: Stored securely in PostgreSQL.
- **Price fetching**: `yfinance` cached 60s in Redis.
- **Alert handling**: WorkManager on Android runs background tasks.

## CI/CD pipelines
- GitHub Actions automatically trigger tests, linting (`lintDebug`), and build (`assembleDebug`) for the Android app.
- Backend pipeline includes **Bandit (SAST)** and **Trivy (vulnerability scan)**.

## Security layers
- **TLS**: Enforced across all endpoints.
- **Rate limiting**: 5 requests/minute on sensitive routes (e.g., login).
- **Headers**: HSTS, X-Frame-Options, X-Content-Type-Options.

## Deployment
- **Docker Compose**: Orchestrates nginx, FastAPI, PostgreSQL, and Redis.
- **AKS**: Azure Kubernetes Service used for scalable deployments in labs.
- **Infrastructure as Code**: ARM templates and k8s manifests.
