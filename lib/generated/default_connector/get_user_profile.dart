part of 'default.dart';

class GetUserProfileVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetUserProfileVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetUserProfileData> dataDeserializer = (dynamic json)  => GetUserProfileData.fromJson(jsonDecode(json));
  Serializer<GetUserProfileVariables> varsSerializer = (GetUserProfileVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserProfileData, GetUserProfileVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserProfileData, GetUserProfileVariables> ref() {
    GetUserProfileVariables vars= GetUserProfileVariables(userId: userId,);
    return _dataConnect.query("GetUserProfile", dataDeserializer, varsSerializer, vars);
  }
}

class GetUserProfileUser {
  String id;
  String? fullName;
  String? email;
  String? profilePicUrl;
  GetUserProfileUserCompany company;
  GetUserProfileUserPreferences? preferences;
  GetUserProfileUserActivity? activity;
  GetUserProfileUser.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),fullName = json['fullName'] == null ? null : nativeFromJson<String>(json['fullName']),email = json['email'] == null ? null : nativeFromJson<String>(json['email']),profilePicUrl = json['profilePicUrl'] == null ? null : nativeFromJson<String>(json['profilePicUrl']),company = GetUserProfileUserCompany.fromJson(json['company']),preferences = json['preferences'] == null ? null : GetUserProfileUserPreferences.fromJson(json['preferences']),activity = json['activity'] == null ? null : GetUserProfileUserActivity.fromJson(json['activity']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (fullName != null) {
      json['fullName'] = nativeToJson<String?>(fullName);
    }
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    if (profilePicUrl != null) {
      json['profilePicUrl'] = nativeToJson<String?>(profilePicUrl);
    }
    json['company'] = company.toJson();
    if (preferences != null) {
      json['preferences'] = preferences!.toJson();
    }
    if (activity != null) {
      json['activity'] = activity!.toJson();
    }
    return json;
  }

  GetUserProfileUser({
    required this.id,
    this.fullName,
    this.email,
    this.profilePicUrl,
    required this.company,
    this.preferences,
    this.activity,
  });
}

class GetUserProfileUserCompany {
  String? name;
  GetUserProfileUserCompany.fromJson(dynamic json):
  name = json['name'] == null ? null : nativeFromJson<String>(json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (name != null) {
      json['name'] = nativeToJson<String?>(name);
    }
    return json;
  }

  GetUserProfileUserCompany({
    this.name,
  });
}

class GetUserProfileUserPreferences {
  List<String>? preferredCategories;
  List<String>? preferredLocations;
  bool? notificationEnabled;
  GetUserProfileUserPreferences.fromJson(dynamic json):
  preferredCategories = json['preferredCategories'] == null ? null : (json['preferredCategories'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),preferredLocations = json['preferredLocations'] == null ? null : (json['preferredLocations'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),notificationEnabled = json['notificationEnabled'] == null ? null : nativeFromJson<bool>(json['notificationEnabled']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (preferredCategories != null) {
      json['preferredCategories'] = preferredCategories?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (preferredLocations != null) {
      json['preferredLocations'] = preferredLocations?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (notificationEnabled != null) {
      json['notificationEnabled'] = nativeToJson<bool?>(notificationEnabled);
    }
    return json;
  }

  GetUserProfileUserPreferences({
    this.preferredCategories,
    this.preferredLocations,
    this.notificationEnabled,
  });
}

class GetUserProfileUserActivity {
  int? tendersFollowed;
  int? tendersSubmitted;
  GetUserProfileUserActivity.fromJson(dynamic json):
  tendersFollowed = json['tendersFollowed'] == null ? null : nativeFromJson<int>(json['tendersFollowed']),tendersSubmitted = json['tendersSubmitted'] == null ? null : nativeFromJson<int>(json['tendersSubmitted']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (tendersFollowed != null) {
      json['tendersFollowed'] = nativeToJson<int?>(tendersFollowed);
    }
    if (tendersSubmitted != null) {
      json['tendersSubmitted'] = nativeToJson<int?>(tendersSubmitted);
    }
    return json;
  }

  GetUserProfileUserActivity({
    this.tendersFollowed,
    this.tendersSubmitted,
  });
}

class GetUserProfileData {
  GetUserProfileUser? user;
  GetUserProfileData.fromJson(dynamic json):
  user = json['user'] == null ? null : GetUserProfileUser.fromJson(json['user']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetUserProfileData({
    this.user,
  });
}

class GetUserProfileVariables {
  String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserProfileVariables.fromJson(Map<String, dynamic> json):
  userId = nativeFromJson<String>(json['userId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetUserProfileVariables({
    required this.userId,
  });
}

