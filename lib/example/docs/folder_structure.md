# Folder Structure

## Overview

The project uses a feature-based structure, which is a popular approach for structuring large-scale applications. This is a modular architecture that encapsulates related functionality into autonomous modules.

## General Folder Structure

```txt
root - Project directory
├── assets - Icons, images and other assets
├── test - Tests
├── packages - Local flutter/dart packages
├── android - Native files for Android
├── ios - Native files for iOS
├── lib - Root of all source code
│   ├── main.dart - Application entry point
│   └── src - Private source code
│       ├── core - Common application code
│       └── features - Modular features
├── .gitignore - Contains list of paths that should be ignored by git
├── analysis_options.yaml - Set of rules for dart analyzer
├── build.yaml - Project-level configuration for code generation
└── pubspec.yaml - Project dependencies and metadata
```

## Core Directory

The core directory is the heart of the application. It contains utilities and configurations that provide functionality to multiple features, for example:

- Mixins and Extensions: Frequently used functions or properties that can be mixed into classes.
- Rest Client: Standardized configurations and methods for API requests.
- Database: Database configurations and methods for data access.
- Localization: Language files and auto-generated translations.
- BLoC Observer: Debugging and monitoring tool for the BLoC pattern.
- Theme: Customized theme for the application.

| ❗ Danger|
|-|
| Avoid impulsively moving files to the core directory, it can quickly bloat. This should be done with careful consideration and only when code is truly reusable across multiple features. |

## Feature Directory

The Feature directory contains all features of your application. Each feature represents an autonomous module that encapsulates its own logic and widgets. This is a modular architecture that allows you to easily add and remove features.

```txt
authorization - Authorization feature directory
├── domain - Business logic layer, most often implemented through BLoC
│   ├── authorization_bloc.dart - Authorization BLoC
│   │── authorization_event.dart - Authorization BLoC events
│   └── authorization_state.dart - Authorization BLoC states
├── data - Data layer
│   ├── repository - Repository
│   │   └── models - Models
│   └── data_source - Data source
│       └── dto - Dtos
└── ui - UI layer
    ├── widgets - Widgets directory
    │   └── authorization_form.dart - Authorization form
    └── authorization_screen.dart - Authorization screen
```

| 🦄 Tip |
|- |
| Dependencies between features should be minimized to avoid coupling. |

| Example |
|- |
| There is a `profile` feature and there is a `ProfileRepository` that needs to be listened to in the `shop` feature. Thoughts may arise to move this repository to `core/` since it's used in more than one feature, but this shouldn't be done. The repository logically belongs to the `profile` feature. We relate to `core/` code that doesn't belong to features. |
