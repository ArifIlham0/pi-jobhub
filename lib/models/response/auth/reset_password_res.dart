import 'dart:convert';

ResetPasswordRes resetPasswordResFromJson(String str) =>
    ResetPasswordRes.fromJson(json.decode(str));

String resetPasswordResToJson(ResetPasswordRes data) =>
    json.encode(data.toJson());

class ResetPasswordRes {
  final String? message;
  final String? token;

  ResetPasswordRes({
    this.message,
    this.token,
  });

  factory ResetPasswordRes.fromJson(Map<String, dynamic> json) =>
      ResetPasswordRes(
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
      };
}
