// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsResponse _$NotificationsResponseFromJson(
  Map<String, dynamic> json,
) => NotificationsResponse(unread: (json['unread'] as num?)?.toInt())
  ..notifications = json['notifications'] == null
      ? null
      : NotificationsResponseData.fromJson(
          json['notifications'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$NotificationsResponseToJson(
  NotificationsResponse instance,
) => <String, dynamic>{
  'unread': instance.unread,
  'notifications': instance.notifications,
};

NotificationsResponseData _$NotificationsResponseDataFromJson(
  Map<String, dynamic> json,
) => NotificationsResponseData(
  current_page: (json['current_page'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NotificationsResponseDataToJson(
  NotificationsResponseData instance,
) => <String, dynamic>{
  'current_page': instance.current_page,
  'data': instance.data,
};
