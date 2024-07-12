import 'dart:convert';

List<GetChats> getChatsFromJson(String str) =>
    List<GetChats>.from(json.decode(str).map((x) => GetChats.fromJson(x)));

String getChatsToJson(List<GetChats> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetChats {
  final String? id;
  final String? chatName;
  final bool? isGroupChat;
  final List<Sender>? users;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final LatestMessage? latestMessage;
  final List<String>? deletedBy;

  GetChats({
    this.id,
    this.chatName,
    this.isGroupChat,
    this.users,
    this.createdAt,
    this.updatedAt,
    this.latestMessage,
    this.deletedBy,
  });

  factory GetChats.fromJson(Map<String, dynamic> json) => GetChats(
        id: json["_id"],
        chatName: json["chatName"],
        isGroupChat: json["isGroupChat"],
        users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestMessage: LatestMessage.fromJson(json["latestMessage"]),
        deletedBy: List<String>.from(json["deletedBy"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "latestMessage": latestMessage?.toJson(),
        "deletedBy": List<dynamic>.from(deletedBy!.map((x) => x)),
      };
}

class LatestMessage {
  final String? id;
  final Sender? sender;
  final String? content;
  final String? receiver;
  final String? chat;

  LatestMessage({
    this.id,
    this.sender,
    this.content,
    this.receiver,
    this.chat,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: json["chat"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender?.toJson(),
        "content": content,
        "receiver": receiver,
        "chat": chat,
      };
}

class Sender {
  final String? id;
  final String? username;
  final String? email;
  final String? profile;
  final String? location;

  Sender({
    this.id,
    this.username,
    this.email,
    this.profile,
    this.location,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profile: json["profile"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profile": profile,
        "location": location,
      };
}
