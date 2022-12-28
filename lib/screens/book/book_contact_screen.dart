import 'package:country_picker/country_picker.dart';
import 'package:flight_booking/core/model/book_model.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/custom_dropdown.dart';
import 'package:flight_booking/widgets/form_fields.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

class BookContactScreen extends StatelessWidget {
  ValueNotifier<bool> isPassenger = ValueNotifier<bool>(false);
  ValueNotifier<String?> title = ValueNotifier(null);
  ValueNotifier<Country?> country = ValueNotifier(null);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final BookingModel bookingModel;
  //Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BookContactScreen({super.key, required this.bookingModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Information'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: ScreenPadding(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Contact Information',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: buildTitleDropDown(title: title)),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                      flex: 5,
                      child: CustomTextFormField(
                        hintText: "First Name",
                        controller: firstNameController,
                        validator: RequiredValidator(
                            errorText: "Please Enter a Value"),
                      )),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                  hintText: "Middle Name", controller: middleNameController),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                hintText: "Last Name",
                controller: lastNameController,
                validator: RequiredValidator(errorText: "Please Enter a Value"),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          onSelect: (value) {
                            country.value = value;
                          },
                          showPhoneCode: true,
                          favorite: ['NP']);
                    },
                    child: Container(
                      height: 36.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Align(
                          alignment: Alignment.centerLeft, child: Text('+977')),
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Expanded(
                      child: CustomTextFormField(
                    hintText: "Phone Number",
                    controller: phoneController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Please Enter a Value"),
                      MinLengthValidator(10,
                          errorText: "Please Enter a Valid Phone Number"),
                      MaxLengthValidator(10,
                          errorText: "Please Enter a Valid Phone Number")
                    ]),
                  )),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(hintText: "Email (optional)"),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              DefaultButton("Next", () {
                if (_formKey.currentState!.validate()) {
                  locator<NavigationService>()
                      .navigateTo(Routes.bookPassengerScreen,
                          arguments: bookingModel.copyWith(
                            // Include Middle Name if only Available
                            name: (middleNameController.text.isNotEmpty)
                                ? '${title.value != null ? title.value : ''} ${firstNameController.text} ${middleNameController.text} ${lastNameController.text}'
                                    .trim()
                                : '${title.value != null ? title.value : ''} ${firstNameController.text} ${lastNameController.text}'
                                    .trim(),
                            email: emailController.text,
                            phone: country.value != null
                                ? '${country.value!.phoneCode} ${phoneController.text}'
                                : '+977 ${phoneController.text}',
                          ));
                }
              })
            ],
          )),
        ),
      ),
    );
  }
}
