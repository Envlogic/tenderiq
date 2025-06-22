part of 'default.dart';

class GetNotificationsVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetNotificationsVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetNotificationsData> dataDeserializer = (dynamic json)  => GetNotificationsData.fromJson(jsonDecode(json));
  Serializer<GetNotificationsVariables> varsSerializer = (GetNotificationsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetNotificationsData, GetNotificationsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetNotificationsData, GetNotificationsVariables> ref() {
    GetNotificationsVariables vars= GetNotificationsVariables(userId: userId,);
    return _dataConnect.query("GetNotifications", dataDeserializer, varsSerializer, vars);
  }
}

class GetNotificationsNotifications {
  String id;
  String message;
  bool isRead;
  Timestamp createdAt;
  String? link;
  GetNotificationsNotifications.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),message = nativeFromJson<String>(json['message']),isRead = nativeFromJson<bool>(json['isRead']),createdAt = Timestamp.fromJson(json['createdAt']),link = json['link'] == null ? null : nativeFromJson<String>(json['link']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['message'] = nativeToJson<String>(message);
    json['isRead'] = nativeToJson<bool>(isRead);
    json['createdAt'] = createdAt.toJson();
    if (link != null) {
      json['link'] = nativeToJson<String?>(link);
    }
    return json;
  }

  GetNotificationsNotifications({
    required this.id,
    required this.message,
    required this.isRead,
    required this.createdAt,
    this.link,
  });
}

class GetNotificationsData {
  List<GetNotificationsNotifications> notifications;
  GetNotificationsData.fromJson(dynamic json):
  notifications = (json['notifications'] as List<dynamic>)
        .map((e) => GetNotificationsNotifications.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['notifications'] = notifications.map((e) => e.toJson()).toList();
    return json;
  }

  GetNotificationsData({
    required this.notifications,
  });
}

class GetNotificationsVariables {
  String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetNotificationsVariables.fromJson(Map<String, dynamic> json):
  userId = nativeFromJson<String>(json['userId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetNotificationsVariables({
    required this.userId,
  });
}

