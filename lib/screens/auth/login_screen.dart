import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/token_service.dart';
import '../../widgets/common/bottom_nav.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/inputs/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, .15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final response = await AuthService().login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response["user"] != null) {

        await TokenService.saveToken(
          response["access_token"],
        );

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BottomNav(
              username: response["user"]["name"],
              email: response["user"]["email"],
            ),
          ),
        );

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Credentials"),
          ),
        );

      }

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );

    } finally {

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

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

        child: SafeArea(

          child: Center(

            child: SingleChildScrollView(

              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: FadeTransition(

                opacity: _fadeAnimation,

                child: SlideTransition(

                  position: _slideAnimation,

                  child: Column(

                    children: [

                      Hero(

                        tag: "logo",

                        child: Container(

                          height: 95,

                          width: 95,

                          decoration: BoxDecoration(

                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(30),

                            boxShadow: [

                              BoxShadow(

                                color: Colors.black.withOpacity(.15),

                                blurRadius: 25,

                              ),

                            ],

                          ),

                          child: const Icon(

                            Icons.forum,

                            size: 50,

                            color: Color(0xff4F46E5),

                          ),

                        ),

                      ),

                      const SizedBox(height: 24),

                      const Text(

                        "AMIGO",

                        style: TextStyle(

                          color: Colors.white,

                          fontWeight: FontWeight.bold,

                          fontSize: 38,

                          letterSpacing: 2,

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

                      const SizedBox(height: 40),

                      GlassCard(

                        child: Column(

                          children: [

                            const Text(

                              "Welcome Back",

                              style: TextStyle(

                                color: Colors.white,

                                fontWeight: FontWeight.bold,

                                fontSize: 24,

                              ),

                            ),

                            const SizedBox(height: 6),

                            const Text(

                              "Login to continue",

                              style: TextStyle(

                                color: Colors.white70,

                              ),

                            ),

                            const SizedBox(height: 28),

                            CustomTextField(

                              controller: emailController,

                              hint: "Email Address",

                              icon: Icons.email_outlined,

                            ),

                            const SizedBox(height: 18),

                            CustomTextField(

                              controller: passwordController,

                              hint: "Password",

                              icon: Icons.lock_outline,

                              obscureText: true,

                            ),

                            const SizedBox(height: 28),

                            CustomButton(

                              text: "Login",

                              icon: Icons.login,

                              loading: isLoading,

                              onPressed: login,

                            ),

                            const SizedBox(height: 18),

                            TextButton(

                              onPressed: () {},

                              child: const Text(

                                "Create an Account",

                                style: TextStyle(

                                  color: Colors.white,

                                  fontWeight: FontWeight.w600,

                                ),

                              ),

                            ),

                          ],

                        ),

                      ),

                    ],

                  ),

                ),

              ),

            ),

          ),

        ),

      ),

    );

  }

}