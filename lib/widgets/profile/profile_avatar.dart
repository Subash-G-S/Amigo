import 'package:flutter/material.dart';
import '../../services/image_picker_service.dart';
import '../../services/upload_service.dart';
class ProfileAvatar extends StatefulWidget {
  final String username;
  final String? profilePicture;
  final VoidCallback? onProfileUpdated;

  const ProfileAvatar({
    super.key,
    required this.username,
    this.profilePicture,
    this.onProfileUpdated,
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profile_avatar",
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: () async {
  final image = await ImagePickerService.pickImage();

  if (image == null) return;

  final url = await UploadService().uploadProfilePhoto(image);

  if (url != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile photo updated successfully."),
      ),
    );

    widget.onProfileUpdated?.call();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failed to upload profile photo."),
      ),
    );
  }
},
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
                    color: Colors.blue.withOpacity(.10),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: ClipOval(
                child: widget.profilePicture != null &&
                        widget.profilePicture!.isNotEmpty
                    ? Image.network(
                        widget.profilePicture!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _initialAvatar(),
                      )
                    : _initialAvatar(),
              ),
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
        widget.username[0].toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}