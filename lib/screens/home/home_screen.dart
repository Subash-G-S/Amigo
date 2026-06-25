import 'package:flutter/material.dart';

import '../../models/post_model.dart';
import '../../services/post_service.dart';
import '../../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({
    super.key,
    required this.username,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostService _postService = PostService();

  List<PostModel> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFeed();
  }

  Future<void> loadFeed() async {
    try {
      final data = await _postService.getFeed();

      if (!mounted) return;

      setState(() {
        posts = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadFeed,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "AMIGO",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Welcome, ${widget.username} 👋",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : posts.isEmpty
                        ? const Center(
                            child: Text(
                              "No posts yet.",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              final post = posts[index];

                              return PostCard(
                                post: post,
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}