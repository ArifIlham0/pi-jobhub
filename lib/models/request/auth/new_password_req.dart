import 'dart:convert';

NewPasswordReq newPasswordReqFromJson(String str) =>
    NewPasswordReq.fromJson(json.decode(str));

String newPasswordReqToJson(NewPasswordReq data) => json.encode(data.toJson());

class NewPasswordReq {
  final String? password;

  NewPasswordReq({
    this.password,
  });

  factory NewPasswordReq.fromJson(Map<String, dynamic> json) => NewPasswordReq(
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
      };
}
