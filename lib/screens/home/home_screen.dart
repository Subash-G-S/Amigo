import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/post_provider.dart';

import '../../widgets/home/empty_feed.dart';
import '../../widgets/home/post_card.dart';
import '../create/create_post_screen.dart';
import '../../widgets/glass/animated_background.dart';
import '../../widgets/home/home_top_bar.dart';

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

    return AnimatedBackground(
      child : Scaffold(
        backgroundColor: Colors.transparent,

      body: SafeArea(
  child: Column(
    children: [

      const SizedBox(height: 20),

      HomeTopBar(
        username: widget.username,
      ),

      const SizedBox(height: 10),

      Expanded(
        child: RefreshIndicator(
          onRefresh: provider.loadFeed,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
    child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CreatePostScreen(),
          ),
        );

        if (result == true) {
          context.read<PostProvider>().loadFeed();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withOpacity(0.18),
            width: 1.2,
          )
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.08),
              child: Text(
                widget.username[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 14),

            const Expanded(
              child: Text(
                "What's on your mind?",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Icon(
              Icons.add_circle_outline,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    ),
  ),
),
              

              /// Feed Title
              

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
    ],
    ),
      ),
      ),
    );
  }
}