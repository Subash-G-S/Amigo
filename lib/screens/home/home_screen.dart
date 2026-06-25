import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/post_provider.dart';
import '../../widgets/home/dashboard_header.dart';
import '../../widgets/home/empty_feed.dart';
import '../../widgets/home/post_card.dart';
import '../create/create_post_screen.dart';

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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().loadFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),

      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        backgroundColor: const Color(0xFF4F46E5),
        icon: const Icon(Icons.add),
        label: const Text("Create"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreatePostScreen(),
            ),
          );
        },
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: provider.loadFeed,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [

              /// Dashboard Header
              SliverToBoxAdapter(
                child: DashboardHeader(
                  username: widget.username,
                ),
              ),

              /// Feed Title
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Text(
                    "Latest Feed",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              /// Loading
              if (provider.loading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )

              /// Empty Feed
              else if (provider.posts.isEmpty)
                const SliverFillRemaining(
                  child: EmptyFeed(),
                )

              /// Feed
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return PostCard(
                        post: provider.posts[index],
                      );
                    },
                    childCount: provider.posts.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}