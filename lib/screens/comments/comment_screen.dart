import 'package:flutter/material.dart';

import '../../models/comment_model.dart';
import '../../services/comment_service.dart';
import '../../utils/date_formatter.dart';
import '../../widgets/comments/comment_card.dart';
import '../../widgets/comments/comment_header.dart';
import '../../widgets/comments/comment_input.dart';
import '../../widgets/glass/animated_background.dart';

class CommentScreen extends StatefulWidget {
  final String postId;

  const CommentScreen({
    super.key,
    required this.postId,
  });

  @override
  State<CommentScreen> createState() =>
      _CommentScreenState();
}

class _CommentScreenState
    extends State<CommentScreen> {
  final CommentService _service =
      CommentService();

  final TextEditingController controller =
      TextEditingController();

  List<CommentModel> comments = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  Future<void> loadComments() async {
    final data =
        await _service.getComments(widget.postId);

    if (!mounted) return;

    setState(() {
      comments = data;
      loading = false;
    });
  }

  Future<void> sendComment() async {
    if (controller.text.trim().isEmpty) return;

    final success = await _service.addComment(
      widget.postId,
      controller.text.trim(),
    );

    if (!success) return;

    controller.clear();

    await loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

      body: SafeArea(
  child: Column(
    children: [

      CommentHeader(
        count: comments.length,
      ),

      Expanded(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : comments.isEmpty
                ? const Center(
                    child: Text(
                      "No comments yet",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 120,
                    ),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {

                      final comment =
                          comments[index];

                      return CommentCard(
                        name: comment.author,
                        comment: comment.content,
                        time: DateFormatter.timeAgo(
                          comment.createdAt,
                        ),
                        anonymous: false,
                      );
                    },
                  ),
      ),

      CommentInput(
        controller: controller,
        onSend: sendComment,
      ),

    ],
  ),
),
    ),
    );
  }
}