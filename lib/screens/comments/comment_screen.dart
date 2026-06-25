import 'package:flutter/material.dart';

import '../../models/comment_model.dart';
import '../../services/comment_service.dart';
import '../../utils/date_formatter.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: Column(
        children: [

          Expanded(
            child: loading
                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {

                      final comment =
                          comments[index];

                      return ListTile(
                        leading:
                            const CircleAvatar(
                          child:
                              Icon(Icons.person),
                        ),
                        title: Text(
                            comment.author),
                        subtitle: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [

                            Text(
                              comment.content,
                            ),

                            const SizedBox(
                                height: 4),

                            Text(
                              DateFormatter.timeAgo(
                                  comment
                                      .createdAt),
                              style:
                                  const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(12),
              child: Row(
                children: [

                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(
                        hintText:
                            "Write a comment...",
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: sendComment,
                    icon: const Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}