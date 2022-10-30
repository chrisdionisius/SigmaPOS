import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const MainButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        primary: Colors.black,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
