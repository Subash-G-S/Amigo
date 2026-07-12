import 'package:flutter/material.dart';

import 'profile_avatar.dart';

class ProfileGradientHeader
    extends StatelessWidget {

  final String username;
  final String email;
  final String bio;
  final String? profilePicture;
  final VoidCallback? onProfileUpdated;

  const ProfileGradientHeader({
    super.key,
    required this.username,
    required this.email,
    required this.bio,
    this.profilePicture,
    this.onProfileUpdated,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.only(
        top: 45,
        bottom: 32,
      ),

      decoration: BoxDecoration(
  color: Color(0xff555555),
  borderRadius: const BorderRadius.only(
    bottomLeft: Radius.circular(28),
    bottomRight: Radius.circular(28),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(.06),
      blurRadius: 18,
      offset: const Offset(0, 6),
    ),
  ],
),

      child: Column(

        children: [

          ProfileAvatar(
            username: username,
            profilePicture: profilePicture,
            onProfileUpdated: onProfileUpdated,
          ),

          const SizedBox(height: 18),

          Text(
            username,
            style: const TextStyle(
              color: Color(0xff222222),
              fontSize: 26,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            email,
            style: const TextStyle(
              color: Colors.grey,
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