import 'package:flutter/material.dart';

import '../../widgets/bottom_nav.dart';
import '../../services/auth_service.dart';
import '../../services/token_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> login() async {

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final response =
          await AuthService().login(
        email: emailController.text.trim(),
        password:
            passwordController.text.trim(),
      );

      print(response);

      if (response["user"] != null) {

        await TokenService.saveToken(
          response["access_token"],
        );
        final token =
            await TokenService.getToken();

        print(token);

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

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Invalid credentials",
            ),
          ),
        );
      }

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(24),
        decoration:
            const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
          ),
        ),
        child: Center(
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.all(24),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                children: [

                  const Text(
                    "AMIGO",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  CustomTextField(
                    controller: emailController,
                    hint: "Email",
                    icon: Icons.email_outlined,
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  CustomTextField(
  controller: passwordController,
  hint: "Password",
  icon: Icons.lock_outline,
  obscure: true,
),

                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width:
                        double.infinity,
                    child:
                        CustomButton(
  text: "Login",
  icon: Icons.login,
  loading: isLoading,
  onPressed: login,
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