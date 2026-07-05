import 'package:flutter/material.dart';

class CommentInput extends StatelessWidget {

  final TextEditingController controller;
  final VoidCallback onSend;

  const CommentInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          16,
        ),

        child: Container(

          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 6,
          ),

          decoration: BoxDecoration(

            color: Colors.white.withOpacity(.08),

            borderRadius:
                BorderRadius.circular(30),

            border: Border.all(
              color: Colors.white24,
            ),

          ),

          child: Row(

            children: [

              Expanded(

                child: TextField(

                  controller: controller,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write a comment...",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),

              GestureDetector(

                onTap: onSend,

                child: Container(

                  width: 42,
                  height: 42,

                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}