import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;

  const PasswordTextfield({
    Key? key,
    this.controller,
    this.hint,
  }) : super(key: key);

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      controller: widget.controller,
      obscureText: isHidden,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          suffixIcon: IconButton(
            icon: (isHidden)
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                isHidden = !isHidden;
              });
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
          hintText: (widget.hint) ?? 'Password',
          fillColor: Colors.white70),
    );
  }
}
