import 'dart:convert';

SignUpAgent signUpAgentFromJson(String str) =>
    SignUpAgent.fromJson(json.decode(str));

String signUpAgentToJson(SignUpAgent data) => json.encode(data.toJson());

class SignUpAgent {
  final String? username;
  final String? email;
  final String? password;
  final bool? isAgent;

  SignUpAgent({
    this.username,
    this.email,
    this.password,
    this.isAgent,
  });

  factory SignUpAgent.fromJson(Map<String, dynamic> json) => SignUpAgent(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        isAgent: json["isAgent"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "isAgent": isAgent,
      };
}
