import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  const PlaceholderImage({
    super.key,
    this.width = double.infinity,
    this.height = 200,
    this.backgroundColor = Colors.grey,
    this.icon = Icons.image,
    this.iconSize = 40,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      child: Center(
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
} 