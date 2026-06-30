import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String username;

  const ProfileAvatar({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profile_avatar",
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Center(
          child: Text(
            username[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}