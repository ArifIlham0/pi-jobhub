import 'dart:convert';

DeleteChatReq deleteChatReqFromJson(String str) =>
    DeleteChatReq.fromJson(json.decode(str));

String deleteChatReqToJson(DeleteChatReq data) => json.encode(data.toJson());

class DeleteChatReq {
  final List<String>? chatIds;

  DeleteChatReq({
    this.chatIds,
  });

  factory DeleteChatReq.fromJson(Map<String, dynamic> json) => DeleteChatReq(
        chatIds: List<String>.from(json["chatIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "chatIds": List<dynamic>.from(chatIds!.map((x) => x)),
      };
}
