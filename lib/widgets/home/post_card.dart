import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/post_model.dart';
import '../../providers/post_provider.dart';
import '../../screens/comments/comment_screen.dart';
import '../../utils/date_formatter.dart';


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
  padding: const EdgeInsets.fromLTRB(
    16,
    6,
    16,
    6,
  ),
  child: Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(22),
    border: Border.all(
      color: const Color(0xffECECEC),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.05),
        blurRadius: 18,
        offset: const Offset(0, 6),
      ),
    ],
  ),
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                /// HEADER
                Row(
                  children: [

                    Hero(
  tag: "avatar_${post.id}",
  child: Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: const Color(0xffECECEC),
      ),
    ),
    child: CircleAvatar(
      radius: 18,
      backgroundColor: const Color(0xffF4EFE8),
      child: post.isAnonymous
          ? const Icon(
              Icons.visibility_off,
              color: Color(0xff8B6F47),
            )
          : Text(
              post.author[0].toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff8B6F47),
                fontSize: 16,
              ),
            ),
    ),
  ),
),

                    

                    const SizedBox(width: 8),

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
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w700,
                                  letterSpacing: .2,
                                  color: Color(0xff222222),
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
  "${post.isAnonymous ? "Anonymous • " : ""}${DateFormatter.timeAgo(post.createdAt)}",
  style: TextStyle(
    color: Color(0xff8A8A8A),
    fontSize: 11,
    fontWeight: FontWeight.w500,
  ),
),
                        ],
                      ),
                    ),

                    IconButton(
                      splashRadius: 20,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Color(0xff666666),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// POST CONTENT
                Text(
                  post.content,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: Color(0xff2B2B2B),
                  ),
                ),

                const SizedBox(height: 12),

                /// COUNTS
                Text(
  "${post.likes} Likes • ${post.comments} Comments",
  style: const TextStyle(
    color: Color(0xff777777),
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
),

                const SizedBox(height: 14),

                const Divider(
  color: Color(0xffECECEC),
  height: 18,
),

                Row(
                  children: [

                    /// LIKE
                    Expanded(
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(100),
                        onTap: () {
                          _tapAnimation();

                          context
                              .read<PostProvider>()
                              .toggleLike(post);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 10,
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
                                  size: 24,
                                  key: ValueKey(
                                    post.liked,
                                  ),
                                  color: post.liked
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),

                              const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// COMMENT
                    Expanded(
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(100),
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
                            vertical: 14,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [

                              Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 24,
                              ),

                              const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),

                                        /// SHARE
                    Expanded(
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(100),
                        onTap: () {
                          _tapAnimation();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.send_rounded,
                                size: 23,
                              ),

                              const SizedBox()
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