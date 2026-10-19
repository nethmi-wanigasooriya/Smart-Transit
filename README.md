# Smart Transit App 🚍

A modern mobile application built with **Flutter** to streamline and manage public transit operations efficiently.

## 🚀 Features
- **Route & Transit Management**: Seamlessly manage and track transit routes and schedules.
- **Local Data Storage**: Utilizes efficient local database solutions (SQLite / Hive) for fast and secure offline data access.
- **Push & Local Notifications**: Integrated notification mechanisms for alerts and updates.
- **Cross-Platform Design**: Developed using Flutter for smooth performance on Android and iOS.

## 🛠️ Tech Stack
- **Framework**: Flutter (Dart)
- **Architecture**: MVC (Model-View-Controller) design pattern
- **Local Database**: SQLite / Hive
- **Build Tools**: Android Gradle Plugin (AGP), Gradle, Kotlin, Java 17 (Eclipse Temurin)

## 📦 Getting Started

To get a local copy up and running, follow these simple steps:

### Prerequisites
- Flutter SDK installed on your machine.
- Android Studio / Android SDK (configured with Java 17).

### Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>

Navigate to the project directory:
  cd smart-transit-app

Install dependencies:
  flutter pub get

Run the application:
  flutter run

## 🔨 Building the Release APK
To generate the production-ready release APK for Android, run the following command in your terminal:
  flutter build apk --release --android-skip-build-dependency-validation
