part of 'default.dart';

class GetAllTendersVariablesBuilder {
  Optional<int> _limit = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _offset = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  GetAllTendersVariablesBuilder limit(int? t) {
   _limit.value = t;
   return this;
  }
  GetAllTendersVariablesBuilder offset(int? t) {
   _offset.value = t;
   return this;
  }

  GetAllTendersVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllTendersData> dataDeserializer = (dynamic json)  => GetAllTendersData.fromJson(jsonDecode(json));
  Serializer<GetAllTendersVariables> varsSerializer = (GetAllTendersVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetAllTendersData, GetAllTendersVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllTendersData, GetAllTendersVariables> ref() {
    GetAllTendersVariables vars= GetAllTendersVariables(limit: _limit,offset: _offset,);
    return _dataConnect.query("GetAllTenders", dataDeserializer, varsSerializer, vars);
  }
}

class GetAllTendersTenders {
  String id;
  String? title;
  List<String>? tags;
  String? location;
  Timestamp? closingDate;
  double? tenderAmount;
  GetAllTendersTendersWorkItemDetail? workItemDetail;
  GetAllTendersTenders.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),title = json['title'] == null ? null : nativeFromJson<String>(json['title']),tags = json['tags'] == null ? null : (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),location = json['location'] == null ? null : nativeFromJson<String>(json['location']),closingDate = json['closingDate'] == null ? null : Timestamp.fromJson(json['closingDate']),tenderAmount = json['tenderAmount'] == null ? null : nativeFromJson<double>(json['tenderAmount']),workItemDetail = json['workItemDetail'] == null ? null : GetAllTendersTendersWorkItemDetail.fromJson(json['workItemDetail']);

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

  GetAllTendersTenders({
    required this.id,
    this.title,
    this.tags,
    this.location,
    this.closingDate,
    this.tenderAmount,
    this.workItemDetail,
  });
}

class GetAllTendersTendersWorkItemDetail {
  String? description;
  GetAllTendersTendersWorkItemDetail.fromJson(dynamic json):
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    return json;
  }

  GetAllTendersTendersWorkItemDetail({
    this.description,
  });
}

class GetAllTendersData {
  List<GetAllTendersTenders> tenders;
  GetAllTendersData.fromJson(dynamic json):
  tenders = (json['tenders'] as List<dynamic>)
        .map((e) => GetAllTendersTenders.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tenders'] = tenders.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllTendersData({
    required this.tenders,
  });
}

class GetAllTendersVariables {
  late Optional<int>limit;
  late Optional<int>offset;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetAllTendersVariables.fromJson(Map<String, dynamic> json) {
  
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

  GetAllTendersVariables({
    required this.limit,
    required this.offset,
  });
}

