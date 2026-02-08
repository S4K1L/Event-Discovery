class NotificationModel {
  final bool unread;
  final String title;
  final DateTime dateTime;

  NotificationModel({
    required this.unread,
    required this.title,
    required this.dateTime,
  });

  String get timeAgo => _formatTimeAgo(dateTime);

  static String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return "$minutes minute${minutes > 1 ? 's' : ''} ago";
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return "$hours hour${hours > 1 ? 's' : ''} ago";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return "$days day${days > 1 ? 's' : ''} ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }
}
