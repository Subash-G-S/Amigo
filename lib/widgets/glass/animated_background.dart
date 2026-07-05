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
      duration: const Duration(seconds: 35),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(

      animation: controller,

      builder: (_, __) {

        return Container(

          decoration: BoxDecoration(

            gradient: LinearGradient(

              begin: Alignment(
                -1 + controller.value,
                -1,
              ),

              end: Alignment(
                1,
                1 - controller.value,
              ),

              colors: const [

                Color(0xffFFFDF8),

                Color(0xffFAF5EB),

                Color(0xffF5EFD8),

                Color(0xffE8D7A3),

              ],
            ),
          ),
          child: Stack(
  children: [

    Opacity(
      opacity: .12,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(
              controller.value * 2 - 1,
              -1,
            ),
            end: Alignment(
              1,
              controller.value * 2 - 1,
            ),
            colors: const [
              Colors.transparent,
              Color(0xffD4AF37),
              Colors.transparent,
            ],
          ),
        ),
      ),
      
    ),

    widget.child,
  ],
),
        );
      },
    );
  }
}