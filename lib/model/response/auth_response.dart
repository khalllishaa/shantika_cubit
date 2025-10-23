// import 'package:json_annotation/json_annotation.dart';
// import '../user_model.dart';
//
// part 'auth_response.g.dart';
//
// @JsonSerializable()
// class AuthResponse {
//   @JsonKey(name: "code")
//   int? code;
//
//   @JsonKey(name: "success")
//   bool? success;
//
//   @JsonKey(name: "message")
//   String? message;
//
//   @JsonKey(name: "data")
//   AuthData? data;
//
//   AuthResponse({
//     this.code,
//     this.success,
//     this.message,
//     this.data,
//   });
//
//   factory AuthResponse.fromJson(Map<String, dynamic> json) =>
//       _$AuthResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
//
//   // ✅ Helper getters untuk backward compatibility
//   String? get token => data?.token;
//   UserModel? get user => data?.user;
// }
//
// @JsonSerializable()
// class AuthData {
//   @JsonKey(name: "user")
//   UserModel? user;
//
//   @JsonKey(name: "token")
//   String? token;
//
//   AuthData({
//     this.user,
//     this.token,
//   });
//
//   factory AuthData.fromJson(Map<String, dynamic> json) =>
//       _$AuthDataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AuthDataToJson(this);
// }

import 'package:json_annotation/json_annotation.dart';
import '../users_model.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "user")
  UsersModel? user;

  @JsonKey(name: "token")
  String? token;

  AuthResponse({
    this.code,
    this.success,
    this.message,
    this.user,
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}