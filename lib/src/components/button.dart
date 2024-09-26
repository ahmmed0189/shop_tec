import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback ontap;
  final String text;

  const Button({
    super.key,
    required this.ontap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 350,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Hintergrundfarbe
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Abgerundete Ecken
          ),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
