import 'dart:convert';

ProfileRes profileResFromJson(String str) =>
    ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
  ProfileRes({
    required this.id,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.isAgent,
    required this.skills,
    // required this.updatedAt,
    required this.location,
    required this.phone,
    required this.profile,
    required this.cv,
  });

  final String id;
  final String username;
  final String email;
  final bool isAdmin;
  final bool isAgent;
  final List<String> skills;
  // final DateTime updatedAt;
  final String location;
  final String phone;
  final String profile;
  final String cv;

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        id: json["_id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        isAdmin: json["isAdmin"] ?? false,
        isAgent: json["isAgent"] ?? false,
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"].map((x) => x)),
        // updatedAt: DateTime.parse(json["updatedAt"]) ?? DateTime.now(),
        location: json["location"] ?? "",
        phone: json["phone"] ?? "",
        profile: json["profile"] ?? "",
        cv: json["cv"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        // "updatedAt": updatedAt.toIso8601String(),
        "location": location,
        "phone": phone,
        "profile": profile,
        "cv": cv,
      };
}
