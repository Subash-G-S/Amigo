import 'package:flutter/material.dart';

class CommentHeader extends StatelessWidget {
  final int count;

  const CommentHeader({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        16,
      ),
      child: Row(
        children: [

          InkWell(
            borderRadius:
                BorderRadius.circular(14),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white24,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                const Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                Text(
                  "$count replies",
                  style: TextStyle(
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white24,
              ),
            ),
            child: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}