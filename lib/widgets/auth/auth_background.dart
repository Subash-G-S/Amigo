import 'dart:ui';
import 'package:flutter/material.dart';

class AuthBackground extends StatefulWidget {
  final Widget child;

  const AuthBackground({
    super.key,
    required this.child,
  });

  @override
  State<AuthBackground> createState() => _AuthBackgroundState();
}

class _AuthBackgroundState extends State<AuthBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildCircle({
    required double size,
    required Alignment begin,
    required Alignment end,
    required Color color,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Align(
          alignment: Alignment.lerp(
            begin,
            end,
            Curves.easeInOut.transform(_controller.value),
          )!,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 80,
                sigmaY: 80,
              ),
              child: const SizedBox(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [

          /// Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff2563EB),
                  Color(0xff4F46E5),
                  Color(0xff7C3AED),
                ],
              ),
            ),
          ),

          /// Floating Circles
          buildCircle(
            size: 260,
            begin: const Alignment(-1.3, -1.2),
            end: const Alignment(-0.7, -0.8),
            color: Colors.white.withOpacity(.10),
          ),

          buildCircle(
            size: 200,
            begin: const Alignment(1.2, -.8),
            end: const Alignment(.7, -.4),
            color: Colors.white.withOpacity(.08),
          ),

          buildCircle(
            size: 320,
            begin: const Alignment(1.3, 1.2),
            end: const Alignment(.6, .9),
            color: Colors.cyanAccent.withOpacity(.10),
          ),

          buildCircle(
            size: 180,
            begin: const Alignment(-1.2, .9),
            end: const Alignment(-.7, .5),
            color: Colors.purpleAccent.withOpacity(.08),
          ),

          /// Dark Overlay
          Container(
            color: Colors.black.withOpacity(.15),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}