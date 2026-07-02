---
title: "Backend Financial API"
---

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) ![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat&logo=fastapi&logoColor=white) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)

## Overview

A high-performance backend REST API built to serve the AlphaTracer mobile application. It aggregates financial data from Yahoo Finance (`yfinance`), manages user accounts securely, and provides low-latency endpoints. It features dual-database support: SQLite for zero-setup local dev and PostgreSQL for production.

## Tech Stack
- **Framework**: FastAPI (Python)
- **Database**: PostgreSQL with SQLAlchemy ORM (and SQLite for local dev)
- **Authentication**: OAuth2 with JWT tokens (bcrypt password hashing)
- **Infrastructure**: Docker & Docker Compose
- **Data Source**: yfinance (with extensive local SQLite caching for history and metrics)

## Cybersecurity Features

This API includes production-ready cybersecurity measures:

- **Rate Limiting**: Limits login requests (`/auth/login`) to 5 requests per minute to prevent brute-force attacks.
- **Security Headers**: Standard secure HTTP headers are injected automatically via custom middleware (e.g. `X-Content-Type-Options: nosniff`, `X-Frame-Options: DENY`, `Strict-Transport-Security`).
- **Dynamic CORS**: Allowed origins can be dynamically configured via environment variables.
- **CI/CD Security Pipelines**: Automated security checks run on push and PR:
  - **Bandit**: Static Application Security Testing (SAST) to check for insecure code or hardcoded keys.
  - **Trivy**: Dependency vulnerability scanner to flag outdated packages.

## Comprehensive Market Data Management
- Pre-warms database at startup using CSV ticker lists.
- Implements fuzzy search scoring for rapid stock discovery.
- Extensive caching mechanisms to prevent rate-limiting from upstream data providers.

[**View Source on GitHub**](https://github.com/sebian-lab/alphatracer-financial-api)
