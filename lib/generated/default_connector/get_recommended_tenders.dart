part of 'default.dart';

class GetRecommendedTendersVariablesBuilder {
  Optional<int> _limit = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _offset = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  GetRecommendedTendersVariablesBuilder limit(int? t) {
   _limit.value = t;
   return this;
  }
  GetRecommendedTendersVariablesBuilder offset(int? t) {
   _offset.value = t;
   return this;
  }

  GetRecommendedTendersVariablesBuilder(this._dataConnect, );
  Deserializer<GetRecommendedTendersData> dataDeserializer = (dynamic json)  => GetRecommendedTendersData.fromJson(jsonDecode(json));
  Serializer<GetRecommendedTendersVariables> varsSerializer = (GetRecommendedTendersVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetRecommendedTendersData, GetRecommendedTendersVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetRecommendedTendersData, GetRecommendedTendersVariables> ref() {
    GetRecommendedTendersVariables vars= GetRecommendedTendersVariables(limit: _limit,offset: _offset,);
    return _dataConnect.query("GetRecommendedTenders", dataDeserializer, varsSerializer, vars);
  }
}

class GetRecommendedTendersTenders {
  String id;
  String? title;
  List<String>? tags;
  String? location;
  Timestamp? closingDate;
  double? tenderAmount;
  GetRecommendedTendersTendersWorkItemDetail? workItemDetail;
  GetRecommendedTendersTenders.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),title = json['title'] == null ? null : nativeFromJson<String>(json['title']),tags = json['tags'] == null ? null : (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),location = json['location'] == null ? null : nativeFromJson<String>(json['location']),closingDate = json['closingDate'] == null ? null : Timestamp.fromJson(json['closingDate']),tenderAmount = json['tenderAmount'] == null ? null : nativeFromJson<double>(json['tenderAmount']),workItemDetail = json['workItemDetail'] == null ? null : GetRecommendedTendersTendersWorkItemDetail.fromJson(json['workItemDetail']);

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
    if (tenderAmount != null) {
      json['tenderAmount'] = nativeToJson<double?>(tenderAmount);
    }
    if (workItemDetail != null) {
      json['workItemDetail'] = workItemDetail!.toJson();
    }
    return json;
  }

  GetRecommendedTendersTenders({
    required this.id,
    this.title,
    this.tags,
    this.location,
    this.closingDate,
    this.tenderAmount,
    this.workItemDetail,
  });
}

class GetRecommendedTendersTendersWorkItemDetail {
  String? description;
  GetRecommendedTendersTendersWorkItemDetail.fromJson(dynamic json):
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    return json;
  }

  GetRecommendedTendersTendersWorkItemDetail({
    this.description,
  });
}

class GetRecommendedTendersData {
  List<GetRecommendedTendersTenders> tenders;
  GetRecommendedTendersData.fromJson(dynamic json):
  tenders = (json['tenders'] as List<dynamic>)
        .map((e) => GetRecommendedTendersTenders.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tenders'] = tenders.map((e) => e.toJson()).toList();
    return json;
  }

  GetRecommendedTendersData({
    required this.tenders,
  });
}

class GetRecommendedTendersVariables {
  late Optional<int>limit;
  late Optional<int>offset;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetRecommendedTendersVariables.fromJson(Map<String, dynamic> json) {
  
    limit = Optional.optional(nativeFromJson, nativeToJson);
    limit.value = json['limit'] == null ? null : nativeFromJson<int>(json['limit']);
  
    offset = Optional.optional(nativeFromJson, nativeToJson);
    offset.value = json['offset'] == null ? null : nativeFromJson<int>(json['offset']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(limit.state == OptionalState.set) {
      json['limit'] = limit.toJson();
    }
    if(offset.state == OptionalState.set) {
      json['offset'] = offset.toJson();
    }
    return json;
  }

  GetRecommendedTendersVariables({
    required this.limit,
    required this.offset,
  });
}

