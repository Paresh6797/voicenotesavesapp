import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final double size;
  final String text;
  final FontWeight fontWeight;
  final Color  clr;
  final TextOverflow? overflowText;
  final TextAlign? textAlign;

  const CustomText(
      {Key? key,
        required this.text,
        required this.size,
        required this.clr,
        required this.fontWeight, this.overflowText, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontWeight: fontWeight,
        color: clr,
        fontSize: size,
      ),
    );
  }
}