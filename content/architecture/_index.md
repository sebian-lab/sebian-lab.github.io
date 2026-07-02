---
title: "System Architecture"
---

## Full Stack Integration

This portfolio represents a fully integrated ecosystem, bridging the gap between mobile frontend, cloud-hosted backend APIs, and underlying virtualized infrastructure.

{{< mermaid >}}
flowchart TD
    subgraph Mobile Client
        A[AlphaTracer Android App]
    end

    subgraph Azure Cloud Infrastructure
        B[Nginx Reverse Proxy]
        C[FastAPI Backend Container]
        D[(PostgreSQL Database)]
    end

    subgraph External Services
        E[Yahoo Finance API]
    end

    A -- HTTPS / JWT --> B
    B -- Port 8000 --> C
    C -- SQLAlchemy --> D
    C -- API Calls --> E
{{< /mermaid >}}

## Data Flow
1. The **Android client** initiates requests using Retrofit, authenticating via a JWT bearer token.
2. The **Nginx reverse proxy** intercepts the requests, handles SSL/TLS termination (if configured), and enforces rate-limiting to protect backend resources.
3. The **FastAPI service** validates the JWT, processes the business logic, and queries external market data from **Yahoo Finance**.
4. User portfolios and state are persisted securely in the **PostgreSQL database** running in a separate, isolated container or managed service.

## Security Layers
- **Transport Security**: TLS encryption for all data in transit.
- **Identity**: Stateless JWT token verification.
- **API Protection**: Nginx rate-limiting and robust CORS policies.
- **Network**: Backend containers and databases are hidden within private virtual networks/Docker bridges and are only accessible via the proxy.

## CI/CD Pipeline
- **Version Control**: Codebases managed in GitHub.
- **Automation**: GitHub Actions automatically trigger on push to `main`.
- **Build & Deploy**: The backend is dockerized and pushed to a registry, while the Android app is compiled and signed securely using encrypted secrets.
