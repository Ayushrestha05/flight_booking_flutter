import 'package:bot_toast/bot_toast.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/utils/show_toast.dart';
import 'package:flight_booking/screens/home/profile_screen/review_screen/repo/review_repo.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/form_fields.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Review / Inquiry'),
      ),
      body: SingleChildScrollView(
        child: ScreenPadding(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  hintText: 'First Name*',
                  controller: _firstNameController,
                  validator:
                      RequiredValidator(errorText: 'Please Enter a Value'),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  hintText: 'Last Name*',
                  controller: _lastNameController,
                  validator:
                      RequiredValidator(errorText: 'Please Enter a Value'),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  hintText: 'Email*',
                  controller: _emailController,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Please Enter a Value'),
                    EmailValidator(
                        errorText: 'Please Enter a Valid Email Address'),
                  ]),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                    hintText: 'Phone (Optional)', controller: _phoneController),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  hintText: 'Message*',
                  controller: _messageController,
                  validator:
                      RequiredValidator(errorText: 'Please Enter a Value'),
                  maxLines: null,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: ScreenPadding(
          child: DefaultButton("Submit", () async {
        if (_formKey.currentState!.validate()) {
          var cancel = BotToast.showLoading();
          await ReviewRepo()
              .saveReview(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  message: _messageController.text)
              .then((value) => value.fold((l) {
                    cancel();
                    showToast("Review Saved", toastType: ToastType.success);

                    locator<NavigationService>().pop();
                  }, (r) {
                    cancel();
                    showToast(r['message'], toastType: ToastType.error);
                  }));
        }
      })),
    );
  }
}
