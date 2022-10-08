import 'package:flutter/material.dart';

class TotalOrderButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final int total;

  const TotalOrderButton(
      {Key? key, required this.label, this.onPressed, required this.total})
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
        onPressed!();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 15)),
            Text('Rp $total', style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
