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
        18,
        8,
        18,
        12,
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
                    color: Color(0xff8B8B8B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2D2D2D),
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
    width: 46,
    height: 46,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: const Color(0xffECECEC),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Icon(
      icon,
      size: 22,
      color: const Color(0xff8B6F47),
    ),
  );
}
}