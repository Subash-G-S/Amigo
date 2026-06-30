import 'package:flutter/material.dart';

class AuthLogo extends StatefulWidget {
  const AuthLogo({super.key});

  @override
  State<AuthLogo> createState() =>
      _AuthLogoState();
}

class _AuthLogoState
    extends State<AuthLogo>
    with
        SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
      child: Column(
        children: [

          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.people_alt_rounded,
              size: 48,
              color: Color(0xff2563EB),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "AMIGO",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 34,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Connect • Share • Grow",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}