import 'dart:convert';

UpdateAgentReq updateAgentReqFromJson(String str) =>
    UpdateAgentReq.fromJson(json.decode(str));

String updateAgentReqToJson(UpdateAgentReq data) => json.encode(data.toJson());

class UpdateAgentReq {
  UpdateAgentReq({
    required this.location,
    required this.phone,
    required this.profile,
    required this.isPending,
    required this.skills,
    required this.cv,
  });

  final String location;
  final String phone;
  final bool isPending;
  final String profile;
  final String cv;
  final List<String> skills;

  factory UpdateAgentReq.fromJson(Map<String, dynamic> json) => UpdateAgentReq(
        location: json["location"],
        phone: json["phone"],
        isPending: json["isPending"],
        profile: json["profile"],
        cv: json["cv"],
        skills: List<String>.from(json["skills"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "phone": phone,
        "isPending": isPending,
        "profile": profile,
        "cv": cv,
        "skills": List<dynamic>.from(skills.map((x) => x)),
      };
}
