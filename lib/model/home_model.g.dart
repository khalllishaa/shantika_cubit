// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
  code: (json['code'] as num).toInt(),
  success: json['success'] as bool,
  message: json['message'] as String,
  slider: (json['slider'] as List<dynamic>)
      .map((e) => Artikel.fromJson(e as Map<String, dynamic>))
      .toList(),
  artikel: (json['artikel'] as List<dynamic>)
      .map((e) => Artikel.fromJson(e as Map<String, dynamic>))
      .toList(),
  testimonial: json['testimonial'] as List<dynamic>,
  customerMenu: (json['customer_menu'] as List<dynamic>)
      .map((e) => CustomerMenu.fromJson(e as Map<String, dynamic>))
      .toList(),
  promo: json['promo'] as List<dynamic>,
  pendingReviews: (json['pending_reviews'] as List<dynamic>)
      .map((e) => PendingReview.fromJson(e as Map<String, dynamic>))
      .toList(),
  isActiveCustomerOrder: json['is_active_customer_order'] as bool,
  timeLimitBeforeOrder: json['time_limit_before_order'] as String,
);

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
  'code': instance.code,
  'success': instance.success,
  'message': instance.message,
  'slider': instance.slider,
  'artikel': instance.artikel,
  'testimonial': instance.testimonial,
  'customer_menu': instance.customerMenu,
  'promo': instance.promo,
  'pending_reviews': instance.pendingReviews,
  'is_active_customer_order': instance.isActiveCustomerOrder,
  'time_limit_before_order': instance.timeLimitBeforeOrder,
};

Artikel _$ArtikelFromJson(Map<String, dynamic> json) => Artikel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  image: json['image'] as String,
  description: json['description'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  type: json['type'] as String?,
);

Map<String, dynamic> _$ArtikelToJson(Artikel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': instance.image,
  'description': instance.description,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'type': instance.type,
};

CustomerMenu _$CustomerMenuFromJson(Map<String, dynamic> json) => CustomerMenu(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  icon: json['icon'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  order: (json['order'] as num).toInt(),
  value: json['value'] as String?,
  type: json['type'] as String,
);

Map<String, dynamic> _$CustomerMenuToJson(CustomerMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'order': instance.order,
      'value': instance.value,
      'type': instance.type,
    };

PendingReview _$PendingReviewFromJson(Map<String, dynamic> json) =>
    PendingReview(
      id: (json['id'] as num).toInt(),
      codeOrder: json['code_order'] as String,
      nameFleet: json['name_fleet'] as String,
      fleetClass: json['fleet_class'] as String,
      createdAt: json['created_at'] as String,
      departureAt: json['departure_at'] as String,
      price: (json['price'] as num).toInt(),
      status: json['status'] as String,
      checkpoints: Checkpoints.fromJson(
        json['checkpoints'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PendingReviewToJson(PendingReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code_order': instance.codeOrder,
      'name_fleet': instance.nameFleet,
      'fleet_class': instance.fleetClass,
      'created_at': instance.createdAt,
      'departure_at': instance.departureAt,
      'price': instance.price,
      'status': instance.status,
      'checkpoints': instance.checkpoints,
    };

Checkpoints _$CheckpointsFromJson(Map<String, dynamic> json) => Checkpoints(
  start: Destination.fromJson(json['start'] as Map<String, dynamic>),
  destination: Destination.fromJson(
    json['destination'] as Map<String, dynamic>,
  ),
  end: Destination.fromJson(json['end'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CheckpointsToJson(Checkpoints instance) =>
    <String, dynamic>{
      'start': instance.start,
      'destination': instance.destination,
      'end': instance.end,
    };

Destination _$DestinationFromJson(Map<String, dynamic> json) => Destination(
  agencyId: (json['agency_id'] as num).toInt(),
  agencyName: json['agency_name'] as String,
  agencyAddress: json['agency_address'] as String,
  agencyPhone: json['agency_phone'] as String,
  agencyLat: json['agency_lat'] as String,
  agencyLng: json['agency_lng'] as String,
  cityName: json['city_name'] as String,
);

Map<String, dynamic> _$DestinationToJson(Destination instance) =>
    <String, dynamic>{
      'agency_id': instance.agencyId,
      'agency_name': instance.agencyName,
      'agency_address': instance.agencyAddress,
      'agency_phone': instance.agencyPhone,
      'agency_lat': instance.agencyLat,
      'agency_lng': instance.agencyLng,
      'city_name': instance.cityName,
    };
