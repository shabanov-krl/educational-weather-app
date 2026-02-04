# BLoC - Business Logic Component

## Overview

At the core of this architecture is the BLoC pattern, which aims to clearly separate business logic from UI elements, ensuring:

- Widgets are intended exclusively for rendering UI and interactions.
- BLoC handles exclusively business logic.

One of the fundamental rules is that BLoC remains unaware of any widgets. Violating this rule can lead to states like `ShowDialogState` or `ShowSnackBarState` inside BLoC. Instead, widgets should define their display elements, such as dialogs or snack bars, based on state updates received from BLoC.

It's worth noting that BLoC is written in pure Dart and doesn't rely on external frameworks like Flutter. Its design is heavily influenced by the State pattern.

> We have [VSCode snippets for BLoC](/.vscode/bloc.code-snippets), use it

## BLoC Structure

BLoC consists of three main components:

- State: Represents the current state of the bloc.
- Event: Represents an event that triggers a state change.
- Bloc: Manages state transitions based on received events.

There is a well-known library called [bloc](https://pub.dev/packages/bloc) that provides a common implementation of the BLoC pattern.

## Some BLoC Rules

- BLoC should not have anything related to UI.
- BLoC should not know anything about end consumers.
- BLoC should not have any public methods and fields.
- BLoC should have only one input and one output - event stream and state stream respectively.
- BLoC should be testable in isolation.
- BLoC should not have any dependencies on other blocs.
- BLoC should do only one thing (e.g., it should not be responsible for all screen logic).
- BLoC gets data only from repositories.
- Events should be named in the past tense, since an event is something that has already happened, for example, not `load`, but `loadRequested`, i.e. a load request has occurred

## State Pattern

The State pattern is a design methodology that allows an object to demonstrate different behavior based on its internal state transitions. As a result, it creates the impression that the object changes its class during runtime.

Conceptually, this aligns with a finite state machine (FSM). An FSM is designed based on a set of defined states with specified transitions between them. Transitions are controlled by events; when an event occurs, the FSM changes its state according to a predefined transition.
