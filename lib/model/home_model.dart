import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  @JsonKey(name: "code")
  final int code;

  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "slider", defaultValue: [])
  final List<Artikel> slider;

  @JsonKey(name: "artikel", defaultValue: [])
  final List<Artikel> artikel;

  @JsonKey(name: "testimonials", defaultValue: [])
  final List<Testimonials> testimonials;

  @JsonKey(name: "customer_menu", defaultValue: [])
  final List<CustomerMenu> customerMenu;

  @JsonKey(name: "promo", defaultValue: [])
  final List<String> promo;

  @JsonKey(name: "pending_reviews", defaultValue: [])
  final List<PendingReview> pendingReviews;

  @JsonKey(name: "is_active_customer_order")
  final bool isActiveCustomerOrder;

  @JsonKey(name: "time_limit_before_order")
  final String timeLimitBeforeOrder;

  HomeModel({
    required this.code,
    required this.success,
    required this.message,
    this.slider = const [],
    this.artikel = const [],
    this.testimonials = const [],
    this.customerMenu = const [],
    this.promo = const [],
    this.pendingReviews = const [],
    required this.isActiveCustomerOrder,
    required this.timeLimitBeforeOrder,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

@JsonSerializable()
class Artikel {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "image")
  final String image;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "updated_at")
  final String updatedAt;

  @JsonKey(name: "type")
  final String? type;

  Artikel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.type,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) => _$ArtikelFromJson(json);
  Map<String, dynamic> toJson() => _$ArtikelToJson(this);
}

@JsonSerializable()
class CustomerMenu {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "icon")
  final String icon;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "updated_at")
  final String updatedAt;

  @JsonKey(name: "order")
  final int order;

  @JsonKey(name: "value")
  final String? value;

  @JsonKey(name: "type")
  final String type;

  CustomerMenu({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
    required this.order,
    this.value,
    required this.type,
  });

  factory CustomerMenu.fromJson(Map<String, dynamic> json) => _$CustomerMenuFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerMenuToJson(this);
}

@JsonSerializable()
class PendingReview {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "code_order")
  final String codeOrder;

  @JsonKey(name: "name_fleet")
  final String nameFleet;

  @JsonKey(name: "fleet_class")
  final String fleetClass;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "departure_at")
  final String departureAt;

  @JsonKey(name: "price")
  final int price;

  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "checkpoints")
  final Checkpoints checkpoints;

  PendingReview({
    required this.id,
    required this.codeOrder,
    required this.nameFleet,
    required this.fleetClass,
    required this.createdAt,
    required this.departureAt,
    required this.price,
    required this.status,
    required this.checkpoints,
  });

  factory PendingReview.fromJson(Map<String, dynamic> json) => _$PendingReviewFromJson(json);
  Map<String, dynamic> toJson() => _$PendingReviewToJson(this);
}

@JsonSerializable()
class Checkpoints {
  @JsonKey(name: "start")
  final Destination start;

  @JsonKey(name: "destination")
  final Destination destination;

  @JsonKey(name: "end")
  final Destination end;

  Checkpoints({
    required this.start,
    required this.destination,
    required this.end,
  });

  factory Checkpoints.fromJson(Map<String, dynamic> json) => _$CheckpointsFromJson(json);
  Map<String, dynamic> toJson() => _$CheckpointsToJson(this);
}

@JsonSerializable()
class Destination {
  @JsonKey(name: "agency_id")
  final int agencyId;

  @JsonKey(name: "agency_name")
  final String agencyName;

  @JsonKey(name: "agency_address")
  final String agencyAddress;

  @JsonKey(name: "agency_phone")
  final String agencyPhone;

  @JsonKey(name: "agency_lat")
  final String agencyLat;

  @JsonKey(name: "agency_lng")
  final String agencyLng;

  @JsonKey(name: "city_name")
  final String cityName;

  Destination({
    required this.agencyId,
    required this.agencyName,
    required this.agencyAddress,
    required this.agencyPhone,
    required this.agencyLat,
    required this.agencyLng,
    required this.cityName,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => _$DestinationFromJson(json);
  Map<String, dynamic> toJson() => _$DestinationToJson(this);
}

@JsonSerializable()
class Testimonials {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "user_id")
  final int userId;

  @JsonKey(name: "image")
  final String image;

  @JsonKey(name: "review")
  final String review;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "updated_at")
  final String updatedAt;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "name_customer")
  final String nameCustomer;

  Testimonials({
    required this.id,
    required this.userId,
    required this.image,
    required this.review,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.nameCustomer,
  });

  factory Testimonials.fromJson(Map<String, dynamic> json) => _$TestimonialsFromJson(json);
  Map<String, dynamic> toJson() => _$TestimonialsToJson(this);
}

