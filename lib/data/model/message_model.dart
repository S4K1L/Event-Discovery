class MessageModel {
  final String message;
  final DateTime time;
  final bool isRead;
  final bool isMe;

  MessageModel({
    required this.message,
    required this.time,
    required this.isRead,
    required this.isMe,
  });

  /// Formatted time like 3:53 PM
  String get formattedTime {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $period";
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      time: DateTime.parse(json['time']),
      isRead: json['is_read'],
      isMe: json['is_me'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'time': time.toIso8601String(),
      'is_read': isRead,
      'is_me': isMe,
    };
  }
}
