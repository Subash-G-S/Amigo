import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/post_provider.dart';

import '../../widgets/home/empty_feed.dart';
import '../../widgets/home/post_card.dart';
import '../create/create_post_screen.dart';
import '../../widgets/glass/animated_background.dart';

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

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,

  title: const Text(
    "AMIGO",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),

  actions: [
    IconButton(
      icon: const Icon(
        Icons.add_circle_outline,
        color: Colors.black,
      ),
      onPressed: () async {
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
    ),
  ],
),

      body: SafeArea(
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: Text(
                widget.username[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 14),

            const Expanded(
              child: Text(
                "What's on your mind?",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),

            Icon(
              Icons.edit_square,
              color: Colors.indigo.shade400,
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
    ),
    );
  }
}