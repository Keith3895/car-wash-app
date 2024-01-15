import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final EdgeInsets? padding;

  const RegularButton({
    required Key key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = const ButtonStyle(
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))));

    return SizedBox(
      width: width ?? 350,
      height: height ?? 55,
      child: TextButton(
        style: buttonStyle,
        child: Text(
          text,
          style: const TextStyle(color: Color(0xE72D0C57), fontWeight: FontWeight.w700, fontSize: 15),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
