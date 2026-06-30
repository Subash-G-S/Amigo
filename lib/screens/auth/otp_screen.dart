import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_logo.dart';
import '../../widgets/auth/animated_textfield.dart';
import 'reset_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({
    super.key,
    required this.email,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}
class _OtpScreenState extends State<OtpScreen> {
    final _formKey = GlobalKey<FormState>();

final _otpController = TextEditingController();

final AuthService _authService = AuthService();

bool _loading = false;
@override
void dispose() {
  _otpController.dispose();
  super.dispose();
}
@override
Widget build(BuildContext context) {
Future<void> verifyOTP() async {

  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _loading = true;
  });

  try {

    final result = await _authService.verifyOTP(
      email: widget.email,
      otp: _otpController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result["message"]),
      ),
    );

    // TODO
    // Navigate to Reset Password Screen
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ResetPasswordScreen(
      email: widget.email,
      otp: _otpController.text.trim(),
    ),
  ),
);

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
return AuthBackground(
  child: Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthLogo(),

const SizedBox(height: 30),

Text(
  "Verify OTP",
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
  "Enter the 6-digit OTP sent to your email",
  textAlign: TextAlign.center,
  style: TextStyle(
    color: Colors.white70,
  ),
),

const SizedBox(height: 35),
AnimatedTextField(
  controller: _otpController,
  hint: "Enter OTP",
  icon: Icons.password,
  keyboardType: TextInputType.number,
  validator: (value) {

    if (value == null || value.isEmpty) {
      return "Enter OTP";
    }

    if (value.length != 6) {
      return "OTP must be 6 digits";
    }

    return null;
  },
),
const SizedBox(height: 30),

AuthButton(
  text: "VERIFY OTP",
  loading: _loading,
  onPressed: verifyOTP,
),
              ],
    ),
  ),
);
}
}