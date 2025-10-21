// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardModel _$GuardModelFromJson(Map<String, dynamic> json) => GuardModel(
      id: json['id'] as String?,
      vendorId: json['vendor_id'] as String?,
      guardClassId: json['guard_class_id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      whatsapp: json['whatsapp'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      isActive: json['is_active'] as bool?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      gender: json['gender'] as String?,
      isFavoriteGuard: json['is_favorite_guard'] as bool?,
      guardClass: json['guard_class'] == null
          ? null
          : GuardClassModel.fromJson(
              json['guard_class'] as Map<String, dynamic>),
      isGuardRecomendation: json['is_guard_recommendation'] as bool?,
      guard_skills: (json['guard_skills'] as List<dynamic>?)
          ?.map((e) => GuardSkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfGuard: (json['number_of_guard'] as num?)?.toInt(),
      isIncludeMeals: json['is_includes_meals'] as bool?,
      isTechicalMeeting: json['is_technical_meeting'] as bool?,
      securityObjective: json['security_objectives'] as String?,
    );

Map<String, dynamic> _$GuardModelToJson(GuardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vendor_id': instance.vendorId,
      'guard_class_id': instance.guardClassId,
      'name': instance.name,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'whatsapp': instance.whatsapp,
      'email': instance.email,
      'address': instance.address,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_active': instance.isActive,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'gender': instance.gender,
      'is_favorite_guard': instance.isFavoriteGuard,
      'guard_class': instance.guardClass,
      'guard_skills': instance.guard_skills,
      'is_guard_recommendation': instance.isGuardRecomendation,
      'number_of_guard': instance.numberOfGuard,
      'security_objectives': instance.securityObjective,
      'is_technical_meeting': instance.isTechicalMeeting,
      'is_includes_meals': instance.isIncludeMeals,
    };

GuardClassModel _$GuardClassModelFromJson(Map<String, dynamic> json) =>
    GuardClassModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      hourlyPrice: (json['hourly_price'] as num?)?.toInt(),
      dailyPrice: (json['daily_price'] as num?)?.toInt(),
      isActive: json['is_active'] as bool?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'],
      guard_skills: (json['guard_skills'] as List<dynamic>?)
          ?.map((e) => GuardSkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GuardClassModelToJson(GuardClassModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'hourly_price': instance.hourlyPrice,
      'daily_price': instance.dailyPrice,
      'is_active': instance.isActive,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'guard_skills': instance.guard_skills,
    };

GuardSkillModel _$GuardSkillModelFromJson(Map<String, dynamic> json) =>
    GuardSkillModel(
      id: json['id'] as String?,
      guardId: json['guard_id'] as String?,
      name: json['name'] as String?,
      is_skilled: json['is_skilled'] as bool?,
    );

Map<String, dynamic> _$GuardSkillModelToJson(GuardSkillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'guard_id': instance.guardId,
      'name': instance.name,
      'is_skilled': instance.is_skilled,
    };
