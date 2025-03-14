import 'package:flutter/material.dart';
import 'package:food_app/widgets/small_text.dart';

class IconandText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconandText({
    required this.icon,
    required this.text,
    required this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
          fontWeight: FontWeight.w300,
          fontSize: 10,
          textOverflow: TextOverflow.ellipsis,
          maxLines: 1,
        )
      ],
    );
  }
}
