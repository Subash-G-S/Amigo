import 'package:flutter/material.dart';

import '../../services/token_service.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';

import '../auth/login_screen.dart';
import '../../widgets/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {

    try {

      final token =
          await TokenService.getToken();

      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted) return;

      if (token == null) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const LoginScreen(),
          ),
        );

        return;
      }

      UserModel user =
          await AuthService()
              .getCurrentUser(token);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BottomNav(
            username: user.name,
            email: user.email,
          ),
        ),
      );

    } catch (e) {

      await TokenService.logout();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:
            const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [

              Icon(
                Icons.people,
                color: Colors.white,
                size: 80,
              ),

              SizedBox(height: 20),

              Text(
                "AMIGO",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}