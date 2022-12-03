import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const ScreenPadding({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w),
      child: child,
    );
  }
}
