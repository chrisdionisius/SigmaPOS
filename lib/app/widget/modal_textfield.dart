import 'package:flutter/material.dart';

class ModalTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final Widget? prefix;

  const ModalTextField({Key? key, this.controller, this.hint, this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
          prefixIcon: prefix != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: prefix,
                )
              : null,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          hintText: hint,
          fillColor: Colors.white70),
    );
  }
}
