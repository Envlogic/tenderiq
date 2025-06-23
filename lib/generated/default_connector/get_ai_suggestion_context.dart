part of 'default.dart';

class GetAiSuggestionContextVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetAiSuggestionContextVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetAiSuggestionContextData> dataDeserializer = (dynamic json)  => GetAiSuggestionContextData.fromJson(jsonDecode(json));
  Serializer<GetAiSuggestionContextVariables> varsSerializer = (GetAiSuggestionContextVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetAiSuggestionContextData, GetAiSuggestionContextVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetAiSuggestionContextData, GetAiSuggestionContextVariables> ref() {
    GetAiSuggestionContextVariables vars= GetAiSuggestionContextVariables(userId: userId,);
    return _dataConnect.query("GetAISuggestionContext", dataDeserializer, varsSerializer, vars);
  }
}

class GetAiSuggestionContextUser {
  String id;
  String? fullName;
  String? email;
  String? profilePicUrl;
  GetAiSuggestionContextUserPreferences? preferences;
  GetAiSuggestionContextUserActivity? activity;
  GetAiSuggestionContextUserCompany company;
  List<GetAiSuggestionContextUserManualSearchQueriesOnUser> manualSearchQueries_on_user;
  List<GetAiSuggestionContextUserAiSuggestedQueryClicksOnUser> aiSuggestedQueryClicks_on_user;
  GetAiSuggestionContextUser.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),fullName = json['fullName'] == null ? null : nativeFromJson<String>(json['fullName']),email = json['email'] == null ? null : nativeFromJson<String>(json['email']),profilePicUrl = json['profilePicUrl'] == null ? null : nativeFromJson<String>(json['profilePicUrl']),preferences = json['preferences'] == null ? null : GetAiSuggestionContextUserPreferences.fromJson(json['preferences']),activity = json['activity'] == null ? null : GetAiSuggestionContextUserActivity.fromJson(json['activity']),company = GetAiSuggestionContextUserCompany.fromJson(json['company']),manualSearchQueries_on_user = (json['manualSearchQueries_on_user'] as List<dynamic>)
        .map((e) => GetAiSuggestionContextUserManualSearchQueriesOnUser.fromJson(e))
        .toList(),aiSuggestedQueryClicks_on_user = (json['aiSuggestedQueryClicks_on_user'] as List<dynamic>)
        .map((e) => GetAiSuggestionContextUserAiSuggestedQueryClicksOnUser.fromJson(e))
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
    json['company'] = company.toJson();
    json['manualSearchQueries_on_user'] = manualSearchQueries_on_user.map((e) => e.toJson()).toList();
    json['aiSuggestedQueryClicks_on_user'] = aiSuggestedQueryClicks_on_user.map((e) => e.toJson()).toList();
    return json;
  }

  GetAiSuggestionContextUser({
    required this.id,
    this.fullName,
    this.email,
    this.profilePicUrl,
    this.preferences,
    this.activity,
    required this.company,
    required this.manualSearchQueries_on_user,
    required this.aiSuggestedQueryClicks_on_user,
  });
}

