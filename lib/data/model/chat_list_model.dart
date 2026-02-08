class ChatListModel {
  final String? image;
  final String? name;
  final String? lastMessage;
  final String? time;
  final int? count;
  final String? chatId;
  final bool? isActive;

  ChatListModel({
    this.image,
    this.name,
    this.lastMessage,
    this.time,
    this.count,
    this.chatId,
    this.isActive,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      image: json['image'],
      name: json['name'],
      lastMessage: json['last_message'],
      time: json['time'],
      count: json['count'],
      chatId: json['chat_id'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'last_message': lastMessage,
      'time': time,
      'count': count,
      'chat_id': chatId,
      'isActive': isActive,
    };
  }
}
