import 'package:flutter/material.dart';

import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/animated_textfield.dart';
import '../../widgets/auth/auth_logo.dart';
import 'signup_screen.dart';
import '../../services/auth_service.dart';
import '../../services/session_service.dart';
import 'forgot_password_screen.dart';
import '../../widgets/common/bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _loading = true);

  try {
    final result = await _authService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    await SessionService.saveSession(
      token: result["access_token"],
      id: result["user"]["id"],
      name: result["user"]["name"],
      email: result["user"]["email"],
    );

    if (!mounted) return;

    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => BottomNav(
      username: result["user"]["name"],
      email: result["user"]["email"],
    ),
  ),
);
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString().replaceFirst("Exception: ", ""),
        ),
      ),
    );
  } finally {
    if (mounted) {
      setState(() => _loading = false);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthLogo(),

            const SizedBox(height: 40),

            Text(
              "Welcome Back",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Login to continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 35),

            AnimatedTextField(
              controller: _emailController,
              hint: "Email",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
  if (value == null || value.isEmpty) {
    return "Enter your Amrita email";
  }

  final email = value.trim();

  final regex = RegExp(
    r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]*students\.amrita\.edu$",
  );

  if (!regex.hasMatch(email)) {
    return "Use your official Amrita email";
  }

  return null;
},
            ),

            const SizedBox(height: 20),

            AnimatedTextField(
              controller: _passwordController,
              hint: "Password",
              icon: Icons.lock_outline,
              obscure: true,
              validator: (value) {
  if (value == null || value.isEmpty) {
    return "Enter password";
  }

  if (value.length < 6) {
    return "Password must be at least 6 characters";
  }

  return null;
},
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const ForgotPasswordScreen(),
    ),
  );
},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            AuthButton(
              text: "LOGIN",
              loading: _loading,
              onPressed: login,
            ),

            const SizedBox(height: 35),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}