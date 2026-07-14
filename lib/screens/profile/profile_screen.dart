import 'package:flutter/material.dart';

import '../../services/token_service.dart';
import '../auth/login_screen.dart';

import '../../widgets/profile/profile_gradient_header.dart';
import '../../services/auth_service.dart';
import 'package:provider/provider.dart';
import '../../providers/post_provider.dart';
import '../../models/search_user_model.dart';
import 'follow_list_screen.dart';
import '../../services/session_service.dart';
import '../../widgets/home/post_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
    @override
State<ProfileScreen> createState() =>
    _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  String userId = "";

SearchUserModel? profile;

bool loading = true;
@override
void initState() {
  super.initState();
  loadProfile();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<PostProvider>().loadMyPosts();
  });
}

Future<void> loadProfile() async {
  userId = await SessionService.getUserId() ?? "";

  final result =
      await _authService.getMyProfile();

  setState(() {
    profile = result;
    loading = false;
  });

}

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
    if (loading) {
  return const Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
    return Scaffold(
      backgroundColor: const Color(0xffF3F6FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              /// HEADER
              ProfileGradientHeader(
                username: profile!.name,
                email: profile!.email,
                bio: profile!.bio,
                profilePicture: profile!.profilePicture,
                onProfileUpdated: loadProfile,
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    /// PROFILE COMPLETION
                    // Card(
                    //   elevation: 0,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius:
                    //         BorderRadius.circular(22),
                    //   ),
                    //   child: Padding(
                    //     padding:
                    //         const EdgeInsets.all(20),
                    //     child: Column(
                    //       crossAxisAlignment:
                    //           CrossAxisAlignment.start,
                    //       children: [

                    //         const Row(
                    //           children: [

                    //             Icon(
                    //               Icons.workspace_premium,
                    //               color: Colors.amber,
                    //             ),

                    //             SizedBox(width: 8),

                    //             Text(
                    //               "Profile Completion",
                    //               style: TextStyle(
                    //                 fontSize: 18,
                    //                 fontWeight:
                    //                     FontWeight.bold,
                    //               ),
                    //             ),

                    //           ],
                    //         ),

                    //         const SizedBox(height: 18),

                    //         ClipRRect(
                    //           borderRadius:
                    //               BorderRadius.circular(
                    //                   12),
                    //           child:
                    //               const LinearProgressIndicator(
                    //             value: .75,
                    //             minHeight: 10,
                    //           ),
                    //         ),

                    //         const SizedBox(height: 10),

                    //         Text(
                    //           "75% Complete",
                    //           style: TextStyle(
                    //             color:
                    //                 Colors.grey.shade600,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // const SizedBox(height: 24),

                    /// STATS
                    Container(
  margin: const EdgeInsets.only(bottom: 28),
  padding: const EdgeInsets.symmetric(
    vertical: 20,
  ),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.05),
        blurRadius: 15,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: Row(
    children: [

      Expanded(
        child: _statItem(
          "Posts",
          profile!.posts.toString(),
          null,
        ),
      ),

      Container(
        width: 1,
        height: 42,
        color: const Color(0xffECECEC),
      ),

      Expanded(
        child: _statItem(
          "Followers",
          profile!.followers.toString(),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FollowListScreen(
                  title: "Followers",
                  userId: userId,
                  followers: true,
                ),
              ),
            );
          },
        ),
      ),

      Container(
        width: 1,
        height: 42,
        color: const Color(0xffECECEC),
      ),

      Expanded(
        child: _statItem(
          "Following",
          profile!.following.toString(),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FollowListScreen(
                  title: "Following",
                  userId: userId,
                  followers: false,
                ),
              ),
            );
          },
          
        ),
      ),

    ],
  ),
),
const SizedBox(height: 30),

Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Recent Posts",
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 18),

Consumer<PostProvider>(
  builder: (_, provider, __) {

    if (provider.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.myPosts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Text(
            "No posts yet.",
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: provider.myPosts.length,
      itemBuilder: (_, index) {
        return PostCard(
          post: provider.myPosts[index],
        );
      },
    );
  },
)
                    /// GENERAL
                    
                    /// PREFERENCES
                    
                    /// SUPPORT
                    
                    /// LOGOUT
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _statItem(
  String title,
  String value,
  VoidCallback? onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff222222),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xff888888),
          ),
        ),

      ],
    ),
  );
}
}