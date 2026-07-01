import 'package:flutter/material.dart';

import '../../models/search_user_model.dart';
import '../../services/auth_service.dart';
import '../../services/follow_service.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;

  const UserProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserProfileScreen> createState() =>
      _UserProfileScreenState();
}

class _UserProfileScreenState
    extends State<UserProfileScreen> {

  final AuthService _authService = AuthService();
  final FollowService _followService = FollowService();

bool isFollowing = false;

  SearchUserModel? user;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    try {
      final result =
    await _authService.getUserProfile(
  widget.userId,
);

final following =
    await _followService.isFollowing(
  widget.userId,
);

setState(() {
  user = result;
  isFollowing = following;
  loading = false;
});
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }
  Future<void> toggleFollow() async {

  bool success;

  if (isFollowing) {

    success = await _followService.unfollowUser(
      widget.userId,
    );

  } else {

    success = await _followService.followUser(
      widget.userId,
    );

  }

  if (success) {

  final updatedUser =
      await _authService.getUserProfile(
    widget.userId,
  );

  setState(() {
    isFollowing = !isFollowing;
    user = updatedUser;
  });

}

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : user == null
              ? const Center(
                  child: Text(
                    "User not found",
                  ),
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.all(24),
                  child: Column(
                    children: [

                      CircleAvatar(
                        radius: 50,
                        backgroundColor:
                            Colors.indigo.shade100,
                        child: Text(
                          user!.name[0]
                              .toUpperCase(),
                          style:
                              const TextStyle(
                            fontSize: 32,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Colors.indigo,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        user!.name,
                        style:
                            const TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        user!.email,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceEvenly,
                        children: [

                          Column(
                            children: [
                              Text(
  "${user!.posts}",
  style: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
),
const Text("Posts"),
                            ],
                          ),

                          Column(
                            children: [
                              Text(
  "${user!.followers}",
  style: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
),
const Text("Followers"),
                            ],
                          ),

                          Column(
                            children: [
                              Text(
  "${user!.following}",
  style: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
),
const Text("Following"),
                            ],
                          ),

                        ],
                      ),

                      const SizedBox(height: 35),

                      SizedBox(
                        width:
                            double.infinity,
                        height: 52,
                        child:
                            ElevatedButton(
  onPressed: toggleFollow,
  child: Text(
    isFollowing
        ? "Following"
        : "Follow",
  ),
),
                      ),

                    ],
                  ),
                ),
    );
  }
}