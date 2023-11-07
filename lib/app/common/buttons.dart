// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlatElevatedIconButton extends StatelessWidget {
  Function()? onPressed;
  final double width;
  final String text;
  Color? backgroundColor;
  Color? borderColor;
  Color? textColor;

  EdgeInsets? padding;
  EdgeInsets? margin;

  FlatElevatedIconButton({
    super.key,
    this.onPressed,
    required this.width,
    required this.text,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: padding ?? EdgeInsets.zero,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            minimumSize: Size(width, 47),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor ?? Colors.transparent, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ));
  }
}
