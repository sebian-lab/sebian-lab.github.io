---
title: "Backend Financial API"
---

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) ![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat&logo=fastapi&logoColor=white) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)

## Overview

A high-performance backend REST API built to serve the AlphaTracer mobile application. It aggregates financial data, manages user accounts securely, and provides low-latency endpoints.

## Key Features
- **Data Aggregation**: Integrates with `yfinance` to fetch real-time market data.
- **User Management**: Complete registration and login flows.
- **JWT Authentication**: Secure stateless token-based auth for mobile clients.
- **Containerized**: Fully Dockerized for predictable deployment environments.

## Tech Stack
- **Framework**: FastAPI (Python)
- **Database**: PostgreSQL with SQLAlchemy ORM
- **Authentication**: OAuth2 with JWT tokens
- **Infrastructure**: Docker & Docker Compose
- **Reverse Proxy**: Nginx

## Security Measures
- Passwords hashed using bcrypt.
- Rate limiting implemented to prevent abuse and brute-force attacks.
- Environment variables utilized for all sensitive secrets and database credentials.
- CORS policies strictly defined for authorized clients.

[**View Source on GitHub**](https://github.com/sebian-lab/alphatracer-financial-api)
