import 'package:flutter/material.dart';

import '../../services/post_service.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/inputs/custom_textfield.dart';

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
  bool _isAnonymous = false;

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
      _isAnonymous,
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

            Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  ),
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    children: [

      Icon(
        _isAnonymous
            ? Icons.visibility_off
            : Icons.person,
      ),

      const SizedBox(width: 10),

      Text(
        _isAnonymous
            ? "Posting Anonymously"
            : "Posting as Yourself",
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      const Spacer(),

      Switch(
        value: _isAnonymous,
        onChanged: (value) {
          setState(() {
            _isAnonymous = value;
          });
        },
      ),
    ],
  ),
),

const SizedBox(height: 20),

CustomTextField(
  controller: postController,
  hint: "What's on your mind?",
  icon: Icons.edit,
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