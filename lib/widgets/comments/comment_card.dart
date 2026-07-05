import 'package:flutter/material.dart';
import '../glass/glass_card.dart';

class CommentCard extends StatelessWidget {

  final String name;
  final String comment;
  final String time;
  final bool anonymous;

  const CommentCard({
    super.key,
    required this.name,
    required this.comment,
    required this.time,
    required this.anonymous,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      child: GlassCard(

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Row(

                children: [

                  CircleAvatar(
                    backgroundColor:
                        anonymous
                            ? Colors.deepPurple
                            : Colors.indigo,

                    child: anonymous
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.white,
                          )
                        : Text(
                            name[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          anonymous
                              ? "Anonymous"
                              : name,

                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        Text(
                          time,
                          style: TextStyle(
                            color: Colors.white
                                .withOpacity(.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                comment,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 18),

              Row(

                children: [

                  Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.white70,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "Like",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(width: 25),

                  Icon(
                    Icons.reply,
                    size: 18,
                    color: Colors.white70,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "Reply",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}