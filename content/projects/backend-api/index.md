---
title: "Backend Financial API"
description: "High-performance FastAPI gateway for the AlphaTracer system."
date: 2026-05-30
tags: ["FastAPI", "Python", "Docker", "PostgreSQL", "CI/CD"]
---

**Skills Demonstrated:** FastAPI, Python, Docker, PostgreSQL, REST API Design, Rate Limiting, JWT Authentication, Security Headers, SAST (Bandit/Trivy), Docker Compose.

---

## Endpoints
Auth, stocks, portfolio, watchlist, market data.

## Tech Stack
- **FastAPI** (Python 3.10+)
- **SQLAlchemy + PostgreSQL** (Docker)
- **yfinance** for real‑time prices
- **JWT** with refresh tokens
- **Rate limiting** (5/min on login)

## Security
- **HSTS, X‑Frame‑Options, X‑Content‑Type‑Options**
- **CORS** with dynamic allowed origins
- **CI security**: Bandit (SAST), Trivy (vulnerability scan)

## Deployment
Docker Compose (nginx + FastAPI + PostgreSQL + Redis)

## Screenshots
*(API docs, Swagger UI)*

[**View Source on GitHub**](https://github.com/sebian-lab/alphatracer-financial-api)
