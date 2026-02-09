plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")        // or id("kotlin-android") if your template uses that
    id("com.google.gms.google-services")      // <-- apply exactly once here (no version here)
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.mysterybag"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.mysterybag"
        minSdk = flutter.minSdkVersion   // ensure this is >= 21 if you use most Firebase SDKs
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: configure your real signing for release builds
            signingConfig = signingConfigs.getByName("debug")
            // You can also enable minify/proguard here if needed
            // minifyEnabled true
            // shrinkResources true
            // proguardFiles(
            //     getDefaultProguardFile("proguard-android-optimize.txt"),
            //     "proguard-rules.pro"
            // )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase Bill of Materials to keep Firebase libs in sync
    implementation(platform("com.google.firebase:firebase-bom:34.9.0"))

    // Add the Firebase products you need (no versions when using the BoM)
    implementation("com.google.firebase:firebase-analytics")

    // Examples:
    // implementation("com.google.firebase:firebase-auth")
    // implementation("com.google.firebase:firebase-firestore")
    // implementation("com.google.firebase:firebase-messaging")
    // implementation("com.google.firebase:firebase-crashlytics")
}