import 'dart:convert';

List<PendingUserResponse> pendingUserResponseFromJson(String str) =>
    List<PendingUserResponse>.from(
        json.decode(str).map((x) => PendingUserResponse.fromJson(x)));

String pendingUserResponseToJson(List<PendingUserResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingUserResponse {
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final bool? isAdmin;
  final bool? isAgent;
  final bool? isPending;
  final List<bool>? skills;
  final String? address;
  final String? website;
  final String? profile;
  final String? cv;

  PendingUserResponse({
    this.id,
    this.username,
    this.email,
    this.password,
    this.isAdmin,
    this.isAgent,
    this.isPending,
    this.skills,
    this.address,
    this.website,
    this.profile,
    this.cv,
  });

  factory PendingUserResponse.fromJson(Map<String, dynamic> json) =>
      PendingUserResponse(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        isPending: json["isPending"],
        skills: List<bool>.from(json["skills"].map((x) => x)),
        address: json["address"],
        website: json["website"],
        profile: json["profile"],
        cv: json["cv"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "isPending": isPending,
        "skills": List<dynamic>.from(skills!.map((x) => x)),
        "address": address,
        "website": website,
        "profile": profile,
        "cv": cv,
      };
}
