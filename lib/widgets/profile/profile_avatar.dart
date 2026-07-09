import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String username;
  final String? profilePicture;

  const ProfileAvatar({
    super.key,
    required this.username,
    this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profile_avatar",
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
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
            child: ClipOval(
              child: profilePicture != null &&
                      profilePicture!.isNotEmpty
                  ? Image.network(
                      profilePicture!,
                      fit: BoxFit.cover,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return _initialAvatar();
                      },
                    )
                  : _initialAvatar(),
            ),
          ),

          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.camera_alt,
              size: 18,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _initialAvatar() {
    return Center(
      child: Text(
        username[0].toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}