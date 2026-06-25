class CommentModel {
  final String id;
  final String author;
  final String content;
  final String createdAt;

  CommentModel({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromJson(
      Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      author: json["author"],
      content: json["content"],
      createdAt: json["created_at"],
    );
  }
}