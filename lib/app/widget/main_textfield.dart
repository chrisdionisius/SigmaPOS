import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;

  const MainTextField({Key? key, this.controller, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          hintText: hint,
          fillColor: Colors.white70),
    );
  }
}
