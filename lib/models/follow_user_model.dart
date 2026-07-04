class FollowUserModel {
  final String id;
  final String name;
  final String email;
  final String bio;

  FollowUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
  });

  factory FollowUserModel.fromJson(
      Map<String, dynamic> json) {
    return FollowUserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      bio: json["bio"] ?? "",
    );
  }
}