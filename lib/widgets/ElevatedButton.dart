import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
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

  const CustomElevatedButton({
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
    return SizedBox(
      width: width ?? 350,
      height: height ?? 55,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius ?? 8),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            color ?? Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 15,
            fontWeight: fontWeight ?? FontWeight.w700,
            color: textColor ?? Colors.white,
          ),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
