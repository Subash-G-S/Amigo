class PostModel {
  final String id;
  final String author;
  final String content;
  final String createdAt;

  PostModel({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"],
      author: json["author"],
      content: json["content"],
      createdAt: json["created_at"],
    );
  }
}