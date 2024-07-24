import 'dart:convert';

ResetPasswordReq resetPasswordReqFromJson(String str) =>
    ResetPasswordReq.fromJson(json.decode(str));

String resetPasswordReqToJson(ResetPasswordReq data) =>
    json.encode(data.toJson());

class ResetPasswordReq {
  final String? email;

  ResetPasswordReq({
    this.email,
  });

  factory ResetPasswordReq.fromJson(Map<String, dynamic> json) =>
      ResetPasswordReq(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
