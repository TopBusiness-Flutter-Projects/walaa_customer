import 'package:flutter/material.dart';

class OutLineButtonWidget extends StatelessWidget {
  const OutLineButtonWidget({Key? key, required this.text, required this.borderColor, required this.onclick}) : super(key: key);

  final String text;
  final Color borderColor;
  final VoidCallback onclick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>onclick(),
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
