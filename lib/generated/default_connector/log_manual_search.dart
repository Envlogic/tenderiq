part of 'default.dart';

class LogManualSearchVariablesBuilder {
  String userId;
  String queryText;
  Timestamp timestamp;

  final FirebaseDataConnect _dataConnect;
  LogManualSearchVariablesBuilder(this._dataConnect, {required  this.userId,required  this.queryText,required  this.timestamp,});
  Deserializer<LogManualSearchData> dataDeserializer = (dynamic json)  => LogManualSearchData.fromJson(jsonDecode(json));
  Serializer<LogManualSearchVariables> varsSerializer = (LogManualSearchVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<LogManualSearchData, LogManualSearchVariables>> execute() {
    return ref().execute();
  }

  MutationRef<LogManualSearchData, LogManualSearchVariables> ref() {
    LogManualSearchVariables vars= LogManualSearchVariables(userId: userId,queryText: queryText,timestamp: timestamp,);
    return _dataConnect.mutation("LogManualSearch", dataDeserializer, varsSerializer, vars);
  }
}

class LogManualSearchManualSearchQueryInsert {
  String id;
  LogManualSearchManualSearchQueryInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  LogManualSearchManualSearchQueryInsert({
    required this.id,
  });
}

class LogManualSearchData {
  LogManualSearchManualSearchQueryInsert manualSearchQuery_insert;
  LogManualSearchData.fromJson(dynamic json):
  manualSearchQuery_insert = LogManualSearchManualSearchQueryInsert.fromJson(json['manualSearchQuery_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['manualSearchQuery_insert'] = manualSearchQuery_insert.toJson();
    return json;
  }

  LogManualSearchData({
    required this.manualSearchQuery_insert,
  });
}

class LogManualSearchVariables {
  String userId;
  String queryText;
  Timestamp timestamp;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  LogManualSearchVariables.fromJson(Map<String, dynamic> json):
  userId = nativeFromJson<String>(json['userId']),queryText = nativeFromJson<String>(json['queryText']),timestamp = Timestamp.fromJson(json['timestamp']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['queryText'] = nativeToJson<String>(queryText);
    json['timestamp'] = timestamp.toJson();
    return json;
  }

  LogManualSearchVariables({
    required this.userId,
    required this.queryText,
    required this.timestamp,
  });
}

