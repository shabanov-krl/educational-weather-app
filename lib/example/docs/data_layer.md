# Data Layer

## Overview

The data layer, as the name suggests, is designed to manage and retrieve data. It includes:

- Data Sources
- Repositories

### Equatable

All DTOs and Models must implement Equatable for ALL! fields to ensure they can be correctly compared

## Data Source

Acting as the base layer of the Data Layer, Data Sources are tasked with retrieving data directly from specific sources, such as databases or APIs.

Data Sources provide DTOs (Data Transfer Objects), which are lightweight structures that encapsulate data without associated business logic.

An example Data Source might be represented as:

```dart
class UserDataSource {
  Future<UserDto> getUser(String id);
}
```

### DTO

The backend uses objects to transfer information in responses that can be reused between different APIs.
On the client side, the same objects should be used as on the backend to maintain consistency with changes and to easily find the needed class in the code.

For example, if the backend uses `PictureResponse` in 10 APIs, and the client has different classes for parsing responses from these APIs, then when the backend adds a new field to `PictureResponse` in one place, it will need to be done in 10 different places on the client.

We have naming conventions for entities in the data layer, such as [Response](/lib/core/utils/error_handling/base_api_response_with_error.dart), [Dto](/docs/architecture.md), [Model](/docs/architecture.md). If an object from the backend is named in a way that breaks these conventions, we should name it according to our conventions, but add the original backend name in the class comment so it can be found through search.

### Exceptions

1. For DioException, the stack trace should be taken from error.stackTrace as it is more informative than the stackTrace from catch (error, stackTrace)
2. Server response errors should be handled in the data source and custom error objects should be thrown up the stack, so that the higher layer knows nothing about the data source implementation

### Json serialization

1. If a date comes from the backend, set the corresponding DTO field type as DateTime, not String, when using `json_serializable`. Under the hood it will do DateTime.parse itself and it will be more convenient to work with DateTime in other layers.
2. If swagger specifies that a String with a set of values will come - effectively an enum - then an enum should also be used in the DTO, not String. Under the hood `json_serializable` will handle the String to enum conversion.
3. For all enums used in json, a default value should be provided in case something unknown comes in. Otherwise serialization will fail. This can be done using unknownEnumValue in JsonKey for example.
4. If a relative path comes from the backend, it should be made absolute at the DTO level if possible to avoid having to do this work elsewhere. For example, if an image path comes in as /profile/id/avatar/, add <https://some-domain> to it.

## Repository

Located a layer above, Repositories handle data retrieved from underlying Data Sources. They are the only component aware of these Data Sources.

A Repository can interact with multiple Data Sources, combining data as needed. A typical use case might involve combining data from two different sources.

Repositories can use a reactive paradigm, using streams to efficiently synchronize data between BLoCs.

Unlike Data Sources, which return DTOs, Repositories typically provide Models. Models not only contain data but also encapsulate some logic, offering capabilities to work with this data.

Here's a typical Repository:

```dart
class UserRepository {
  Future<UserModel> getUser(String id);
}
```

The Repository is responsible for operations on a single business entity.
For example, `AppointmentsRepository` allows operations with appointments, `ReviewsRepository` - with reviews.
If there are two pages, one displaying a list of appointments and the second showing appointment details, there will be one Repository - `AppointmentsRepository`, as it's tied to data, not to who and how uses it.

| 🦄 Tip                                                                                                                                                                                                                                                                                                                                                    |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| All repository's and data source's methods should be async. For example in current implementation of cache uses sync methods, in future they may be changed for async. In this case data source, repository and all dependent code will be affected. It's a bad architecture when changes in the data source implementation affect the whole application. |
