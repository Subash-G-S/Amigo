import 'package:flutter/material.dart';

import 'profile_avatar.dart';

class ProfileGradientHeader
    extends StatelessWidget {

  final String username;
  final String email;
  final String bio;

  const ProfileGradientHeader({
    super.key,
    required this.username,
    required this.email,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.only(
        top: 35,
        bottom: 28,
      ),

      decoration: const BoxDecoration(

        gradient: LinearGradient(

          colors: [

            Color(0xff6A11CB),

            Color(0xff2575FC),

          ],

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

        ),

        borderRadius: BorderRadius.only(

          bottomLeft:
              Radius.circular(36),

          bottomRight:
              Radius.circular(36),

        ),

      ),

      child: Column(

        children: [

          ProfileAvatar(
            username: username,
          ),

          const SizedBox(height: 18),

          Text(
            username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            email,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),

Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30),
  child: Text(
    bio.isEmpty ? "No bio yet." : bio,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 15,
      height: 1.4,
    ),
  ),
),
        ],
      ),
    );
  }
}