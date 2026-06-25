import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../providers/post_provider.dart';
import '../utils/date_formatter.dart';
import '../screens/comments/comment_screen.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  child: Icon(Icons.person),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        DateFormatter.timeAgo(post.createdAt),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// CONTENT
            Text(
              post.content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 18),

            /// LIKE COUNT
            if (post.likes > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "${post.likes} likes",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            const Divider(),

            /// ACTIONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {
                    context
                        .read<PostProvider>()
                        .toggleLike(post);
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    transitionBuilder:
                        (child, animation) =>
                            ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: Icon(
                      post.liked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      key: ValueKey(post.liked),
                      color: post.liked
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                  label: Text(
                    "Like",
                    style: TextStyle(
                      color: post.liked
                          ? Colors.red
                          : Colors.grey.shade700,
                    ),
                  ),
                ),

                TextButton.icon(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CommentScreen(
                          postId: post.id,
                        ),
                      ),
                    );

                  },
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                  ),
                  label: const Text("Comment"),
                ),

                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share_outlined,
                  ),
                  label: const Text("Share"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}