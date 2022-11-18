import 'dart:developer';

import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/constants/text_validation.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                  child: Image.asset(
                ImageSource.boarding,
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
                      "Login",
                      style: GoogleFonts.outfit(
                          fontSize: 32.h,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
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
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DefaultButton("Sign In", () {
                      // loginValidation(context);
                    }),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => ForgotPasswordScreen()));
                      },
                      child: Text(
                        "Forgot Password",
                        style: GoogleFonts.outfit(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => RegisterScreen()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Don't have an account? ",
                                style: GoogleFonts.outfit(color: Colors.white)),
                            TextSpan(
                                text: "Sign Up",
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
