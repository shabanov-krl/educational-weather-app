# Style Guide

1. Always use absolute imports.
2. Do NOT use bang operators. Prefer ??, local variables or null-aware pattern matching. See
   examples below

## Naming

1. Name handlers and callbacks as `on...`, for example `onPressed`
2. Name classes, enums and abbreviations in them in PascalCase style
3. Name classes with postfixes indicating the class type:
    - NameRepository
    - NameModel
    - NameScreen - widget screen
    - NameModal - modal widget
    - etc.
4. Name bool variables with prefixes is/was/has:

    ```dart
      bool isOrderCompleted = false;
      bool hasBeenUpdated = true;
      bool wasRejected = false;
    ```  

5. File name must match the name of the main class it contains.
   This is necessary to make it easier to navigate through directories without ide search.

## Indentation between code blocks

1. before and after curly brackets `<here>{...}<here>`
2. if the essence of the code changes: variables, then function call, etc.

```dart
/// BAD
void f() {
  final a = 1;
  if (true) {
    final b = 2;
    print(b);
  }
}

/// GOOD
void f() {
  final a = 1;

  if (true) {
    final b = 2;

    print(b);
  }
}
```

3. before and after return and super.some

```dart
/// BAD
@override
void initState() {
  f();
  super.initState();
}

/// GOOD
@override
void initState() {
  f();

  super.initState();
}
```

4. don't add if it's the beginning or end of scope

```
/// BAD
void f() {
  
  if (true) {
    // ...
  }

  return 1;
  
}

/// GOOD
void f() {
  if (true) {
    // ...
  }

  return 1;
}
```

## Null safety

```dart
/// Bad
Map<String, dynamic> _$SaveFavoriteCarPayloadToJson(SaveFavoriteCarPayload instance,) =>
    <String, dynamic>{
      // if condition will be deleted, bang will break method and app logic
      if (instance.offerId != null) 'offer_id': instance.offerId!,
      // other fields
    };

/// With local variable
Map<String, dynamic> _$SaveFavoriteCarPayloadToJson(SaveFavoriteCarPayload instance,) {
  final offerId = instance.offerId;

  return <String, dynamic>{
    if (offerId != null) 'offer_id': offerId,
    // other fields
  };
}

/// With pattern matching
Map<String, dynamic> _$SaveFavoriteCarPayloadToJson(SaveFavoriteCarPayload instance,) =>
    <String, dynamic>{
      if (instance.offerId case final value?) 'offer_id': value,
      // other fields
    };

/// With ??
String func(String? text) {
  return text ?? 'Text was null';
}
```

## Declaration order in classes

1. fields
1. getters and setters
1. constructors
1. methods
1. For all, the following rules apply:
    1. static above NON-static, because static belongs to the class, not the object
    1. override above NON-override, because override belongs to the descendant

## Access modifiers

By default, make everything private, following the principle of minimal necessary access

## General

1. Pass only named parameters to constructors
1. It's necessary to annotate fields and variables if the type is not obvious:
    - when we don't initialize immediately
    - when we initialize with a function or method
    - when we initialize with another field or variable

```dart
/// Example of obvious types
const a = 1; // literal
final b = SomeClass(); // constructor
final c = int.parse(); // factory method of base class

/// Example of non-obvious types
final SomeType d = SomeClass.someMethod(); // method or function
final SomeType e = otherVariable; // other variable or field
```
