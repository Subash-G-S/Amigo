import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/post_model.dart';
import '../../providers/post_provider.dart';
import '../../screens/comments/comment_screen.dart';
import '../../utils/date_formatter.dart';
import '../glass/glass_card.dart';

class PostCard extends StatefulWidget {
  final PostModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: .97,
      upperBound: 1,
      value: 1,
    );

    _scaleAnimation = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tapAnimation() async {
    await _controller.reverse();
    await _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) => _controller.reverse(),
        onTapCancel: () => _controller.forward(),
        onTapUp: (_) => _controller.forward(),
        child: Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 10,
  ),
  child: GlassCard(
        child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                /// HEADER
                Row(
                  children: [

                    Hero(
                      tag: "avatar_${post.id}",
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: post.isAnonymous
    ? Colors.deepPurple.shade100
    : Colors.indigo.shade100,
                        child: post.isAnonymous
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.deepPurple,
                            )
                            : Text(
                          post.author[0].toUpperCase(),
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            color: Colors.indigo,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Text(
  post.isAnonymous
      ? "Anonymous"
      : post.author,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
  "${post.isAnonymous ? "Anonymous • " : ""}${DateFormatter.timeAgo(post.createdAt)}",
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
                      icon: const Icon(
                        Icons.more_horiz,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                /// POST CONTENT
                SelectableText(
                  post.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 20),

                /// COUNTS
                Row(
                  children: [

                    const Icon(
                      Icons.favorite,
                      size: 16,
                      color: Colors.red,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      "${post.likes}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 18),

                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 16,
                      color: Colors.blueGrey,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      "${post.comments} Comments",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Divider(
                  color: Colors.grey.shade300,
                ),

                Row(
                  children: [

                    /// LIKE
                    Expanded(
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(14),
                        onTap: () {
                          _tapAnimation();

                          context
                              .read<PostProvider>()
                              .toggleLike(post);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [

                              AnimatedSwitcher(
                                duration:
                                    const Duration(
                                  milliseconds: 250,
                                ),
                                transitionBuilder:
                                    (
                                  child,
                                  animation,
                                ) =>
                                        ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                                child: Icon(
                                  post.liked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  key: ValueKey(
                                    post.liked,
                                  ),
                                  color: post.liked
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),

                              const SizedBox(width: 8),

                              Text(
                                "Like",
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                  color: post.liked
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// COMMENT
                    Expanded(
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(14),
                        onTap: () {

                          _tapAnimation();

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
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [

                              Icon(
                                Icons.chat_bubble_outline,
                              ),

                              SizedBox(width: 8),

                              Text(
                                "Comment",
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                                        /// SHARE
                    Expanded(
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(14),
                        onTap: () {
                          _tapAnimation();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share_outlined),

                              SizedBox(width: 8),

                              Text(
                                "Share",
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}