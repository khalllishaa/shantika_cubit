import 'package:json_annotation/json_annotation.dart';

part 'firebase_error_log_model.g.dart';

@JsonSerializable()
class FirebaseErrorLogModel {
  String message;
  String device;
  String? path;
  String date;
  String token;
  Map<String, dynamic> user;
  String appVersion;
  String? stackTrace;

  FirebaseErrorLogModel(
      {required this.message,
      required this.device,
      this.path,
      required this.date,
      required this.token,
      required this.user,
      required this.appVersion,
      this.stackTrace});

  factory FirebaseErrorLogModel.fromJson(Map<String, dynamic> json) => _$FirebaseErrorLogModelFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseErrorLogModelToJson(this);
}
