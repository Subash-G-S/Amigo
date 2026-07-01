class SearchUserModel {
  final String id;
  final String name;
  final String email;

  final int posts;
  final int followers;
  final int following;
  final String bio;

  SearchUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.posts,
    required this.followers,
    required this.following,
    required this.bio
  });

  factory SearchUserModel.fromJson(
      Map<String, dynamic> json) {
    return SearchUserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      posts: json["posts"] ?? 0,
      followers: json["followers"] ?? 0,
      following: json["following"] ?? 0,
      bio : json["bio"] ?? "",
    );
  }
}