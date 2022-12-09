import 'dart:developer';

import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/constants/text_validation.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                  child: Image.asset(
                ImageSource.registerStock,
                width: double.maxFinite,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
              )),
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h),
                color: const Color(0xFF03314B),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: GoogleFonts.outfit(
                          fontSize: 32.h,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFormField(
                      hintText: "Full Name",
                      onSaved: (String? value) {},
                      maxLines: 1,
                      validator: TextValidation.requiredValidation,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFormField(
                      hintText: "Email",
                      onSaved: (String? value) {},
                      maxLines: 1,
                      validator: TextValidation.emailValidation,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomPasswordTextField(
                      hintText: "Password",
                      validator: TextValidation.requiredValidation,
                      onSaved: (String? value) {},
                      hideEye: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomPasswordTextField(
                      hintText: "Re-Enter Password",
                      validator: TextValidation.requiredValidation,
                      onSaved: (String? value) {},
                      hideEye: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DefaultButton("Sign Up", () {
                      locator<NavigationService>()
                          .pushReplacementNamed(Routes.homeScreen);
                    }),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        locator<NavigationService>().pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Already have an account? ",
                                style: GoogleFonts.outfit(color: Colors.white)),
                            TextSpan(
                                text: "Sign In",
                                style: GoogleFonts.outfit(
                                    color: Colors.lightBlueAccent)),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
