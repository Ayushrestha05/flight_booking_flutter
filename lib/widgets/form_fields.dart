import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  const CustomTextFormField(
      {Key? key,
      required this.hintText,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.maxLines,
      this.textStyle,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: TextInputType.emailAddress,
      style: textStyle,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: 'Outfit'),
        contentPadding:
            EdgeInsets.only(top: 10.h, left: 16.w, bottom: 10.h, right: 16.h),
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
      ),
    );
  }
}

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final TextStyle? textStyle;
  final bool? hideEye;
  ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  CustomPasswordTextField(
      {super.key,
      required this.hintText,
      this.validator,
      this.onSaved,
      this.textStyle,
      this.controller,
      this.hideEye});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _obscureText,
        builder: (context, obscure, _) {
          return TextFormField(
            controller: controller,
            validator: validator,
            onSaved: onSaved,
            obscureText: obscure,
            style: textStyle,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              suffixIcon: (hideEye ?? false)
                  ? null
                  : IconButton(
                      onPressed: () {
                        _obscureText.value = !_obscureText.value;
                      },
                      icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off)),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Outfit',
              ),
              contentPadding:
                  EdgeInsets.only(top: 10.h, left: 16.w, bottom: 10.h),
              border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
            ),
          );
        });
  }
}
