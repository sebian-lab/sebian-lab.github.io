---
title: "AlphaTracer Mobile"
---

![Kotlin](https://img.shields.io/badge/Kotlin-0095D5?style=flat&logo=kotlin&logoColor=white) ![Android](https://img.shields.io/badge/Android-3DDC84?style=flat&logo=android&logoColor=white) ![Jetpack Compose](https://img.shields.io/badge/Compose-4285F4?style=flat&logo=android&logoColor=white) ![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=github-actions&logoColor=white)

## Overview

AlphaTracer is a real-time financial portfolio tracking application for Android. It uses modern MVVM architecture with Jetpack Compose to deliver a secure, responsive user experience. 

## Key Features
- **Real-Time Tracking**: Monitors stocks and portfolio performance dynamically.
- **Biometric Authentication**: Secure access using fingerprint/face recognition.
- **Background Alerts**: Periodic syncing and alerts using Android `WorkManager`.
- **Modern UI**: Fully built with Jetpack Compose for a reactive and declarative interface.

## DevOps & Cybersecurity Additions

I have heavily focused on implementing industry-standard DevOps and security practices in this project:

### Automated Build Pipeline (CI/CD)
- A GitHub Actions workflow automatically checks out code, sets up JDK 17, and runs quality checks (`lintDebug`).
- Compiles the debug APK (`assembleDebug`) and saves artifacts automatically upon push or pull request to the `main` branch.

### Secure Secrets Management
- Sensitive configurations (like `API_BASE_URL`) are stored locally in `local.properties` and excluded from Git.
- Gradle injects these values at compile-time via `buildConfigField`.
- The CI pipeline includes fallbacks to prevent build failures when secrets are unavailable.

### Network Security Config & Certificate Pinning
- **Cleartext traffic (HTTP) is explicitly forbidden**; all communication is forced over HTTPS.
- **Certificate Pinning** is implemented for the API backend to prevent Man-in-the-Middle (MitM) attacks.

### Code Obfuscation
- R8/ProGuard is configured to obfuscate the code, renaming classes and variables to hinder reverse engineering.
- Custom rules protect `@SerializedName` annotations and Retrofit HTTP interfaces to prevent runtime crashes.

[**View Source on GitHub**](https://github.com/sebian-lab/alphatracer-mobile)
