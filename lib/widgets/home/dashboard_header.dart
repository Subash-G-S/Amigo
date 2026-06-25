import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String username;

  const DashboardHeader({
    super.key,
    required this.username,
  });

  String greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  Widget stat(
    String title,
    String value,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        8,
      ),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xff6A11CB),
            Color(0xff2575FC),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.blue.withOpacity(.25),
            blurRadius: 25,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      "${greeting()} 👋",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      username,
                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Share moments with your friends.",
                      style: TextStyle(
                        color:
                            Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 56,
                width: 56,
                decoration:
                    BoxDecoration(
                  color: Colors.white24,
                  borderRadius:
                      BorderRadius.circular(
                          18),
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              )
            ],
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceAround,
            children: [

              stat("Posts", "12"),

              stat("Likes", "245"),

              stat("Friends", "56"),
            ],
          )
        ],
      ),
    );
  }
}