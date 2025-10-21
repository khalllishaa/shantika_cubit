// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    ApplicationModel(
      minBookingHours: (json['min_booking_hours'] as num?)?.toInt(),
      maxBookingHours: (json['max_booking_hours'] as num?)?.toInt(),
      technicalMeetingPrice: (json['technical_meeting_price'] as num?)?.toInt(),
      includesMealsPrice: (json['includes_meals_price'] as num?)?.toInt(),
      adminFees: (json['admin_fees'] as num?)?.toInt(),
      xenditFee: (json['xendit_fee'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ApplicationModelToJson(ApplicationModel instance) =>
    <String, dynamic>{
      'min_booking_hours': instance.minBookingHours,
      'max_booking_hours': instance.maxBookingHours,
      'technical_meeting_price': instance.technicalMeetingPrice,
      'includes_meals_price': instance.includesMealsPrice,
      'admin_fees': instance.adminFees,
      'xendit_fee': instance.xenditFee,
    };
