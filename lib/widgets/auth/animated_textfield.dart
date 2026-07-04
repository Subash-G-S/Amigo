import 'package:flutter/material.dart';

class AnimatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AnimatedTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> {
  bool _focused = false;
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() {
          _focused = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _focused
                ? Colors.white
                : Colors.white54,
            width: 2,
          ),
        ),
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscure ? _hidePassword : false,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: false,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: Colors.white70,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: _focused
                  ? Colors.white
                  : Colors.white70,
            ),
            suffixIcon: widget.obscure
                ? IconButton(
                    icon: Icon(
                      _hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                        color : Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}