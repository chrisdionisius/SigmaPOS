import 'package:flutter/material.dart';

class PasswordTextfield extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final bool isHidden;
  final Function() onPressed;

  const PasswordTextfield(
      {Key? key,
      required this.controller,
      this.hint,
      required this.isHidden,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      controller: controller,
      obscureText: isHidden,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          suffixIcon: IconButton(
            icon: (isHidden)
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onPressed: () {
              onPressed();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          hintText: "Password",
          fillColor: Colors.white70),
    );
  }
}
