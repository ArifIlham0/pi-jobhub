import 'dart:convert';

List<AllUsersRes> allUsersResFromJson(String str) => List<AllUsersRes>.from(
    json.decode(str).map((x) => AllUsersRes.fromJson(x)));

String allUsersResToJson(List<AllUsersRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllUsersRes {
  final bool? isPending;
  final String? id;
  final String? username;
  final String? email;
  final bool? isAdmin;
  final bool? isAgent;
  final List<String>? skills;
  final String? profile;
  final String? location;
  final String? phone;

  AllUsersRes({
    this.isPending,
    this.id,
    this.username,
    this.email,
    this.isAdmin,
    this.isAgent,
    this.skills,
    this.profile,
    this.location,
    this.phone,
  });

  factory AllUsersRes.fromJson(Map<String, dynamic> json) => AllUsersRes(
        isPending: json["isPending"],
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        profile: json["profile"],
        location: json["location"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "isPending": isPending,
        "_id": id,
        "username": username,
        "email": email,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skills": List<dynamic>.from(skills!.map((x) => x)),
        "profile": profile,
        "location": location,
        "phone": phone,
      };
}
