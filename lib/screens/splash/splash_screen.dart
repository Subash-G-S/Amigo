import 'package:flutter/material.dart';

import '../../services/token_service.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';

import '../auth/login_screen.dart';
import '../../widgets/common/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: .75,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();

    checkLogin();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> navigateTo(Widget page) async {

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 700),
        pageBuilder: (_, animation, __) => page,
        transitionsBuilder:
            (_, animation, __, child) {

          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  Future<void> checkLogin() async {

    try {

      final token =
          await TokenService.getToken();
          print("========================");
print("Saved Token:");
print(token);
print("========================");

      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (token == null) {

        await navigateTo(
          const LoginScreen(),
        );

        return;
      }

      UserModel user =
          await AuthService()
              .getCurrentUser(token);

      await navigateTo(

        BottomNav(
          username: user.name,
          email: user.email,
        ),

      );

    } catch (e) {

  print("Splash Error:");
  print(e);

  // Only clear the session if the token is actually invalid.
  if (e.toString().contains("401")) {
    await TokenService.logout();
  }

  await navigateTo(
    const LoginScreen(),
  );
}
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [

              Color(0xff6A11CB),

              Color(0xff2575FC),

            ],

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

          ),

        ),

        child: Center(

          child: FadeTransition(

            opacity: _fadeAnimation,

            child: ScaleTransition(

              scale: _scaleAnimation,

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Hero(

                    tag: "logo",

                    child: Container(

                      height: 110,

                      width: 110,

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(32),

                        boxShadow: [

                          BoxShadow(

                            color: Colors.black.withOpacity(.15),

                            blurRadius: 25,

                          ),

                        ],

                      ),

                      child: const Icon(

                        Icons.forum,

                        size: 58,

                        color: Color(0xff4F46E5),

                      ),

                    ),

                  ),

                  const SizedBox(height: 28),

                  const Text(

                    "AMIGO",

                    style: TextStyle(

                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                      fontSize: 40,

                      letterSpacing: 3,

                    ),

                  ),

                  const SizedBox(height: 10),

                  const Text(

                    "Connect • Share • Discover",

                    style: TextStyle(

                      color: Colors.white70,

                      fontSize: 16,

                    ),

                  ),

                  const SizedBox(height: 50),

                  const SizedBox(

                    width: 28,

                    height: 28,

                    child: CircularProgressIndicator(

                      strokeWidth: 2.5,

                      color: Colors.white,

                    ),

                  ),

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }

}