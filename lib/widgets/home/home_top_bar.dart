import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget {
  final String username;

  const HomeTopBar({
    super.key,
    required this.username,
  });

  String greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning ☀️";
    if (hour < 17) return "Good Afternoon 🌤️";
    return "Good Evening 🌙";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        20,
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  greeting(),
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [

              _icon(Icons.notifications_none),

              const SizedBox(width: 12),

              _icon(Icons.tune),
            ],
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white12,
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}