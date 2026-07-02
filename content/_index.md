---
title: "Sebian Van de Spiegle"
---

## Building secure, scalable systems from mobile to cloud

I am a **Toegepaste Informatica** (Applied Computer Science) student at **Odisee Brussel**, with a strong passion for **cybersecurity**, **DevOps**, and **cloud infrastructure**. I am currently seeking an internship in **Luxembourg** where I can apply my skills in securing networks, automating deployments, and managing cloud-native architectures.

Below you'll find my portfolio — showcasing live, integrated, and continuously delivered projects.

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
    description="Real‑time portfolio tracker with biometric auth, CI/CD, and strong app security."
    link="/projects/alphatracer-mobile"
    tags="Jetpack Compose, Retrofit, ProGuard, DevOps"
>}}

{{< project-card
    title="Backend API"
    description="FastAPI service with JWT, PostgreSQL, rate limiting, and Trivy/Bandit security scans."
    link="/projects/backend-api"
    tags="FastAPI, Docker, Security, CI/CD"
>}}

{{< project-card
    title="Cloud & Virtualisation Labs"
    description="Azure AKS, ARM templates, ESXi hypervisors, and Windows Server AD/DHCP."
    link="/projects/infrastructure"
    tags="Azure, VMware, Kubernetes, IaC"
>}}

{{< project-card
    title="Home Server Infrastructure"
    description="Self-hosted Debian environment managing 30+ Docker containers."
    link="/projects/home-server"
    tags="Debian, Docker, Self-Hosted, SysAdmin"
>}}
