part of 'default.dart';

class LogAiSuggestionClickVariablesBuilder {
  String userId;
  String queryText;
  Timestamp timestamp;

  final FirebaseDataConnect _dataConnect;
  LogAiSuggestionClickVariablesBuilder(this._dataConnect, {required  this.userId,required  this.queryText,required  this.timestamp,});
  Deserializer<LogAiSuggestionClickData> dataDeserializer = (dynamic json)  => LogAiSuggestionClickData.fromJson(jsonDecode(json));
  Serializer<LogAiSuggestionClickVariables> varsSerializer = (LogAiSuggestionClickVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<LogAiSuggestionClickData, LogAiSuggestionClickVariables>> execute() {
    return ref().execute();
  }

  MutationRef<LogAiSuggestionClickData, LogAiSuggestionClickVariables> ref() {
    LogAiSuggestionClickVariables vars= LogAiSuggestionClickVariables(userId: userId,queryText: queryText,timestamp: timestamp,);
    return _dataConnect.mutation("LogAISuggestionClick", dataDeserializer, varsSerializer, vars);
  }
}

class LogAiSuggestionClickAiSuggestedQueryClickInsert {
  String id;
  LogAiSuggestionClickAiSuggestedQueryClickInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  LogAiSuggestionClickAiSuggestedQueryClickInsert({
    required this.id,
  });
}

class LogAiSuggestionClickData {
  LogAiSuggestionClickAiSuggestedQueryClickInsert aiSuggestedQueryClick_insert;
  LogAiSuggestionClickData.fromJson(dynamic json):
  aiSuggestedQueryClick_insert = LogAiSuggestionClickAiSuggestedQueryClickInsert.fromJson(json['aiSuggestedQueryClick_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['aiSuggestedQueryClick_insert'] = aiSuggestedQueryClick_insert.toJson();
    return json;
  }

  LogAiSuggestionClickData({
    required this.aiSuggestedQueryClick_insert,
  });
}

class LogAiSuggestionClickVariables {
  String userId;
  String queryText;
  Timestamp timestamp;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  LogAiSuggestionClickVariables.fromJson(Map<String, dynamic> json):
  userId = nativeFromJson<String>(json['userId']),queryText = nativeFromJson<String>(json['queryText']),timestamp = Timestamp.fromJson(json['timestamp']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['queryText'] = nativeToJson<String>(queryText);
    json['timestamp'] = timestamp.toJson();
    return json;
  }

  LogAiSuggestionClickVariables({
    required this.userId,
    required this.queryText,
    required this.timestamp,
  });
}

