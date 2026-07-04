import 'package:flutter/material.dart';

import '../../screens/create/create_post_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/explore/explore_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/chat/chat_screen.dart';

class BottomNav extends StatefulWidget {
  final String username;
  final String email;

  const BottomNav({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  late HomeScreen homeScreen;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    homeScreen = HomeScreen(
      username: widget.username,
    );

    pages = [
      homeScreen,
      ExploreScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];
  }

  Future<void> openCreatePost() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CreatePostScreen(),
      ),
    );

    if (result == true) {
      setState(() {
        homeScreen = HomeScreen(
          username: widget.username,
        );

        pages[0] = homeScreen;
      });
    }
  }
  Widget navItem({
  required IconData icon,
  required int index,
  required VoidCallback onTap,
}) {
  final selected = currentIndex == index;

  return Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 4,
              width: selected ? 26 : 0,
              decoration: BoxDecoration(
                color: const Color(0xff7C4DFF),
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 8),

            AnimatedScale(
              scale: selected ? 1.15 : 1,
              duration: const Duration(milliseconds: 250),
              child: Icon(
                icon,
                color: selected
                    ? const Color(0xff7C4DFF)
                    : Colors.grey,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
Widget buildNavigationBar() {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        0,
        18,
        18,
      ),
      child: Container(
        height: 78,

        decoration: BoxDecoration(
          color: const Color(0xFF171E2F),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white10,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.35),
              blurRadius: 35,
              offset: const Offset(0, 15),
            ),
          ],
        ),

        child: Row(
          children: [

            navItem(
              icon: Icons.home_rounded,
              index: 0,
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              },
            ),

            navItem(
              icon: Icons.search_rounded,
              index: 1,
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              },
            ),

            Expanded(
              child: GestureDetector(
                onTap: openCreatePost,
                child: Center(
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff7C4DFF),
                          Color(0xff2196F3),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),

            navItem(
              icon: Icons.chat_bubble_outline_rounded,
              index: 2,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChatScreen(),
                  ),
                );
              },
            ),

            navItem(
              icon: Icons.person_rounded,
              index: 3,
              onTap: () {
                setState(() {
                  currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  extendBody: true,

  body: Stack(
    children: [

      pages[currentIndex],

      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: buildNavigationBar(),
      ),
    ],
  ),
);
  }
}