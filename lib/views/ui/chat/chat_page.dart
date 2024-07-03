import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/chat_provider.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/messages/send_message.dart';
import 'package:jobhub/models/response/messages/message_res.dart';
import 'package:jobhub/services/helpers/message_helper.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/pdf_viewer.dart.dart';
import 'package:jobhub/views/ui/chat/widgets/chat_textfield.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.title,
    this.id,
    this.profile,
    this.user,
  });

  final String? title;
  final String? id;
  final String? profile;
  final List<String>? user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int offset = 1;
  IO.Socket? socket;
  Future<List<ReceivedMessage>>? messageList;
  List<ReceivedMessage> messages = [];
  TextEditingController messageController = TextEditingController();
  String receiver = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getMessage(offset);
    connect();
    joinChat();
    super.initState();
  }

  void getMessage(int? offset) {
    MessageHelper.getMessages(widget.id, offset).then((newMessages) {
      setState(() {
        messages.addAll(newMessages);
      });
    });
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          print("<><><>loading<><><>");
          if (messages.length >= 12) {
            getMessage(offset++);
          }
        }
      }
    });
  }

  void connect() {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    socket = IO.io(
      "https://jobhub-backend-production-5442.up.railway.app",
      <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      },
    );
    socket?.emit("setup", chatProvider.userId);
    socket?.connect();
    socket?.onConnect((_) {
      print("Connected");
      socket?.on('online-users', (userId) {
        chatProvider.online
            .replaceRange(0, chatProvider.online.length, [userId]);
      });
      socket?.on('typing', (status) {
        chatProvider.typingStatus = false;
      });

      socket?.on('stop typing', (status) {
        chatProvider.typingStatus = true;
      });

      socket?.on('message received', (newMessageReceived) {
        sendStopTypingEvent(widget.id!);
        ReceivedMessage receivedMessage =
            ReceivedMessage.fromJson(newMessageReceived);
        if (receivedMessage.sender?.id != chatProvider.userId) {
          setState(() {
            messages.insert(0, receivedMessage);
          });
        }
      });

      socket?.on('message received', (newMessageReceived) {});
    });
  }

  void sendMessage(String? content, String? chatId, String? receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);
    MessageHelper.sendMessage(model).then((response) {
      var emission = response[2];
      socket?.emit('new message', emission);
      sendStopTypingEvent(widget.id!);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void sendTypingEvent(String status) {
    socket?.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket?.emit('stop typing', status);
  }

  void joinChat() {
    socket?.emit('join chat', widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        receiver = widget.user!.firstWhere((id) => id != chatProvider.userId);
        print("Id receiver ${receiver}");
        print("Id kita ${chatProvider.userId}");

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: !chatProvider.typing ? widget.title : "typing...",
              actions: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.profile!),
                      ),
                      Positioned(
                        right: 3.w,
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor:
                              chatProvider.online.contains(receiver)
                                  ? Colors.green
                                  : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
              child: Padding(
                padding: EdgeInsets.all(12.0.h),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => MainScreen(),
                      transition: Transition.leftToRight,
                      duration: Duration(milliseconds: 100),
                    );
                  },
                  child: Icon(MaterialCommunityIcons.arrow_left),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                      itemCount: messages.length,
                      controller: _scrollController,
                      reverse: true,
                      itemBuilder: (context, index) {
                        final data = messages[index];

                        return Padding(
                          padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                          child: Column(
                            children: [
                              ReusableText(
                                text: chatProvider.messageTime(
                                    data.chat?.updatedAt.toString()),
                                style: appstyle(
                                  12,
                                  Color(kDark.value),
                                  FontWeight.normal,
                                ),
                              ),
                              HeightSpacer(size: 15),
                              ChatBubble(
                                alignment:
                                    data.sender?.id == chatProvider.userId
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                backGroundColor:
                                    data.sender?.id == chatProvider.userId
                                        ? Color(kOrange.value)
                                        : Color(kLightBlue.value),
                                elevation: 0.0,
                                clipper: ChatBubbleClipper4(
                                  radius: 8,
                                  type: data.sender?.id == chatProvider.userId
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble,
                                ),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.8,
                                  ),
                                  child: Linkify(
                                    onOpen: (link) async {
                                      File file =
                                          await profileProvider.downloadFile(
                                              link.url, 'document.pdf');
                                      Get.to(
                                        () => PDFViewerPage(url: file.path),
                                        transition: Transition.rightToLeft,
                                        duration: Duration(milliseconds: 100),
                                      );
                                    },
                                    text: data.content!,
                                    style: appstyle(
                                      14,
                                      Color(kLight.value),
                                      FontWeight.normal,
                                    ),
                                    linkStyle:
                                        TextStyle(color: Color(kDark.value)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.h),
                    alignment: Alignment.bottomCenter,
                    child: ChatTextField(
                      messageController: messageController,
                      customSuffixIcon: IconButton(
                        onPressed: () {
                          String messageContent = messageController.text;
                          sendMessage(messageContent, widget.id, receiver);
                        },
                        icon: Icon(
                          Icons.send,
                          size: 24,
                          color: Color(kLightBlue.value),
                        ),
                      ),
                      onTapOutside: (_) {
                        sendStopTypingEvent(widget.id!);
                      },
                      onChanged: (_) {
                        sendTypingEvent(widget.id!);
                      },
                      onEditingComplete: () {
                        String messageContent = messageController.text;
                        sendMessage(messageContent, widget.id, receiver);
                      },
                      onSubmitted: (_) {
                        String messageContent = messageController.text;
                        sendMessage(messageContent, widget.id, receiver);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
