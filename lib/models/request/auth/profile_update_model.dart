import 'dart:convert';

ProfileUpdateReq profileUpdateReqFromJson(String str) =>
    ProfileUpdateReq.fromJson(json.decode(str));

String profileUpdateReqToJson(ProfileUpdateReq data) =>
    json.encode(data.toJson());

class ProfileUpdateReq {
  ProfileUpdateReq({
    required this.location,
    required this.phone,
    required this.profile,
    required this.skills,
    required this.cv,
  });

  final String location;
  final String phone;
  final String profile;
  final String cv;
  final List<String> skills;

  factory ProfileUpdateReq.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateReq(
        location: json["location"],
        phone: json["phone"],
        profile: json["profile"],
        cv: json["cv"],
        skills: List<String>.from(json["skills"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "phone": phone,
        "profile": profile,
        "cv": cv,
        "skills": List<dynamic>.from(skills.map((x) => x)),
      };
}
