import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  final bool showText;
  final String? text;
  final TextStyle? textStyle;

  const LogoWidget({
    super.key,
    this.size,
    this.color,
    this.showText = true,
    this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/logo.png',
          width: size ?? 40,
          height: size ?? 40,
          color: color,
        ),
        if (showText) ...[
          const SizedBox(width: 8),
          Text(
            text ?? 'Exhibition Hub',
            style: textStyle ?? Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ],
    );
  }
} 