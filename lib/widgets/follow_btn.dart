import 'package:flutter/material.dart';

class FollowBTN extends StatelessWidget {
  final Function()? function;
  final Color btnColor;
  final Color borderColor;
  final String text;
  final Color textColor;

  const FollowBTN({
    super.key,
    this.function,
    required this.btnColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: function,
        child: Container(
          // height: 28,
          // width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 80),
          decoration: BoxDecoration(
            color: btnColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
