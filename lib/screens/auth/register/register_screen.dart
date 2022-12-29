import 'dart:developer';

import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/constants/text_validation.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/auth_service.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03314B),
      body: SingleChildScrollView(
        child: SafeArea(
            top: false,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    AssetImageSource.registerStock,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    excludeFromSemantics: true,
                    height: 225.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h),
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
                          controller: _nameController,
                          onSaved: (String? value) {},
                          maxLines: 1,
                          validator: TextValidation.requiredValidation,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          hintText: "Email",
                          controller: _emailController,
                          onSaved: (String? value) {},
                          maxLines: 1,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This field is required"),
                            EmailValidator(errorText: "Enter a valid email")
                          ]),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomPasswordTextField(
                          hintText: "Password",
                          controller: _passwordController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This field is required"),
                            MinLengthValidator(6,
                                errorText:
                                    "Password should be at least 6 characters"),
                            PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                errorText:
                                    "Password should have at least one special character")
                          ]),
                          onSaved: (String? value) {},
                          hideEye: true,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomPasswordTextField(
                          hintText: "Re-Enter Password",
                          controller: _rePasswordController,
                          validator: (String? value) {
                            if (value != _passwordController.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                          hideEye: true,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        DefaultButton("Sign Up", () async {
                          if (_formKey.currentState!.validate()) {
                            locator<AuthBloc>().add(RegisterEvent(
                                fullName: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text));
                          }
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
                                    style: GoogleFonts.outfit(
                                        color: Colors.white)),
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
              ),
            )),
      ),
    );
  }
}
