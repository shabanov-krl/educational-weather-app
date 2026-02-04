# Architecture

This section provides a detailed overview of the project's architectural solutions, giving insight into the patterns used and their implementation.

## Overview

The project architecture is based on several key patterns:

- BLoC (Business Logic Component): Primarily used for state management.
- State Pattern: A design pattern that provides dynamic behavior based on internal state. More detailed information can be found [here](https://refactoring.guru/design-patterns/state).
- Repository Pattern: Provides a clean and efficient way to manage data operations.
- Dependency Injection: Allows the architecture to remain modular and flexible. More detailed information [here](dependencies.md).

When visualized, the dependency flow looks as follows:

```txt
Widget -> BLoC -> Repository -> Data Source -> External sources (Database, API, etc.)
```

This structure has similarities to the MVVM (Model-View-ViewModel) architectural pattern.

## [BLoC - Business Logic Component](/docs/bloc.md)

## [Data Layer](/docs/data_layer.md)
