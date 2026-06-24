import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  const HomeScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "AMIGO",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Welcome, $username 👋",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("Connect with friends"),
                subtitle: Text("Feature coming soon"),
              ),
            ),

            SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: Icon(Icons.forum),
                title: Text("Community Posts"),
                subtitle: Text("Feature coming soon"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}