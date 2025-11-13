import 'package:json_annotation/json_annotation.dart';

part 'agency_model.g.dart';

@JsonSerializable()
class AgencyCityResponse {
  final int code;
  final bool success;
  final String message;

  @JsonKey(name: "agencies_city")
  final List<AgencyCity> agenciesCity;

  AgencyCityResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.agenciesCity,
  });

  factory AgencyCityResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyCityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyCityResponseToJson(this);
}

@JsonSerializable()
class AgencyCity {
  final int id;
  final String name;

  AgencyCity({
    required this.id,
    required this.name,
  });

  factory AgencyCity.fromJson(Map<String, dynamic> json) =>
      _$AgencyCityFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyCityToJson(this);
}
