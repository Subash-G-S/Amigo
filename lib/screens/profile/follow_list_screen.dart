import 'package:flutter/material.dart';

import '../../models/follow_user_model.dart';
import '../../services/auth_service.dart';
import '../profile/user_profile_screen.dart';

class FollowListScreen extends StatefulWidget {
  final String title;
  final String userId;
  final bool followers;

  const FollowListScreen({
    super.key,
    required this.title,
    required this.userId,
    required this.followers,
  });

  @override
  State<FollowListScreen> createState() =>
      _FollowListScreenState();
}

class _FollowListScreenState
    extends State<FollowListScreen> {

  final AuthService _authService = AuthService();

  List<FollowUserModel> users = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {

    if (widget.followers) {
      users = await _authService.getFollowers(
        widget.userId,
      );
    } else {
      users = await _authService.getFollowing(
        widget.userId,
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users.isEmpty
              ? const Center(
                  child: Text(
                    "No users found",
                  ),
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {

                    final user = users[index];

                    return ListTile(

                      leading: CircleAvatar(
                        child: Text(
                          user.name[0].toUpperCase(),
                        ),
                      ),

                      title: Text(user.name),

                      subtitle: Text(
                        user.bio.isEmpty
                            ? user.email
                            : user.bio,
                      ),

                      trailing: const Icon(
                        Icons.chevron_right,
                      ),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                UserProfileScreen(
                              userId: user.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}