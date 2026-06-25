class PostModel {
  final String id;
  final String author;
  final String content;
  final String createdAt;

  int likes;
  int comments;
  bool liked;

  PostModel({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.likes,
    required this.comments,
    required this.liked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"],
      author: json["author"],
      content: json["content"],
      createdAt: json["created_at"],
      likes: json["likes"] ?? 0,
      comments: json["comments"] ?? 0,
      liked: json["liked"] ?? false,
    );
  }
}