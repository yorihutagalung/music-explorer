# Music Explorer

Simple music player app powered by iTunes Search API.

## Supported Devices

- All android devices with OS version >= 5.0 (Lollipop).

## Supported Features

- Search music by artist.
- Music playback will not be interrupted by new searches.

## Requirements to build

- Flutter version 2.10.3 (Dart version 2.16.1)
- Android Studio version 4.0 or higher

## Build and release an Android app
For more detailed instructions, please check this [link](https://docs.flutter.dev/deployment/android).

### 1. Create keystore signing key
On **Mac/Linux**, use the following command:

```
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

On **Windows**, use the following command:

```
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
Follow the instruction and remember the **storePassword** and the **keyPassword** you entered.


### 2. Create key.properties file
Create a file named **[project]/android/key.properties** that contains a reference to your keystore:
```properties
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>
```

### 3. Build app for release 



#### Build an APK
To build **.apk** file, use the following command on:


```
flutter build apk
```

The release apk for your app is created at **[project]/build/app/outputs/apk/release/app-release.apk**

#### Build an app bundle (Prefered)
To build **.aab** (App bundle) file, use the following command on:
```
flutter build appbundle
```

The release bundle for your app is created at **[project]/build/app/outputs/bundle/release/app.aab**.
