import 'dart:convert';

List<AllAgentsRes> allAgentsResFromJson(String str) => List<AllAgentsRes>.from(
    json.decode(str).map((x) => AllAgentsRes.fromJson(x)));

String allAgentsResToJson(List<AllAgentsRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllAgentsRes {
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

  AllAgentsRes({
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

  factory AllAgentsRes.fromJson(Map<String, dynamic> json) => AllAgentsRes(
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
