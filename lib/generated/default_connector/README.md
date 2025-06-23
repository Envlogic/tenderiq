# default_connector SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
DefaultConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetRecommendedTenders
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getRecommendedTenders().execute();
```

#### Optional Arguments
We return a builder for each query. For GetRecommendedTenders, we created `GetRecommendedTendersBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class GetRecommendedTendersVariablesBuilder {
  ...
 
  GetRecommendedTendersVariablesBuilder limit(int? t) {
   _limit.value = t;
   return this;
  }
  GetRecommendedTendersVariablesBuilder offset(int? t) {
   _offset.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.getRecommendedTenders()
.limit(limit)
.offset(offset)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<GetRecommendedTendersData, GetRecommendedTendersVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getRecommendedTenders();
GetRecommendedTendersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getRecommendedTenders().ref();
ref.execute();

ref.subscribe(...);
```


### GetWatchlistTenders
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getWatchlistTenders().execute();
```

#### Optional Arguments
We return a builder for each query. For GetWatchlistTenders, we created `GetWatchlistTendersBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class GetWatchlistTendersVariablesBuilder {
  ...
 
  GetWatchlistTendersVariablesBuilder limit(int? t) {
   _limit.value = t;
   return this;
  }
  GetWatchlistTendersVariablesBuilder offset(int? t) {
   _offset.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.getWatchlistTenders()
.limit(limit)
.offset(offset)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<GetWatchlistTendersData, GetWatchlistTendersVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getWatchlistTenders();
GetWatchlistTendersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getWatchlistTenders().ref();
ref.execute();

ref.subscribe(...);
```


### GetFollowedTenderCount
#### Required Arguments
```dart
String userId = ...;
DefaultConnector.instance.getFollowedTenderCount(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetFollowedTenderCountData, GetFollowedTenderCountVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getFollowedTenderCount(
  userId: userId,
);
GetFollowedTenderCountData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = DefaultConnector.instance.getFollowedTenderCount(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetAllTenders
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllTenders().execute();
```

#### Optional Arguments
We return a builder for each query. For GetAllTenders, we created `GetAllTendersBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class GetAllTendersVariablesBuilder {
  ...
 
  GetAllTendersVariablesBuilder limit(int? t) {
   _limit.value = t;
   return this;
  }
  GetAllTendersVariablesBuilder offset(int? t) {
   _offset.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.getAllTenders()
.limit(limit)
.offset(offset)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<GetAllTendersData, GetAllTendersVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getAllTenders();
GetAllTendersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllTenders().ref();
ref.execute();

ref.subscribe(...);
```


### GetUserProfile
#### Required Arguments
```dart
String userId = ...;
DefaultConnector.instance.getUserProfile(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserProfileData, GetUserProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getUserProfile(
  userId: userId,
);
GetUserProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = DefaultConnector.instance.getUserProfile(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetNotifications
#### Required Arguments
```dart
String userId = ...;
DefaultConnector.instance.getNotifications(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetNotificationsData, GetNotificationsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getNotifications(
  userId: userId,
);
GetNotificationsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = DefaultConnector.instance.getNotifications(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetTenderDetails
#### Required Arguments
```dart
String tenderId = ...;
DefaultConnector.instance.getTenderDetails(
  tenderId: tenderId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For GetTenderDetails, we created `GetTenderDetailsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class GetTenderDetailsVariablesBuilder {
  ...
   GetTenderDetailsVariablesBuilder docLimit(int? t) {
   _docLimit.value = t;
   return this;
  }
  GetTenderDetailsVariablesBuilder docOffset(int? t) {
   _docOffset.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.getTenderDetails(
  tenderId: tenderId,
)
.docLimit(docLimit)
.docOffset(docOffset)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<GetTenderDetailsData, GetTenderDetailsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getTenderDetails(
  tenderId: tenderId,
);
GetTenderDetailsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String tenderId = ...;

final ref = DefaultConnector.instance.getTenderDetails(
  tenderId: tenderId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetAISearchContext
#### Required Arguments
```dart
String userId = ...;
DefaultConnector.instance.getAiSearchContext(
  userId: userId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For GetAISearchContext, we created `GetAISearchContextBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class GetAiSearchContextVariablesBuilder {
  ...
   GetAiSearchContextVariablesBuilder limit(int? t) {
   _limit.value = t;
   return this;
  }
  GetAiSearchContextVariablesBuilder offset(int? t) {
   _offset.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.getAiSearchContext(
  userId: userId,
)
.limit(limit)
.offset(offset)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<GetAISearchContextData, GetAISearchContextVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getAiSearchContext(
  userId: userId,
);
GetAISearchContextData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = DefaultConnector.instance.getAiSearchContext(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetAISuggestionContext
#### Required Arguments
```dart
String userId = ...;
DefaultConnector.instance.getAiSuggestionContext(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetAISuggestionContextData, GetAISuggestionContextVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getAiSuggestionContext(
  userId: userId,
);
GetAISuggestionContextData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = DefaultConnector.instance.getAiSuggestionContext(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### LogManualSearch
#### Required Arguments
```dart
String userId = ...;
String queryText = ...;
Timestamp timestamp = ...;
DefaultConnector.instance.logManualSearch(
  userId: userId,
  queryText: queryText,
  timestamp: timestamp,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<LogManualSearchData, LogManualSearchVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.logManualSearch(
  userId: userId,
  queryText: queryText,
  timestamp: timestamp,
);
LogManualSearchData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
String queryText = ...;
Timestamp timestamp = ...;

final ref = DefaultConnector.instance.logManualSearch(
  userId: userId,
  queryText: queryText,
  timestamp: timestamp,
).ref();
ref.execute();
```


### LogAISuggestionClick
#### Required Arguments
```dart
String userId = ...;
String queryText = ...;
Timestamp timestamp = ...;
DefaultConnector.instance.logAiSuggestionClick(
  userId: userId,
  queryText: queryText,
  timestamp: timestamp,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<LogAISuggestionClickData, LogAISuggestionClickVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.logAiSuggestionClick(
  userId: userId,
  queryText: queryText,
  timestamp: timestamp,
);
LogAISuggestionClickData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
String queryText = ...;
Timestamp timestamp = ...;

final ref = DefaultConnector.instance.logAiSuggestionClick(
  userId: userId,
  queryText: queryText,
  timestamp: timestamp,
).ref();
ref.execute();
```

