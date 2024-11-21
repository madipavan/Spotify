import 'package:flutter/material.dart';

class TopSubText extends StatelessWidget {
  final VoidCallback onPressed;
  const TopSubText({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "If You Need Any Support",
          style: TextStyle(fontSize: 12),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            "Click Here",
            style: TextStyle(fontSize: 12, color: Color(0xff38B432)),
          ),
        ),
      ],
    );
  }
}
