part of 'default.dart';

class GetAiSearchContextVariablesBuilder {
  String userId;
  Optional<int> _limit = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _offset = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  GetAiSearchContextVariablesBuilder limit(int? t) {
   _limit.value = t;
   return this;
  }
  GetAiSearchContextVariablesBuilder offset(int? t) {
   _offset.value = t;
   return this;
  }

  GetAiSearchContextVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetAiSearchContextData> dataDeserializer = (dynamic json)  => GetAiSearchContextData.fromJson(jsonDecode(json));
  Serializer<GetAiSearchContextVariables> varsSerializer = (GetAiSearchContextVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetAiSearchContextData, GetAiSearchContextVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetAiSearchContextData, GetAiSearchContextVariables> ref() {
    GetAiSearchContextVariables vars= GetAiSearchContextVariables(userId: userId,limit: _limit,offset: _offset,);
    return _dataConnect.query("GetAISearchContext", dataDeserializer, varsSerializer, vars);
  }
}

class GetAiSearchContextUser {
  String id;
  String? fullName;
  String? email;
  String? profilePicUrl;
  GetAiSearchContextUserPreferences? preferences;
  GetAiSearchContextUserActivity? activity;
  List<GetAiSearchContextUserManualSearchQueriesOnUser> manualSearchQueries_on_user;
  List<GetAiSearchContextUserAiSuggestedQueryClicksOnUser> aiSuggestedQueryClicks_on_user;
  GetAiSearchContextUser.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),fullName = json['fullName'] == null ? null : nativeFromJson<String>(json['fullName']),email = json['email'] == null ? null : nativeFromJson<String>(json['email']),profilePicUrl = json['profilePicUrl'] == null ? null : nativeFromJson<String>(json['profilePicUrl']),preferences = json['preferences'] == null ? null : GetAiSearchContextUserPreferences.fromJson(json['preferences']),activity = json['activity'] == null ? null : GetAiSearchContextUserActivity.fromJson(json['activity']),manualSearchQueries_on_user = (json['manualSearchQueries_on_user'] as List<dynamic>)
        .map((e) => GetAiSearchContextUserManualSearchQueriesOnUser.fromJson(e))
        .toList(),aiSuggestedQueryClicks_on_user = (json['aiSuggestedQueryClicks_on_user'] as List<dynamic>)
        .map((e) => GetAiSearchContextUserAiSuggestedQueryClicksOnUser.fromJson(e))
        .toList();

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
    if (preferences != null) {
      json['preferences'] = preferences!.toJson();
    }
    if (activity != null) {
      json['activity'] = activity!.toJson();
    }
    json['manualSearchQueries_on_user'] = manualSearchQueries_on_user.map((e) => e.toJson()).toList();
    json['aiSuggestedQueryClicks_on_user'] = aiSuggestedQueryClicks_on_user.map((e) => e.toJson()).toList();
    return json;
  }

  GetAiSearchContextUser({
    required this.id,
    this.fullName,
    this.email,
    this.profilePicUrl,
    this.preferences,
    this.activity,
    required this.manualSearchQueries_on_user,
    required this.aiSuggestedQueryClicks_on_user,
  });
}

class GetAiSearchContextUserPreferences {
  List<String>? preferredCategories;
  List<String>? preferredLocations;
  bool? notificationEnabled;
  String? language;
  GetAiSearchContextUserPreferences.fromJson(dynamic json):
  preferredCategories = json['preferredCategories'] == null ? null : (json['preferredCategories'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),preferredLocations = json['preferredLocations'] == null ? null : (json['preferredLocations'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),notificationEnabled = json['notificationEnabled'] == null ? null : nativeFromJson<bool>(json['notificationEnabled']),language = json['language'] == null ? null : nativeFromJson<String>(json['language']);

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
    if (language != null) {
      json['language'] = nativeToJson<String?>(language);
    }
    return json;
  }

  GetAiSearchContextUserPreferences({
    this.preferredCategories,
    this.preferredLocations,
    this.notificationEnabled,
    this.language,
  });
}

class GetAiSearchContextUserActivity {
  int? tendersFollowed;
  int? tendersSubmitted;
  GetAiSearchContextUserActivity.fromJson(dynamic json):
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

  GetAiSearchContextUserActivity({
    this.tendersFollowed,
    this.tendersSubmitted,
  });
}

class GetAiSearchContextUserManualSearchQueriesOnUser {
  String queryText;
  Timestamp timestamp;
  GetAiSearchContextUserManualSearchQueriesOnUser.fromJson(dynamic json):
  queryText = nativeFromJson<String>(json['queryText']),timestamp = Timestamp.fromJson(json['timestamp']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['queryText'] = nativeToJson<String>(queryText);
    json['timestamp'] = timestamp.toJson();
    return json;
  }

