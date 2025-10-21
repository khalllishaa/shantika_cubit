import 'package:json_annotation/json_annotation.dart';
import '../user_model.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  UserModel? user;
  String? token;

  AuthResponse();

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
