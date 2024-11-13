
# Step-by-Step Guide for Firebase Configuration in Flutter using FlutterFire CLI

This guide explains how to set up Firebase for a Flutter project using the FlutterFire CLI. Follow these steps to configure Firebase for your app.

---

## Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com).
2. Click on **Add Project** and follow the instructions to create a new project.
3. After creating the project, navigate to the project settings.

---

## Step 2: Register Apps for Different Platforms

1. In the Firebase Console, click on **Add App**.
2. Select the platform (e.g., Android, iOS).
3. Enter your app’s **Application ID** or **Package Name** (e.g., `com.example.test_firebase`).
4. Complete the registration process for each platform.

---

## Step 3: Ensure Node.js is Installed

1. Verify Node.js is installed by running:

   ```bash
   node -v
   ```

   If not installed, download it from [Node.js official website](https://nodejs.org).

---

## Step 4: Install Firebase CLI and FlutterFire CLI

Run the following commands to install the required tools:

```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
```

---

## Step 5: Log in to Firebase

Run the following command in your project terminal:

```bash
firebase login
```

This will open a browser window where you can log in with your Firebase account.

---

## Step 6: Configure Firebase in Your Flutter Project

Run the following command:

```bash
flutterfire configure
```

This will display a list of your Firebase projects. Select the desired project or use the command below to directly select a project:

```bash
flutterfire configure --project=<project-ID-assigned-by-firebase>
```

When prompted:
- Enter the package name registered with Firebase (e.g., `com.example.test_firebase`).
- Select the target platforms for your app.

The configuration process will:
- Generate a `firebase_options.dart` file under the `lib/` folder.
- Place `google-services.json` for Android in `android/app/`.
- Place `GoogleService-Info.plist` for iOS in `ios/Runner/`.

---

## Step 7: Initialize Firebase in Your Flutter Project

Add the following code to your `main()` function in `main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
```

---

## Step 8: Update Android Project Settings

1. Open `android/build.gradle` and ensure the following is added:

   ```gradle
   buildscript {
       ext.kotlin_version = '1.8.21'
       repositories {
           google()
           mavenCentral()
       }
       dependencies {
           classpath 'com.android.tools.build:gradle:7.3.1'
           classpath 'com.google.gms:google-services:4.3.15'
       }
   }
   ```

2. Open `android/app/build.gradle` and ensure:

   ```gradle
   apply plugin: 'com.android.application'
   apply plugin: 'com.google.gms.google-services'
   ```

3. Set `minSdkVersion` to 19 in `android/app/build.gradle`:

   ```gradle
   defaultConfig {
       minSdkVersion 19
   }
   ```

---

## Step 9: Final Steps

1. Run the app to verify Firebase integration:

   ```bash
   flutter run
   ```

2. If you face any issues, ensure the `google-services.json` and `GoogleService-Info.plist` files are correctly placed.
3. Use Firebase services like Firestore, Authentication, etc., in your app.

---

Your Flutter app is now configured with Firebase using the FlutterFire CLI!
