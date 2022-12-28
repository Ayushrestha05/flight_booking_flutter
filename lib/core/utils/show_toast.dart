import 'package:bot_toast/bot_toast.dart';
import 'package:flight_booking/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ToastType { error, info, success, warning }

Color getBackgroundColor(ToastType toastType) {
  switch (toastType) {
    case ToastType.success:
      return AppColors.successBackgroundColor;

    case ToastType.info:
      return AppColors.infoBackgroundColor;

    case ToastType.error:
      return AppColors.warningBackgroundColor;

    case ToastType.warning:
      return Colors.yellow;

    default:
      return AppColors.infoBackgroundColor;
  }
}

Color getColor(ToastType toastType) {
  switch (toastType) {
    case ToastType.success:
      return AppColors.successColor;

    case ToastType.info:
      return AppColors.primaryColor;

    case ToastType.error:
      return AppColors.secondaryColor;

    case ToastType.warning:
      // return Colors.yellow[900]!;
      return AppColors.primaryColor;

    default:
      return AppColors.primaryColor;
  }
}

Widget getIconWidget(ToastType toastType) {
  switch (toastType) {
    case ToastType.success:
      return const Icon(Icons.check);

    case ToastType.info:
      return const Icon(Icons.info);

    case ToastType.error:
      return const Icon(Icons.error);

    case ToastType.warning:
      return Icon(
        Icons.warning,
        color: Colors.amber[800],
      );

    default:
      return const Icon(Icons.info);
  }
}

void showToast(String message,
    {ToastType toastType = ToastType.info,
    Duration animationDuration = const Duration(milliseconds: 300),
    Duration? toastDuration = const Duration(seconds: 2)}) {
  // SizedBox.shrink();
  BotToast.showCustomText(
    duration: toastDuration,
    onlyOne: true,
    clickClose: false,
    crossPage: true,
    animationDuration: animationDuration,
    align: const Alignment(0, 0.95),
    animationReverseDuration: animationDuration,
    toastBuilder: (_) => Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: getBackgroundColor(toastType),
        borderRadius: BorderRadius.circular(4.h),
      ),
      // constraints: BoxConstraints(minHeight: 40.h, maxHeight: double.infinity),
      height: 40.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: getColor(toastType),
              borderRadius: BorderRadius.circular(8.h),
            ),
            margin: EdgeInsets.all(5.h),
            width: 4.w,
          ),
          SizedBox(
            width: 4.w,
          ),
          getIconWidget(toastType),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 3.0.w, right: 15.w),
              child: Text(
                message,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: getColor(toastType),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
