# sebian-lab.github.io

**Personal portfolio site** for Sebian Van de Spiegle — built with [Hugo](https://gohugo.io) and the [Hugo-Paper](https://github.com/nanxiaobei/hugo-paper) theme, deployed automatically to GitHub Pages.

🔗 **Live site**: [sebian-lab.github.io](https://sebian-lab.github.io)

---

## About

Sebian is a **Toegepaste Informatica** (Applied Computer Science) student at **Odisee Brussel**, seeking a **Cybersecurity / DevOps internship in Luxembourg**.

This portfolio covers:
- 📱 **AlphaTracer** — Android portfolio tracker (Jetpack Compose, Retrofit, WorkManager, ProGuard, GitHub Actions CI)
- ⚙️ **Backend API** — FastAPI service with JWT, PostgreSQL, yfinance, rate limiting, Bandit + Trivy security scanning
- ☁️ **Cloud & Infra Labs** — Azure VM, VNet, AKS, ARM templates, VMware ESXi, AD DS, DHCP
- 🖥️ **Homelab (orion-o6)** — Debian 12 server running 30+ Docker containers

---

## Development

Hugo is required to preview locally. Install from [gohugo.io](https://gohugo.io/installation/).

```bash
git clone --recurse-submodules https://github.com/sebian-lab/sebian-lab.github.io
hugo server
```

The site builds and deploys automatically via **GitHub Actions** on every push to `main`.

---

## Structure

```
content/
├── _index.md               # Homepage
├── projects/
│   ├── _index.md           # Projects overview
│   ├── alphatracer-mobile.md
│   ├── backend-api.md
│   ├── infrastructure.md   # Azure + VMware school labs (with screenshots)
│   └── homelab.md          # orion-o6 homelab dashboard
└── architecture/
    └── _index.md           # Full system architecture diagram
```
