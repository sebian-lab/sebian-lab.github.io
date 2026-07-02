---
title: "Backend Financial API"
---

## Endpoints
Auth, stocks, portfolio, watchlist, market data.

## Tech Stack
- **FastAPI** (Python 3.10+)
- **SQLAlchemy + PostgreSQL** (Docker)
- **yfinance** for real‑time prices
- **JWT** with refresh tokens
- **Rate limiting** (5/min on login)

## Security Measures
- **HSTS, X‑Frame‑Options, X‑Content‑Type‑Options**
- **CORS** with dynamic allowed origins
- **CI security**: Bandit (SAST), Trivy (vulnerability scan)

## Deployment
Docker Compose (nginx + FastAPI + PostgreSQL + Redis)

## Screenshots
*(API docs, Swagger UI)*

[**View Source on GitHub**](https://github.com/sebian-lab/alphatracer-financial-api)
