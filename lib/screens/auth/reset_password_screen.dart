import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/auth_logo.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/animated_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {

  final String email;
  final String otp;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}
class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
        final _formKey = GlobalKey<FormState>();

final _passwordController = TextEditingController();

final _confirmController = TextEditingController();

final AuthService _authService = AuthService();

bool _loading = false;
@override
void dispose() {

  _passwordController.dispose();

  _confirmController.dispose();

  super.dispose();

}
Future<void> resetPassword() async {

  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _loading = true;
  });

  try {

    final result =
        await _authService.resetPassword(
      email: widget.email,
      otp: widget.otp,
      password: _passwordController.text,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result["message"]),
      ),
    );

    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString().replaceAll(
            "Exception: ",
            "",
          ),
        ),
      ),
    );

  }

  if (mounted) {
    setState(() {
      _loading = false;
    });
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

          const SizedBox(height: 30),

          Text(
            "Reset Password",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Choose a new password",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 35),

          AnimatedTextField(
            controller: _passwordController,
            hint: "New Password",
            icon: Icons.lock_outline,
            obscure: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter password";
              }

              if (value.length < 6) {
                return "Minimum 6 characters";
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          AnimatedTextField(
            controller: _confirmController,
            hint: "Confirm Password",
            icon: Icons.lock_outline,
            obscure: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Confirm password";
              }

              if (value != _passwordController.text) {
                return "Passwords do not match";
              }

              return null;
            },
          ),

          const SizedBox(height: 30),

          AuthButton(
            text: "RESET PASSWORD",
            loading: _loading,
            onPressed: resetPassword,
          ),
        ],
      ),
    ),
  );
}
}