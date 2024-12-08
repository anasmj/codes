### step 1: Create a file named 'key.properties' in [project-name]/android/ location. Add these lines in the file. There is no spase after '=' sign
```
storePassword=<A random pass that needs to be secured>
keyPassword=<Same password used in 'storePassword'>
keyAlias=upload
storeFile=<keystore-file-location>
```
### Step 2: Run the following command in terminal

From from mac or linux 
```
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
        -keysize 2048 -validity 10000 -alias upload
```
From Windows
```
keytool -genkey -v -keystore $env:USERPROFILE\upload-keystore.jks `
        -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
        -alias upload
```
Provide the same password that used for 'storePassword' when it prompts for passwrd. and re- enter as well. Provide information it asks, you can also just press enter for 
everything to skip. At the end, type 'yes' and continue. 

it will generate a 'upload_keystore.jks' file in the machine
### step 3: Place the generated file in your project 
- place the 'upload-keystore.jks' inside [project]/android/app/
- In [project]/android/key.properties , provide the location of 'upload-keystore.jks' that you just paced.
  the line should look like 'storeFile=../app/upload-keystore.jks'
If keystorePassword is incorrect: 
navigate to home, delete all the keystore password and regenerate .jks file again

### step 3: configure signing in graddle
- To configure gradle, go to <project>/android/app/build.gradle file and add these code before android block
```
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
   ...
}
```
- Select the whole 'buildTypes' section in [project]/android/app/build.gradle and paste the following code
```
  signingConfigs {
        release {
            keyAlias = keystoreProperties['keyAlias']
            keyPassword = keystoreProperties['keyPassword']
            storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword = keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now,
            // so `flutter run --release` works.
            signingConfig = signingConfigs.debug
            signingConfig = signingConfigs.release
        }
```
Then it should look like this - 
```
android {
    // ...

    signingConfigs {
        release {
            keyAlias = keystoreProperties['keyAlias']
            keyPassword = keystoreProperties['keyPassword']
            storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword = keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now,
            // so `flutter run --release` works.
            signingConfig = signingConfigs.debug
            signingConfig = signingConfigs.release
        }
    }
...
}
```
### step 4: fromm root directory, run the following command(run flutter clean before if previously built)- 
```
flutter buld appbundle
```
or 
```
flutter build apk
```
### step 5: add these two lines in .gitignore 
```
key.properties
app/upload-keystore.jks
```
# Now your .apk or .aab is ready to upload to play console 
the link of your app will be associated with the package id and it will look like below in play store
```
https://play.google.com/store/apps/details?id=com.example.myapp
```
