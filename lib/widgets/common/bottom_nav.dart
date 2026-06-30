import 'package:flutter/material.dart';

import '../../screens/create/create_post_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/explore/explore_screen.dart';
import '../../screens/profile/profile_screen.dart';

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
      const ExploreScreen(),
      ProfileScreen(
        username: widget.username,
        email: widget.email,
        posts: 12,
        followers: 1200,
        following: 186,
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: "Explore",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}