# KotlinMultiPlatform

A basic Kotlin Multiplatform (KMP) application showcasing shared business logic between Android and iOS with native UI for each platform.
Overview

This project demonstrates how to:

    Create a cross-platform mobile application using Kotlin Multiplatform.

    Structure shared code for business logic while maintaining native UIs.

    Set up and run a basic KMP project using IntelliJ IDEA or Android Studio.

Features

    Shared Kotlin module for application logic.

    Android app with native UI using Jetpack Compose.

    iOS app with Swift UI integration (setup-ready).

    Demonstrates key KMP concepts such as:

        Platform-specific entry points.

        Code sharing via common source sets.

        Managing platform dependencies (Android/iOS).

        Gradle Kotlin DSL project configuration.

Project Modules

    shared – Common business logic written in Kotlin.

    composeApp – Android application built with Jetpack Compose.

    iosApp – iOS application written in Swift (integrated via KMP bridge).

Technologies Used

    Kotlin Multiplatform

    Jetpack Compose (Android)

    Swift/UIKit (iOS)

    Gradle Kotlin DSL

Setup Instructions

    Clone the repository.

    Open the project in IntelliJ IDEA or Android Studio.

    To run the apps:

        Android: Run the composeApp module on an emulator or device.

        iOS: Open the iosApp in Xcode and run on a simulator.

    This project follows the steps from the official JetBrains tutorial: Create your Kotlin Multiplatform app.

License

This repository is intended for learning and demonstration purposes only.