class GetAiSuggestionContextUserPreferences {
  List<String>? preferredCategories;
  List<String>? preferredLocations;
  GetAiSuggestionContextUserPreferences.fromJson(dynamic json):
  preferredCategories = json['preferredCategories'] == null ? null : (json['preferredCategories'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),preferredLocations = json['preferredLocations'] == null ? null : (json['preferredLocations'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (preferredCategories != null) {
      json['preferredCategories'] = preferredCategories?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (preferredLocations != null) {
      json['preferredLocations'] = preferredLocations?.map((e) => nativeToJson<String>(e)).toList();
    }
    return json;
  }

  GetAiSuggestionContextUserPreferences({
    this.preferredCategories,
    this.preferredLocations,
  });
}

class GetAiSuggestionContextUserActivity {
  int? tendersFollowed;
  int? tendersSubmitted;
  GetAiSuggestionContextUserActivity.fromJson(dynamic json):
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

  GetAiSuggestionContextUserActivity({
    this.tendersFollowed,
    this.tendersSubmitted,
  });
}

class GetAiSuggestionContextUserCompany {
  String? name;
  String? gstin;
  String? contactNumber;
  List<GetAiSuggestionContextUserCompanyCompanyBidStatssOnCompany> companyBidStatss_on_company;
  GetAiSuggestionContextUserCompany.fromJson(dynamic json):
  name = json['name'] == null ? null : nativeFromJson<String>(json['name']),gstin = json['gstin'] == null ? null : nativeFromJson<String>(json['gstin']),contactNumber = json['contactNumber'] == null ? null : nativeFromJson<String>(json['contactNumber']),companyBidStatss_on_company = (json['companyBidStatss_on_company'] as List<dynamic>)
        .map((e) => GetAiSuggestionContextUserCompanyCompanyBidStatssOnCompany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (name != null) {
      json['name'] = nativeToJson<String?>(name);
    }
    if (gstin != null) {
      json['gstin'] = nativeToJson<String?>(gstin);
    }
    if (contactNumber != null) {
      json['contactNumber'] = nativeToJson<String?>(contactNumber);
    }
    json['companyBidStatss_on_company'] = companyBidStatss_on_company.map((e) => e.toJson()).toList();
    return json;
  }

  GetAiSuggestionContextUserCompany({
    this.name,
    this.gstin,
    this.contactNumber,
    required this.companyBidStatss_on_company,
  });
}

class GetAiSuggestionContextUserCompanyCompanyBidStatssOnCompany {
  int? totalTenders;
  int? tendersWon;
  double? winRatePct;
  double? averageTenderValue;
  double? averageBidAmount;
  List<String>? topCategories;
  List<String>? activeCategories;
  String? recentTenderRangeBucket;
  GetAiSuggestionContextUserCompanyCompanyBidStatssOnCompany.fromJson(dynamic json):
  totalTenders = json['totalTenders'] == null ? null : nativeFromJson<int>(json['totalTenders']),tendersWon = json['tendersWon'] == null ? null : nativeFromJson<int>(json['tendersWon']),winRatePct = json['winRatePct'] == null ? null : nativeFromJson<double>(json['winRatePct']),averageTenderValue = json['averageTenderValue'] == null ? null : nativeFromJson<double>(json['averageTenderValue']),averageBidAmount = json['averageBidAmount'] == null ? null : nativeFromJson<double>(json['averageBidAmount']),topCategories = json['topCategories'] == null ? null : (json['topCategories'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),activeCategories = json['activeCategories'] == null ? null : (json['activeCategories'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),recentTenderRangeBucket = json['recentTenderRangeBucket'] == null ? null : nativeFromJson<String>(json['recentTenderRangeBucket']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (totalTenders != null) {
      json['totalTenders'] = nativeToJson<int?>(totalTenders);
    }
    if (tendersWon != null) {
      json['tendersWon'] = nativeToJson<int?>(tendersWon);
    }
    if (winRatePct != null) {
      json['winRatePct'] = nativeToJson<double?>(winRatePct);
    }
    if (averageTenderValue != null) {
      json['averageTenderValue'] = nativeToJson<double?>(averageTenderValue);
    }
    if (averageBidAmount != null) {
      json['averageBidAmount'] = nativeToJson<double?>(averageBidAmount);
    }
    if (topCategories != null) {
      json['topCategories'] = topCategories?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (activeCategories != null) {
      json['activeCategories'] = activeCategories?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (recentTenderRangeBucket != null) {
      json['recentTenderRangeBucket'] = nativeToJson<String?>(recentTenderRangeBucket);
    }
    return json;
  }

  GetAiSuggestionContextUserCompanyCompanyBidStatssOnCompany({
    this.totalTenders,
    this.tendersWon,
    this.winRatePct,
    this.averageTenderValue,
    this.averageBidAmount,
    this.topCategories,
    this.activeCategories,
    this.recentTenderRangeBucket,
  });
}

class GetAiSuggestionContextUserManualSearchQueriesOnUser {
  String queryText;
  Timestamp timestamp;
  GetAiSuggestionContextUserManualSearchQueriesOnUser.fromJson(dynamic json):
  queryText = nativeFromJson<String>(json['queryText']),timestamp = Timestamp.fromJson(json['timestamp']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['queryText'] = nativeToJson<String>(queryText);
    json['timestamp'] = timestamp.toJson();
    return json;
  }

  GetAiSuggestionContextUserManualSearchQueriesOnUser({
    required this.queryText,
    required this.timestamp,
  });
}

class GetAiSuggestionContextUserAiSuggestedQueryClicksOnUser {
  String queryText;
  Timestamp timestamp;
  GetAiSuggestionContextUserAiSuggestedQueryClicksOnUser.fromJson(dynamic json):
  queryText = nativeFromJson<String>(json['queryText']),timestamp = Timestamp.fromJson(json['timestamp']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['queryText'] = nativeToJson<String>(queryText);
    json['timestamp'] = timestamp.toJson();
    return json;
  }

  GetAiSuggestionContextUserAiSuggestedQueryClicksOnUser({
    required this.queryText,
    required this.timestamp,
  });
}

class GetAiSuggestionContextTenderBidHistories {
  double? bidAmount;
  double? tenderValue;
  String bidStatus;
  Timestamp? submittedAt;
  String? participationType;
  String? remarks;
  GetAiSuggestionContextTenderBidHistoriesTender tender;
  GetAiSuggestionContextTenderBidHistories.fromJson(dynamic json):
  bidAmount = json['bidAmount'] == null ? null : nativeFromJson<double>(json['bidAmount']),tenderValue = json['tenderValue'] == null ? null : nativeFromJson<double>(json['tenderValue']),bidStatus = nativeFromJson<String>(json['bidStatus']),submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),participationType = json['participationType'] == null ? null : nativeFromJson<String>(json['participationType']),remarks = json['remarks'] == null ? null : nativeFromJson<String>(json['remarks']),tender = GetAiSuggestionContextTenderBidHistoriesTender.fromJson(json['tender']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (bidAmount != null) {
      json['bidAmount'] = nativeToJson<double?>(bidAmount);
    }
    if (tenderValue != null) {
      json['tenderValue'] = nativeToJson<double?>(tenderValue);
    }
    json['bidStatus'] = nativeToJson<String>(bidStatus);
    if (submittedAt != null) {
      json['submittedAt'] = submittedAt!.toJson();
    }
    if (participationType != null) {
      json['participationType'] = nativeToJson<String?>(participationType);
    }
    if (remarks != null) {
      json['remarks'] = nativeToJson<String?>(remarks);
    }
    json['tender'] = tender.toJson();
    return json;
  }

  GetAiSuggestionContextTenderBidHistories({
    this.bidAmount,
    this.tenderValue,
    required this.bidStatus,
    this.submittedAt,
    this.participationType,
    this.remarks,
    required this.tender,
  });
}

class GetAiSuggestionContextTenderBidHistoriesTender {
  String id;
  String? title;
  List<String>? tags;
  String? location;
  Timestamp? closingDate;
  GetAiSuggestionContextTenderBidHistoriesTenderBasicDetail? basicDetail;
  GetAiSuggestionContextTenderBidHistoriesTenderWorkItemDetail? workItemDetail;
  GetAiSuggestionContextTenderBidHistoriesTender.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),title = json['title'] == null ? null : nativeFromJson<String>(json['title']),tags = json['tags'] == null ? null : (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),location = json['location'] == null ? null : nativeFromJson<String>(json['location']),closingDate = json['closingDate'] == null ? null : Timestamp.fromJson(json['closingDate']),basicDetail = json['basicDetail'] == null ? null : GetAiSuggestionContextTenderBidHistoriesTenderBasicDetail.fromJson(json['basicDetail']),workItemDetail = json['workItemDetail'] == null ? null : GetAiSuggestionContextTenderBidHistoriesTenderWorkItemDetail.fromJson(json['workItemDetail']);

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
    if (closingDate != null) {
      json['closingDate'] = closingDate!.toJson();
    }
    if (basicDetail != null) {
      json['basicDetail'] = basicDetail!.toJson();
    }
    if (workItemDetail != null) {
      json['workItemDetail'] = workItemDetail!.toJson();
    }
    return json;
  }

  GetAiSuggestionContextTenderBidHistoriesTender({
    required this.id,
    this.title,
    this.tags,
    this.location,
    this.closingDate,
    this.basicDetail,
    this.workItemDetail,
  });
}

class GetAiSuggestionContextTenderBidHistoriesTenderBasicDetail {
  String? tenderCategory;
  GetAiSuggestionContextTenderBidHistoriesTenderBasicDetail.fromJson(dynamic json):
  tenderCategory = json['tenderCategory'] == null ? null : nativeFromJson<String>(json['tenderCategory']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (tenderCategory != null) {
      json['tenderCategory'] = nativeToJson<String?>(tenderCategory);
    }
    return json;
  }

  GetAiSuggestionContextTenderBidHistoriesTenderBasicDetail({
    this.tenderCategory,
  });
}

class GetAiSuggestionContextTenderBidHistoriesTenderWorkItemDetail {
  String? productCategory;
  String? description;
  GetAiSuggestionContextTenderBidHistoriesTenderWorkItemDetail.fromJson(dynamic json):
  productCategory = json['productCategory'] == null ? null : nativeFromJson<String>(json['productCategory']),description = json['description'] == null ? null : nativeFromJson<String>(json['description']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (productCategory != null) {
      json['productCategory'] = nativeToJson<String?>(productCategory);
    }
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    return json;
  }

  GetAiSuggestionContextTenderBidHistoriesTenderWorkItemDetail({
    this.productCategory,
    this.description,
  });
}

class GetAiSuggestionContextData {
  GetAiSuggestionContextUser? user;
  List<GetAiSuggestionContextTenderBidHistories> tenderBidHistories;
  GetAiSuggestionContextData.fromJson(dynamic json):
  user = json['user'] == null ? null : GetAiSuggestionContextUser.fromJson(json['user']),tenderBidHistories = (json['tenderBidHistories'] as List<dynamic>)
        .map((e) => GetAiSuggestionContextTenderBidHistories.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    json['tenderBidHistories'] = tenderBidHistories.map((e) => e.toJson()).toList();
    return json;
  }

  GetAiSuggestionContextData({
    this.user,
    required this.tenderBidHistories,
  });
}

class GetAiSuggestionContextVariables {
  String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetAiSuggestionContextVariables.fromJson(Map<String, dynamic> json):
  userId = nativeFromJson<String>(json['userId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetAiSuggestionContextVariables({
    required this.userId,
  });
}

