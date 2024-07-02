import 'dart:convert';

List<AllBookmarks> allBookmarksFromJson(String str) => List<AllBookmarks>.from(
    json.decode(str).map((x) => AllBookmarks.fromJson(x)));

class AllBookmarks {
  final String? id;
  final Job? job;
  final String? userId;

  AllBookmarks({
    this.id,
    this.job,
    this.userId,
  });

  factory AllBookmarks.fromJson(Map<String, dynamic> json) => AllBookmarks(
        id: json["_id"],
        job: Job.fromJson(json["job"]),
        userId: json["userId"],
      );
}

class Job {
  final String? id;
  final String? title;
  final String? location;
  final String? company;
  final String? salary;
  final String? period;
  final String? contract;
  final String? imageUrl;
  final String? agentId;

  Job({
    this.id,
    this.title,
    this.location,
    this.company,
    this.salary,
    this.period,
    this.contract,
    this.imageUrl,
    this.agentId,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        company: json["company"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
      );
}
