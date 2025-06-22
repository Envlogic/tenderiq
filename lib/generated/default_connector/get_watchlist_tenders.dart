part of 'default.dart';

class GetWatchlistTendersVariablesBuilder {
  Optional<int> _limit = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _offset = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  GetWatchlistTendersVariablesBuilder limit(int? t) {
   _limit.value = t;
   return this;
  }
  GetWatchlistTendersVariablesBuilder offset(int? t) {
   _offset.value = t;
   return this;
  }

  GetWatchlistTendersVariablesBuilder(this._dataConnect, );
  Deserializer<GetWatchlistTendersData> dataDeserializer = (dynamic json)  => GetWatchlistTendersData.fromJson(jsonDecode(json));
  Serializer<GetWatchlistTendersVariables> varsSerializer = (GetWatchlistTendersVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetWatchlistTendersData, GetWatchlistTendersVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetWatchlistTendersData, GetWatchlistTendersVariables> ref() {
    GetWatchlistTendersVariables vars= GetWatchlistTendersVariables(limit: _limit,offset: _offset,);
    return _dataConnect.query("GetWatchlistTenders", dataDeserializer, varsSerializer, vars);
  }
}

class GetWatchlistTendersTenders {
  String id;
  String? title;
  List<String>? tags;
  String? location;
  Timestamp? closingDate;
  double? tenderAmount;
  GetWatchlistTendersTendersWorkItemDetail? workItemDetail;
  GetWatchlistTendersTenders.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),title = json['title'] == null ? null : nativeFromJson<String>(json['title']),tags = json['tags'] == null ? null : (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),location = json['location'] == null ? null : nativeFromJson<String>(json['location']),closingDate = json['closingDate'] == null ? null : Timestamp.fromJson(json['closingDate']),tenderAmount = json['tenderAmount'] == null ? null : nativeFromJson<double>(json['tenderAmount']),workItemDetail = json['workItemDetail'] == null ? null : GetWatchlistTendersTendersWorkItemDetail.fromJson(json['workItemDetail']);

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

  GetWatchlistTendersTenders({
    required this.id,
    this.title,
    this.tags,
    this.location,
    this.closingDate,
    this.tenderAmount,
    this.workItemDetail,
  });
}

class GetWatchlistTendersTendersWorkItemDetail {
  String? description;
  GetWatchlistTendersTendersWorkItemDetail.fromJson(dynamic json):
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    return json;
  }

  GetWatchlistTendersTendersWorkItemDetail({
    this.description,
  });
}

class GetWatchlistTendersData {
  List<GetWatchlistTendersTenders> tenders;
  GetWatchlistTendersData.fromJson(dynamic json):
  tenders = (json['tenders'] as List<dynamic>)
        .map((e) => GetWatchlistTendersTenders.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tenders'] = tenders.map((e) => e.toJson()).toList();
    return json;
  }

  GetWatchlistTendersData({
    required this.tenders,
  });
}

class GetWatchlistTendersVariables {
  late Optional<int>limit;
  late Optional<int>offset;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetWatchlistTendersVariables.fromJson(Map<String, dynamic> json) {
  
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

  GetWatchlistTendersVariables({
    required this.limit,
    required this.offset,
  });
}

