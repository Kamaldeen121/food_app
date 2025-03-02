import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final double? height;
  final TextOverflow? textOverflow;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;

  const BigText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.fontWeight = FontWeight.bold,
    this.color,
    this.height,
    this.textOverflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: 1,
      softWrap: true,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      ),
    );
  }
}
