class DateFormatter {
  static String timeAgo(String date) {
    final DateTime postTime = DateTime.parse(date);
    final Duration difference = DateTime.now().difference(postTime);

    if (difference.inSeconds < 60) {
      return "Just now";
    }

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    }

    if (difference.inHours < 24) {
      return "${difference.inHours} hr ago";
    }

    if (difference.inDays == 1) {
      return "Yesterday";
    }

    if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    }

    return "${postTime.day}/${postTime.month}/${postTime.year}";
  }
}