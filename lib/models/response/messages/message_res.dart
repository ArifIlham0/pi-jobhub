import 'dart:convert';

List<ReceivedMessage> receivedMessageFromJson(String str) =>
    List<ReceivedMessage>.from(
        json.decode(str).map((x) => ReceivedMessage.fromJson(x)));

String receivedMessageToJson(List<ReceivedMessage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReceivedMessage {
  final String? id;
  final Sender? sender;
  final String? content;
  final String? receiver;
  final Chat? chat;
  final List<dynamic>? readBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ReceivedMessage({
    this.id,
    this.sender,
    this.content,
    this.receiver,
    this.chat,
    this.readBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ReceivedMessage.fromJson(Map<String, dynamic> json) =>
      ReceivedMessage(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: Chat.fromJson(json["chat"]),
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender?.toJson(),
        "content": content,
        "receiver": receiver,
        "chat": chat?.toJson(),
        "readBy": List<dynamic>.from(readBy!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Chat {
  final String? id;
  final String? chatName;
  final bool? isGroupChat;
  final List<Sender>? users;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? latestMessage;

  Chat({
    this.id,
    this.chatName,
    this.isGroupChat,
    this.users,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        chatName: json["chatName"],
        isGroupChat: json["isGroupChat"],
        users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: json["latestMessage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "latestMessage": latestMessage,
      };
}

class Sender {
  final String? id;
  final String? username;
  final String? email;
  final String? profile;

  Sender({
    this.id,
    this.username,
    this.email,
    this.profile,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profile": profile,
      };
}
