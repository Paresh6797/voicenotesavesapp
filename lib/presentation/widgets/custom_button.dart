import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? textSize;
  final Widget? child;
  final double? elevation;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding; // Added padding property

  const CustomButton({
    super.key,
    this.onPress,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius,
    this.textSize = 16.0,
    this.child,
    this.elevation,
    this.padding,
    this.decoration, // Added padding property
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation ?? 0,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      color: backgroundColor,
      child: InkWell(
        onTap: onPress,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          padding: padding,
          decoration: decoration,// Apply padding, default to null if not provided
          child: child ??
              Text(
                text ?? '',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: textSize,
                ),
              ),
        ),
      ),
    );
  }
}