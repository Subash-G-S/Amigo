import 'package:flutter/material.dart';

class ProfileMenuSheet extends StatelessWidget {
  const ProfileMenuSheet({super.key});

  Widget tile(
    IconData icon,
    String title,
    VoidCallback? onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 18),

            tile(Icons.edit_outlined, "Edit Profile", () {}),

            tile(Icons.bookmark_border, "Saved Posts", () {}),

            tile(Icons.favorite_border, "Liked Posts", () {}),

            const Divider(),

            tile(Icons.notifications_none, "Notifications", () {}),

            tile(Icons.palette_outlined, "Appearance", () {}),

            tile(Icons.lock_outline, "Privacy", () {}),

            const Divider(),

            tile(Icons.help_outline, "Help Center", () {}),

            tile(Icons.info_outline, "About Amigo", () {}),

            tile(Icons.star_border, "Rate Amigo", () {}),

            const Divider(),

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {},
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}