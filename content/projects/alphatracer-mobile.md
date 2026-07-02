---
title: "AlphaTracer Mobile"
---

## Problem
Users need a secure way to track investments on the go.

## Features
- **Biometric authentication** (fingerprint/face)
- **Background price alerts** (WorkManager)
- **MVVM architecture** with Room and Retrofit
- **Secure secrets** (`local.properties` → `BuildConfig`)

## Security Measures
- **ProGuard obfuscation** (rules preserved for Gson/Retrofit)
- **Network Security Config** (HTTPS + certificate pinning)
- **GitHub Actions CI**: `lintDebug`, `assembleDebug`, artifacts

## Tech stack badges:
![Kotlin](https://img.shields.io/badge/Kotlin-7F52FF?style=flat&logo=kotlin)
![Jetpack Compose](https://img.shields.io/badge/Jetpack%20Compose-4285F4?style=flat&logo=jetpackcompose)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=flat&logo=githubactions)

## Screenshots
*(Mockups of the Android App Interface)*

[**View Source on GitHub**](https://github.com/sebian-lab/alphatracer-mobile)
