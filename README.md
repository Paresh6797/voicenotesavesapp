# Voice Note App

## Overview

This application allows users to manage their accounts and save voice notes, built using Flutter.

## Prerequisites

Before running this application, ensure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.24.4, stable channel)
- Dart SDK (comes with Flutter)
- An IDE such as [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)
- Xcode (for iOS development)

## Getting Started

### 1. Clone the Repository

Clone the repository with the following commands:
```bash
git clone https://github.com/Paresh6797/voicenotesavesapp.git
```
```bash
cd voicenotesavesapp
```

### 2. Dart EntryPoint Configuration

Ensure that the Dart entry point is correctly configured. It should point to your main file, 
for example:
```bash
'/Users/username/voicenotesavesapp/lib/core/main/main.dart'
```

### 3. Build the App

To build the Android APK, run the following command:
```bash
"flutter build apk  -t ./lib/core/main/main.dart"
```

To build the iOS App, run the following command:
```bash
"flutter build ios -t ./lib/core/main/main.dart"
```

### 3. Dummy Login Credentials
You can use the following credentials to log in:

- **Email:** demo@gmail.com
- **Password:** 123456