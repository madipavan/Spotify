import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  final String text;
  final String colortext;

  final VoidCallback onPressed;
  const BottomText(
      {super.key,
      required this.onPressed,
      required this.colortext,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              colortext,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xff288CE9)),
            ),
          ),
        ],
      ),
    );
  }
}
