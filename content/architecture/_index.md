---
title: "Architecture"
---

## Full-system Diagram

{{< mermaid >}}
graph TD
    subgraph "User Client"
        A[Android App]
    end
    subgraph "Cloud (Azure)"
        B[Azure VM / AKS]
        C[FastAPI Backend]
        D[(PostgreSQL)]
        E[Yahoo Finance API]
    end
    subgraph "Homelab (orion‑o6)"
        F[Docker Host]
        G[Media / AI / Monitoring Containers]
    end
    A -- HTTPS --> B
    B -- HTTP --> C
    C -- SQL --> D
    C -- yfinance --> E
    C -- monitoring --> F
{{< /mermaid >}}

## Data Flow Explanation
- **User authentication**: JWT tokens stored securely.
- **Portfolio transactions**: Stored in PostgreSQL.
- **Price fetching**: `yfinance` cached 60s.
- **Alert handling**: WorkManager on Android.

## CI/CD Pipelines
- **GitHub Actions** for Android and Backend.

## Security Layers
- **TLS**, **Rate limiting**, **JWT**, **Headers**.

## Deployment
- **Docker Compose** vs. **AKS** (both used).
- **Infrastructure as Code** (ARM templates, k8s manifests).
