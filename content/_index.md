---
title: "Sebian Van de Spiegle"
---

## Building secure, scalable systems from mobile to cloud

I'm a developer with a passion for **cybersecurity** and **cloud infrastructure**.  
Below you'll find my portfolio — all projects are live, integrated, and continuously delivered.

{{< mermaid >}}
graph LR
    A[Android App] -- HTTPS --> B[Nginx]
    B --> C[FastAPI Backend]
    C --> D[(PostgreSQL)]
    C --> E[Yahoo Finance]
{{< /mermaid >}}

---

{{< project-card
    title="AlphaTracer Android"
    description="Real‑time portfolio tracker with biometric auth and background alerts."
    link="/projects/alphatracer-mobile"
    tags="Jetpack Compose, Retrofit, WorkManager"
>}}

{{< project-card
    title="Backend API"
    description="FastAPI service with JWT, yfinance, and PostgreSQL. Rate‑limited, secure."
    link="/projects/backend-api"
    tags="FastAPI, SQLAlchemy, Docker, JWT"
>}}

{{< project-card
    title="Cloud & Virtualisation Labs"
    description="Azure VMs, AKS, ARM templates; VMware ESXi with AD/DHCP."
    link="/projects/infrastructure"
    tags="Azure, VMware, Kubernetes, IaC"
>}}
