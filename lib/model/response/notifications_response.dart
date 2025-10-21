import 'package:json_annotation/json_annotation.dart';

import '../notification_model.dart';
part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationsResponse {
  int? unread;
  NotificationsResponseData? notifications;

  NotificationsResponse({this.unread});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) => _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}

@JsonSerializable()
class NotificationsResponseData {
  int? current_page;
  List<NotificationModel>? data;

  NotificationsResponseData({this.current_page, this.data});

  factory NotificationsResponseData.fromJson(Map<String, dynamic> json) => _$NotificationsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseDataToJson(this);
}
