import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedBackground> createState() =>
      _AnimatedBackgroundState();
}

class _AnimatedBackgroundState
    extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {

  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget orb({
    required Color color,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(.45),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(

      animation: controller,

      builder: (_, __) {

        final t = controller.value * 2 * pi;

        return Stack(
          children: [

            Container(
              color: const Color(0xff06070F),
            ),

            Positioned(
              left: 40 + sin(t) * 60,
              top: 80 + cos(t) * 45,
              child: orb(
                color: Colors.deepPurple,
                size: 320,
              ),
            ),

            Positioned(
              right: 20 + cos(t * .7) * 50,
              bottom: 80 + sin(t) * 70,
              child: orb(
                color: Colors.blue,
                size: 280,
              ),
            ),

            Positioned(
              top: 350 + sin(t * .4) * 80,
              left: 160,
              child: orb(
                color: Colors.pinkAccent,
                size: 240,
              ),
            ),

            Positioned(
              bottom: 250,
              right: 160 + cos(t) * 50,
              child: orb(
                color: Colors.cyanAccent,
                size: 200,
              ),
            ),

            widget.child,
          ],
        );
      },
    );
  }
}