import 'package:flutter/material.dart';

class ContainerAndIcon extends StatelessWidget {
  final IconData icon;
  Color? iconColor, color;

  ContainerAndIcon({
    required this.icon,
    this.iconColor = Colors.black,
    this.color = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(100)),
        child: Icon(
          icon,
          color: iconColor,
        ));
  }
}
