import 'package:flutter/material.dart';

class AboutAmigoScreen extends StatelessWidget {
  const AboutAmigoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About AMIGO"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.indigo,
              child: Icon(
                Icons.groups,
                color: Colors.white,
                size: 45,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "AMIGO",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Version 1.0.0",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "AMIGO is a modern campus social networking platform designed to help students connect, share ideas, discuss academics, participate in communities, and interact through both public and anonymous posts.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 30),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Built For"),
              subtitle: const Text("Amrita Vishwa Vidyapeetham"),
            ),

            ListTile(
              leading: const Icon(Icons.code),
              title: const Text("Developed By"),
              subtitle: const Text("Subash"),
            ),

            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Mission"),
              subtitle: const Text(
                "Create a safe and engaging campus community.",
              ),
            ),

            ListTile(
              leading: const Icon(Icons.security),
              title: const Text("Privacy"),
              subtitle: const Text(
                "Anonymous posts keep your identity hidden from other users while remaining available to administrators for moderation.",
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "© 2026 AMIGO",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}