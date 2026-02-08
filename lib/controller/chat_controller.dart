import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/chat_list_model.dart';
import 'package:flutter_extension/data/model/message_model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final messages = <MessageModel>[].obs;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final chatsList = <ChatListModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    messages.addAll([
      MessageModel(
        message: "Hi! How can I help you today?",
        time: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: true,
        isMe: false,
      ),
      MessageModel(
        message: "I am fine and you?",
        time: DateTime.now().subtract(const Duration(minutes: 4)),
        isRead: true,
        isMe: true,
      ),
    ]);

    loadDummyChatList();
  }

  Future<void> refreshCurrentTab() async {
    await Future.delayed(const Duration(seconds: 1));
    loadDummyChatList();
  }

  void loadDummyChatList() {
    chatsList.assignAll(dummyChats);
  }

  List<ChatListModel> dummyChats = [
    ChatListModel(
      image: "assets/images/profile.png",
      name: "John Doe",
      lastMessage: "Hey, are you coming today?",
      time: "10:45 AM",
      count: 2,
      chatId: "chat_001",
      isActive: true,
    ),
    ChatListModel(
      image: "assets/images/profile.png",
      name: "Emma Watson",
      lastMessage: "Thank you!",
      time: "Yesterday",
      count: 0,
      chatId: "chat_002",
      isActive: false,
    ),
    ChatListModel(
      image: "assets/images/profile.png",
      name: "Dwayne Johnson",
      lastMessage: "Hello, how are you?",
      time: "Today",
      count: 1,
      chatId: "chat_003",
      isActive: true,
    ),
  ];

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();

    messages.add(
      MessageModel(message: text, time: now, isRead: true, isMe: true),
    );

    messageController.clear();
    _jumpToBottom();

    Future.delayed(const Duration(milliseconds: 800), () {
      messages.add(
        MessageModel(
          message: text,
          time: DateTime.now(),
          isRead: false,
          isMe: false,
        ),
      );
      _jumpToBottom();
    });
  }

  void markReceiverAsRead() {
    messages.value = messages
        .map(
          (m) => MessageModel(
            message: m.message,
            time: m.time,
            isRead: m.isMe ? m.isRead : true,
            isMe: m.isMe,
          ),
        )
        .toList();
  }

  void clearMessages() {
    messages.clear();
  }

  void _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
