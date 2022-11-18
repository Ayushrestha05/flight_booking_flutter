import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox DefaultButton(String buttonText, Function() onPressed) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFF103388)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Text(
          buttonText,
          style: TextStyle(fontFamily: "Outfit", fontSize: 16.sp),
        ),
      ),
    ),
  );
}