  GetAiSearchContextUserManualSearchQueriesOnUser({
    required this.queryText,
    required this.timestamp,
  });
}

class GetAiSearchContextUserAiSuggestedQueryClicksOnUser {
  String queryText;
  Timestamp timestamp;
  GetAiSearchContextUserAiSuggestedQueryClicksOnUser.fromJson(dynamic json):
  queryText = nativeFromJson<String>(json['queryText']),timestamp = Timestamp.fromJson(json['timestamp']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['queryText'] = nativeToJson<String>(queryText);
    json['timestamp'] = timestamp.toJson();
    return json;
  }

  GetAiSearchContextUserAiSuggestedQueryClicksOnUser({
    required this.queryText,
    required this.timestamp,
  });
}

class GetAiSearchContextTenders {
  String id;
  String? title;
  List<String>? tags;
  String? location;
  double? tenderAmount;
  Timestamp? closingDate;
  GetAiSearchContextTendersTenderCategory? tenderCategory;
  GetAiSearchContextTendersWorkItemDetail? workItemDetail;
  GetAiSearchContextTendersAiRecommendation? aiRecommendation;
  GetAiSearchContextTendersRiskAlertFlag? riskAlertFlag;
  GetAiSearchContextTendersOrganization organization;
  GetAiSearchContextTenders.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),title = json['title'] == null ? null : nativeFromJson<String>(json['title']),tags = json['tags'] == null ? null : (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),location = json['location'] == null ? null : nativeFromJson<String>(json['location']),tenderAmount = json['tenderAmount'] == null ? null : nativeFromJson<double>(json['tenderAmount']),closingDate = json['closingDate'] == null ? null : Timestamp.fromJson(json['closingDate']),tenderCategory = json['tenderCategory'] == null ? null : GetAiSearchContextTendersTenderCategory.fromJson(json['tenderCategory']),workItemDetail = json['workItemDetail'] == null ? null : GetAiSearchContextTendersWorkItemDetail.fromJson(json['workItemDetail']),aiRecommendation = json['aiRecommendation'] == null ? null : GetAiSearchContextTendersAiRecommendation.fromJson(json['aiRecommendation']),riskAlertFlag = json['riskAlertFlag'] == null ? null : GetAiSearchContextTendersRiskAlertFlag.fromJson(json['riskAlertFlag']),organization = GetAiSearchContextTendersOrganization.fromJson(json['organization']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (title != null) {
      json['title'] = nativeToJson<String?>(title);
    }
    if (tags != null) {
      json['tags'] = tags?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (location != null) {
      json['location'] = nativeToJson<String?>(location);
    }
    if (tenderAmount != null) {
      json['tenderAmount'] = nativeToJson<double?>(tenderAmount);
    }
    if (closingDate != null) {
      json['closingDate'] = closingDate!.toJson();
    }
    if (tenderCategory != null) {
      json['tenderCategory'] = tenderCategory!.toJson();
    }
    if (workItemDetail != null) {
      json['workItemDetail'] = workItemDetail!.toJson();
    }
    if (aiRecommendation != null) {
      json['aiRecommendation'] = aiRecommendation!.toJson();
    }
    if (riskAlertFlag != null) {
      json['riskAlertFlag'] = riskAlertFlag!.toJson();
    }
    json['organization'] = organization.toJson();
    return json;
  }

  GetAiSearchContextTenders({
    required this.id,
    this.title,
    this.tags,
    this.location,
    this.tenderAmount,
    this.closingDate,
    this.tenderCategory,
    this.workItemDetail,
    this.aiRecommendation,
    this.riskAlertFlag,
    required this.organization,
  });
}

class GetAiSearchContextTendersTenderCategory {
  String? tenderCategory;
  GetAiSearchContextTendersTenderCategory.fromJson(dynamic json):
  tenderCategory = json['tenderCategory'] == null ? null : nativeFromJson<String>(json['tenderCategory']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (tenderCategory != null) {
      json['tenderCategory'] = nativeToJson<String?>(tenderCategory);
    }
    return json;
  }

