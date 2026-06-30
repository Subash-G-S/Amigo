import 'package:flutter/material.dart';
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/auth_logo.dart';
import '../../widgets/auth/animated_textfield.dart';
import '../../widgets/auth/auth_button.dart';
import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _loading = false;

  final AuthService _authService = AuthService();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  Future<void> register() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _loading = true;
  });

  try {
    final result = await _authService.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (result["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result["message"]),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result["message"] ?? "Registration failed"),
        ),
      );
    }
  } catch (e) {
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
  "Create Account 🚀",
  textAlign: TextAlign.center,
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
),

const SizedBox(height: 8),

const Text(
  "Join the AMIGO community",
  textAlign: TextAlign.center,
  style: TextStyle(
    color: Colors.white70,
  ),
),

const SizedBox(height: 35),
AnimatedTextField(
  controller: _nameController,
  hint: "Full Name",
  icon: Icons.person_outline,
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter your full name";
    }
    return null;
  },
),
const SizedBox(height:20),
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

const SizedBox(height: 20),

AnimatedTextField(
  controller: _confirmPasswordController,
  hint: "Confirm Password",
  icon: Icons.lock_outline,
  obscure: true,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Confirm your password";
    }

    if (value != _passwordController.text) {
      return "Passwords do not match";
    }

    return null;
  },
),

const SizedBox(height:30),

AuthButton(
  text: "CREATE ACCOUNT",
  loading: _loading,
  onPressed: register,
),
const SizedBox(height:25),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    const Text(
      "Already have an account?",
      style: TextStyle(color: Colors.white70),
    ),

    TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Login"),
    ),

  ],
),
      ],
    ),
  ),
);
  }
  
}