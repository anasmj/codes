1. Create a firebase project from https://console.firebase.google.com
2. Register apps for different platforms using projects application ID to package name. eg- com.example.test_firebase
3. Make sure node is installed. Run 'node -v' to check it
4. Install Firebase CLI
```
npm install -g firebase-tools
dart pub global activate flutterfire_cli
```
5. In the terminal of your project run -
```
firebase login
```
6. After logging in from browser with correct account, run
```
flutterfire configure
```
7. it will show project list. select the project. Or run the following to directly select the project from terminal
```
flutterfire configure --project=<project-ID-assigned-by-firebase>

```
it will show a prompt like -
```
Which Android application id (or package name) do you want to use for this configuration, e.g. 'com.example.app'?
```
enter the package name you registered the app with. eg. 'com.example.test_firebase' - don't make mistake here 
 
8. select target platforms and it would generate a firebase_options.dart under lib folder,
   for android google-service.json in android/app/google-service.json
   for iOS ios/Runner/GoogleService-Info.plist
9. In main() function, add the following before runApp();
```
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```
10. Specify the minSDKVersion to 19, add firebase_core^latest_versionÏ

11. Adjust your project :
     In android/build.gradle add:
```
 buildscript {
     ext.kotlin_version = '2.0.20'
     repositories {
         google() // add this line
         mavenCentral()
     }
     dependencies {
         classpath "org.jetbrains.kotlin:compose-compiler-gradle-plugin:2.0.20"
         classpath 'com.android.tools.build:gradle:7.3.1'
         classpath 'com.google.gms:google-services:4.3.15'//add latest version
     }
 }

```

In the app-level build.gradle file located in android/app, ensure that you apply the google-services plugin at the bottom of the file:
```
apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services' // Add this line at the bottom
```
