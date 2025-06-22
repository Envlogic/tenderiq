part of 'default.dart';

class GetFollowedTenderCountVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetFollowedTenderCountVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetFollowedTenderCountData> dataDeserializer = (dynamic json)  => GetFollowedTenderCountData.fromJson(jsonDecode(json));
  Serializer<GetFollowedTenderCountVariables> varsSerializer = (GetFollowedTenderCountVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetFollowedTenderCountData, GetFollowedTenderCountVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetFollowedTenderCountData, GetFollowedTenderCountVariables> ref() {
    GetFollowedTenderCountVariables vars= GetFollowedTenderCountVariables(userId: userId,);
    return _dataConnect.query("GetFollowedTenderCount", dataDeserializer, varsSerializer, vars);
  }
}

class GetFollowedTenderCountUser {
  GetFollowedTenderCountUserActivity? activity;
  GetFollowedTenderCountUser.fromJson(dynamic json):
  activity = json['activity'] == null ? null : GetFollowedTenderCountUserActivity.fromJson(json['activity']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (activity != null) {
      json['activity'] = activity!.toJson();
    }
    return json;
  }

  GetFollowedTenderCountUser({
    this.activity,
  });
}

class GetFollowedTenderCountUserActivity {
  int? tendersFollowed;
  GetFollowedTenderCountUserActivity.fromJson(dynamic json):
  tendersFollowed = json['tendersFollowed'] == null ? null : nativeFromJson<int>(json['tendersFollowed']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (tendersFollowed != null) {
      json['tendersFollowed'] = nativeToJson<int?>(tendersFollowed);
    }
    return json;
  }

  GetFollowedTenderCountUserActivity({
    this.tendersFollowed,
  });
}

class GetFollowedTenderCountData {
  GetFollowedTenderCountUser? user;
  GetFollowedTenderCountData.fromJson(dynamic json):
  user = json['user'] == null ? null : GetFollowedTenderCountUser.fromJson(json['user']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetFollowedTenderCountData({
    this.user,
  });
}

class GetFollowedTenderCountVariables {
  String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetFollowedTenderCountVariables.fromJson(Map<String, dynamic> json):
  userId = nativeFromJson<String>(json['userId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetFollowedTenderCountVariables({
    required this.userId,
  });
}