  GetAiSearchContextTendersTenderCategory({
    this.tenderCategory,
  });
}

class GetAiSearchContextTendersWorkItemDetail {
  String? title;
  String? description;
  String? productCategory;
  String? contractType;
  GetAiSearchContextTendersWorkItemDetail.fromJson(dynamic json):
  title = json['title'] == null ? null : nativeFromJson<String>(json['title']),description = json['description'] == null ? null : nativeFromJson<String>(json['description']),productCategory = json['productCategory'] == null ? null : nativeFromJson<String>(json['productCategory']),contractType = json['contractType'] == null ? null : nativeFromJson<String>(json['contractType']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (title != null) {
      json['title'] = nativeToJson<String?>(title);
    }
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    if (productCategory != null) {
      json['productCategory'] = nativeToJson<String?>(productCategory);
    }
    if (contractType != null) {
      json['contractType'] = nativeToJson<String?>(contractType);
    }
    return json;
  }

  GetAiSearchContextTendersWorkItemDetail({
    this.title,
    this.description,
    this.productCategory,
    this.contractType,
  });
}

class GetAiSearchContextTendersAiRecommendation {
  double? fitScore;
  String? matchingCriteriaSummary;
  GetAiSearchContextTendersAiRecommendation.fromJson(dynamic json):
  fitScore = json['fitScore'] == null ? null : nativeFromJson<double>(json['fitScore']),matchingCriteriaSummary = json['matchingCriteriaSummary'] == null ? null : nativeFromJson<String>(json['matchingCriteriaSummary']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (fitScore != null) {
      json['fitScore'] = nativeToJson<double?>(fitScore);
    }
    if (matchingCriteriaSummary != null) {
      json['matchingCriteriaSummary'] = nativeToJson<String?>(matchingCriteriaSummary);
    }
    return json;
  }

  GetAiSearchContextTendersAiRecommendation({
    this.fitScore,
    this.matchingCriteriaSummary,
  });
}

class GetAiSearchContextTendersRiskAlertFlag {
  String? redFlags;
  String? orangeFlags;
  String? yellowFlags;
  GetAiSearchContextTendersRiskAlertFlag.fromJson(dynamic json):
  redFlags = json['redFlags'] == null ? null : nativeFromJson<String>(json['redFlags']),orangeFlags = json['orangeFlags'] == null ? null : nativeFromJson<String>(json['orangeFlags']),yellowFlags = json['yellowFlags'] == null ? null : nativeFromJson<String>(json['yellowFlags']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (redFlags != null) {
      json['redFlags'] = nativeToJson<String?>(redFlags);
    }
    if (orangeFlags != null) {
      json['orangeFlags'] = nativeToJson<String?>(orangeFlags);
    }
    if (yellowFlags != null) {
      json['yellowFlags'] = nativeToJson<String?>(yellowFlags);
    }
    return json;
  }

  GetAiSearchContextTendersRiskAlertFlag({
    this.redFlags,
    this.orangeFlags,
    this.yellowFlags,
  });
}

class GetAiSearchContextTendersOrganization {
  String name;
  GetAiSearchContextTendersOrganization.fromJson(dynamic json):
  name = nativeFromJson<String>(json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetAiSearchContextTendersOrganization({
    required this.name,
  });
}

class GetAiSearchContextData {
  GetAiSearchContextUser? user;
  List<GetAiSearchContextTenders> tenders;
  GetAiSearchContextData.fromJson(dynamic json):
  user = json['user'] == null ? null : GetAiSearchContextUser.fromJson(json['user']),tenders = (json['tenders'] as List<dynamic>)
        .map((e) => GetAiSearchContextTenders.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    json['tenders'] = tenders.map((e) => e.toJson()).toList();
    return json;
  }

  GetAiSearchContextData({
    this.user,
    required this.tenders,
  });
}

class GetAiSearchContextVariables {
  String userId;
  late Optional<int>limit;
  late Optional<int>offset;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetAiSearchContextVariables.fromJson(Map<String, dynamic> json):
  userId = nativeFromJson<String>(json['userId']) {
  
    limit = Optional.optional(nativeFromJson, nativeToJson);
    limit.value = json['limit'] == null ? null : nativeFromJson<int>(json['limit']);
  
    offset = Optional.optional(nativeFromJson, nativeToJson);
    offset.value = json['offset'] == null ? null : nativeFromJson<int>(json['offset']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    if(limit.state == OptionalState.set) {
      json['limit'] = limit.toJson();
    }
    if(offset.state == OptionalState.set) {
      json['offset'] = offset.toJson();
    }
    return json;
  }

  GetAiSearchContextVariables({
    required this.userId,
    required this.limit,
    required this.offset,
  });
}

