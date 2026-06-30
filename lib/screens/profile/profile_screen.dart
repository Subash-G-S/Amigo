import 'package:flutter/material.dart';

import '../../services/token_service.dart';
import '../auth/login_screen.dart';

import '../../widgets/profile/profile_gradient_header.dart';
import '../../widgets/profile/profile_section.dart';
import '../../widgets/profile/profile_stats.dart';
import '../../widgets/profile/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final int posts;
  final int followers;
  final int following;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.email,
    required this.posts,
    required this.followers,
    required this.following,
  });

  Future<void> logout(BuildContext context) async {
    await TokenService.logout();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("Logout"),
        content: const Text(
          "Are you sure you want to logout?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await logout(context);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F6FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              /// HEADER
              ProfileGradientHeader(
                username: username,
                email: email,
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    /// PROFILE COMPLETION
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(22),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            const Row(
                              children: [

                                Icon(
                                  Icons.workspace_premium,
                                  color: Colors.amber,
                                ),

                                SizedBox(width: 8),

                                Text(
                                  "Profile Completion",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),

                            const SizedBox(height: 18),

                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(
                                      12),
                              child:
                                  const LinearProgressIndicator(
                                value: .75,
                                minHeight: 10,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "75% Complete",
                              style: TextStyle(
                                color:
                                    Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// STATS
                    Row(
                      children: [

                        ProfileStats(
                          title: "Posts",
                          value: posts.toString(),
                        ),

                        ProfileStats(
                          title: "Followers",
                          value: followers.toString(),
                        ),

                        ProfileStats(
                          title: "Following",
                          value: following.toString(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// GENERAL
                    ProfileSection(
                      title: "General",
                      children: [

                        ProfileTile(
                          icon: Icons.edit,
                          title: "Edit Profile",
                          onTap: () {},
                        ),

                        ProfileTile(
                          icon: Icons.favorite_border,
                          title: "Liked Posts",
                          onTap: () {},
                        ),

                        ProfileTile(
                          icon: Icons.bookmark_border,
                          title: "Saved Posts",
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    /// PREFERENCES
                    ProfileSection(
                      title: "Preferences",
                      children: [

                        ProfileTile(
                          icon:
                              Icons.notifications_none,
                          title: "Notifications",
                          onTap: () {},
                        ),

                        ProfileTile(
                          icon:
                              Icons.dark_mode_outlined,
                          title: "Appearance",
                          onTap: () {},
                        ),

                        ProfileTile(
                          icon:
                              Icons.lock_outline,
                          title: "Privacy",
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    /// SUPPORT
                    ProfileSection(
                      title: "Support",
                      children: [

                        ProfileTile(
                          icon:
                              Icons.help_outline,
                          title: "Help Center",
                          onTap: () {},
                        ),

                        ProfileTile(
                          icon: Icons.star_border,
                          title: "Rate Amigo",
                          onTap: () {},
                        ),

                        ProfileTile(
                          icon:
                              Icons.info_outline,
                          title: "About Amigo",
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    /// LOGOUT
                    ProfileSection(
                      title: "Account",
                      children: [

                        ProfileTile(
                          icon: Icons.logout,
                          title: "Logout",
                          color: Colors.red,
                          onTap: () {
                            showLogoutDialog(
                              context,
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}