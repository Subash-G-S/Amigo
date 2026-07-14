import 'package:flutter/material.dart';
import 'profile_menu_sheet.dart';
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

      padding: const EdgeInsets.fromLTRB(
        24,
        28,
        24,
        24,
      ),

      decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.only(
    bottomLeft: Radius.circular(28),
    bottomRight: Radius.circular(28),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(.05),
      blurRadius: 18,
      offset: const Offset(0, 6),
    ),
  ],
),

      child: Stack(
  children: [

    Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const Icon(
          Icons.more_vert,
          color: Color(0xff444444),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            builder: (_) => const ProfileMenuSheet(),
          );
        },
      ),
    ),

    Padding(
  padding: const EdgeInsets.only(top: 12),
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
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Color(0xff222222),
        ),
      ),

      const SizedBox(height: 4),

      Text(
        "@${username.toLowerCase().replaceAll(" ", "")}",
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff888888),
        ),
      ),

      const SizedBox(height: 14),

      Text(
        bio.isEmpty ? "No bio yet." : bio,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xff555555),
          height: 1.5,
        ),
      ),

      const SizedBox(height: 22),

      Row(
        children: [

          Expanded(
            child: FilledButton(
              onPressed: () {},
              child: const Text("Edit Profile"),
            ),
          ),

          const SizedBox(width: 12),

          SizedBox(
            width: 56,
            child: OutlinedButton(
              onPressed: () {},
              child: const Icon(Icons.share),
            ),
          ),

        ],
      ),

    ],
  ),
),

  ],
),
    );
  }
}