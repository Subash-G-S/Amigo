import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_logo.dart';
import '../../widgets/auth/animated_textfield.dart';
import 'otp_screen.dart';




class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  
  final _formKey = GlobalKey<FormState>();

final _emailController = TextEditingController();

final AuthService _authService = AuthService();

bool _loading = false;
  @override
void dispose() {
  _emailController.dispose();
  super.dispose();
}
Future<void> sendOTP() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _loading = true;
  });

  try {
    final result = await _authService.forgotPassword(
      email: _emailController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result["message"]),
      ),
    );

    // NEXT:
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => OtpScreen(
      email: _emailController.text.trim(),
    ),
  ),
);
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString().replaceAll("Exception: ", ""),
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
          "Forgot Password",
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
          "Enter your Amrita email.\nWe'll send you a verification code.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),

        const SizedBox(height: 35),

        AnimatedTextField(
          controller: _emailController,
          hint: "Amrita Email",
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your email";
            }

            final regex = RegExp(
              r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]*students\.amrita\.edu$",
            );

            if (!regex.hasMatch(value.trim())) {
              return "Use your official Amrita email";
            }

            return null;
          },
        ),

        const SizedBox(height: 30),

        AuthButton(
          text: "SEND OTP",
          loading: _loading,
          onPressed: sendOTP,
        ),

        const SizedBox(height: 20),

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Back to Login"),
        ),
      ],
    ),
  ),
);
  }
}