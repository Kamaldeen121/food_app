import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? height;
  final int? maxLines;
  final TextOverflow? textOverflow;
  const SmallText({
    super.key,
    this.maxLines,
    required this.text,
    this.fontSize = 15,
    this.fontWeight,
    this.color,
    this.height,
    this.textOverflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      ),
    );
  }
}
