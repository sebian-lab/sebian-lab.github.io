---
title: "AlphaTracer Mobile"
---

![Kotlin](https://img.shields.io/badge/Kotlin-0095D5?style=flat&logo=kotlin&logoColor=white) ![Android](https://img.shields.io/badge/Android-3DDC84?style=flat&logo=android&logoColor=white) ![Jetpack Compose](https://img.shields.io/badge/Compose-4285F4?style=flat&logo=android&logoColor=white)

## Overview

AlphaTracer is a real-time financial portfolio tracking application for Android. It is designed with modern Android development practices to deliver a secure, responsive, and seamless user experience.

## Key Features
- **Real-Time Tracking**: Monitors stocks and portfolio performance dynamically.
- **Biometric Authentication**: Secure access using fingerprint/face recognition.
- **Background Alerts**: Periodic syncing and alerts using Android `WorkManager`.
- **Modern UI**: Fully built with Jetpack Compose for a reactive and declarative interface.

## Tech Stack
- **Language**: Kotlin
- **UI Toolkit**: Jetpack Compose
- **Networking**: Retrofit & OkHttp
- **Asynchronous Operations**: Kotlin Coroutines & Flow
- **Dependency Injection**: Hilt / Dagger

## Security Measures
- Secured API communication via HTTPS with strict Network Security Config.
- API keys hidden from source control using `local.properties` and Gradle `buildConfigField`.
- Code obfuscation and shrinking applied via ProGuard/R8.

[**View Source on GitHub**](https://github.com/sebian-lab/alphatracer-mobile)
