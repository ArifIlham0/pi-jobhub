import 'dart:convert';

List<AllBookmarks> allBookmarksFromJson(String str) => List<AllBookmarks>.from(
    json.decode(str).map((x) => AllBookmarks.fromJson(x)));

String allBookmarksToJson(List<AllBookmarks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBookmarks {
  final String? id;
  final Job? job;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  AllBookmarks({
    this.id,
    this.job,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AllBookmarks.fromJson(Map<String, dynamic> json) => AllBookmarks(
        id: json["_id"],
        job: json["job"] != null ? Job.fromJson(json["job"]) : null,
        userId: json["userId"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "job": job?.toJson(),
        "userId": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Job {
  final String? id;
  final String? title;
  final String? category;
  final String? location;
  final String? description;
  final String? company;
  final String? salary;
  final String? period;
  final String? contract;
  final List<String>? requirements;
  final String? imageUrl;
  final String? agentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Job({
    this.id,
    this.title,
    this.category,
    this.location,
    this.description,
    this.company,
    this.salary,
    this.period,
    this.contract,
    this.requirements,
    this.imageUrl,
    this.agentId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        title: json["title"],
        category: json["category"],
        location: json["location"],
        description: json["description"],
        company: json["company"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirements: json["requirements"] != null
            ? List<String>.from(json["requirements"].map((x) => x))
            : null,
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "category": category,
        "location": location,
        "description": description,
        "company": company,
        "salary": salary,
        "period": period,
        "contract": contract,
        "requirements": requirements != null
            ? List<dynamic>.from(requirements!.map((x) => x))
            : null,
        "imageUrl": imageUrl,
        "agentId": agentId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
