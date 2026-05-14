# totalxtask

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# TotalX User Management App

A Flutter-based user management application built for the TotalX interview task.

---

## Features

* Google Sign-In Authentication
* Splash Screen Authentication Check
* Add Users with:

  * Name
  * Phone Number
  * Age
  * Profile Image
* Firebase Firestore Integration
* Firebase Storage Image Upload
* Infinite Scroll Pagination
* User-specific Data Filtering
* Form Validation
* Snackbar Error Handling
* Clean Architecture with Provider State Management
* Reusable Widgets & Constants

---

## Tech Stack

### Frontend

* Flutter
* Provider

### Backend & Services

* Firebase Authentication
* Cloud Firestore
* Firebase Storage

### Packages Used

* firebase_core
* firebase_auth
* cloud_firestore
* firebase_storage
* provider
* image_picker
* cached_network_image
* google_sign_in
* flutter_dotenv

---

## Project Structure

```plaintext
lib/
│
├── controller/
├── core/
│   ├── constant/
│   ├── services/
│   ├── utils/
│   └── theme/
│
├── data/
├── routes/
├── views/
└── widgets/
```

---

## Firebase Setup

1. Create Firebase Project
2. Enable:

   * Google Authentication
   * Firestore Database
   * Firebase Storage
3. Add SHA-1 & SHA-256 fingerprints
4. Download `google-services.json`
5. Place it inside:

```plaintext
android/app/
```

---

## Environment Setup

Create `.env` file in project root:

```env
API_KEY=YOUR_API_KEY
APP_ID=YOUR_APP_ID
MESSAGING_SENDER_ID=YOUR_SENDER_ID
PROJECT_ID=YOUR_PROJECT_ID
STORAGE_BUCKET=YOUR_STORAGE_BUCKET
```

---

## Run Project

```bash
flutter pub get
flutter run
```

---

## Build APK

```bash
flutter build apk --release
```

APK location:

```plaintext
build/app/outputs/flutter-apk/app-release.apk
```

---

## Architecture

The project follows:

* Provider State Management
* Service Layer Separation
* Reusable Components
* Constant-based UI System

---

## Author

Abdul Sathar

Flutter Developer
