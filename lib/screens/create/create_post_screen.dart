import 'package:flutter/material.dart';

import '../../services/post_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() =>
      _CreatePostScreenState();
}

class _CreatePostScreenState
    extends State<CreatePostScreen> {

  final TextEditingController postController =
      TextEditingController();

  bool isLoading = false;

  Future<void> createPost() async {

    if (postController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool success =
        await PostService().createPost(
      postController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (success) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Post created successfully",
          ),
        ),
      );

      Navigator.pop(context, true);

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to create post",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: postController,
              maxLines: 6,
              decoration:
                  const InputDecoration(
                hintText:
                    "What's on your mind?",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : createPost,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Post"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}