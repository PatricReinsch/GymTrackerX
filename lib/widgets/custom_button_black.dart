import 'package:flutter/material.dart';

class CustomButtonBlack extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButtonBlack({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding:
        const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
