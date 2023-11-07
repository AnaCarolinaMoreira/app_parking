// ignore_for_file: must_be_immutable

import 'package:app_parking/app/common/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundCheckbox extends StatelessWidget {
  bool value;
  void Function()? onChanged;
  EdgeInsets? padding;

  RoundCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: GestureDetector(
        onTap: onChanged,
        child: Container(
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: value ? AppColors.blueShadeColor : Colors.grey, width: 2),
          ),
          alignment: Alignment.center,
          child: value
              ? Container(
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blueShadeColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
