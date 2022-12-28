import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flight_booking/core/model/book_model.dart';
import 'package:flight_booking/core/model/passenger_txt_field_model.dart';
import 'package:flight_booking/core/utils/show_toast.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/custom_dropdown.dart';
import 'package:flight_booking/widgets/form_fields.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../core/routes/route_names.dart';
import '../../core/services/navigation_service.dart';
import '../../core/services/service_locator.dart';

class BookPassengerScreen extends StatefulWidget {
  final BookingModel bookingModel;

  const BookPassengerScreen({super.key, required this.bookingModel});

  @override
  State<BookPassengerScreen> createState() => _BookPassengerScreenState();
}

class _BookPassengerScreenState extends State<BookPassengerScreen> {
  ValueNotifier<bool> agreed = ValueNotifier(false);
  List<PassengerTextFieldModel> passengers = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    passengers = List.generate(
        (widget.bookingModel.totalAdults ?? 1) +
            (widget.bookingModel.totalChildren ?? 0), (index) {
      if (index > ((widget.bookingModel.totalAdults ?? 1) - 1)) {
        return PassengerTextFieldModel(isChild: true);
      } else {
        return PassengerTextFieldModel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Information")),
      body: SingleChildScrollView(
        child: ScreenPadding(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Passenger Information',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '*Please make sure you enter the name as per your valid ID.',
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            // Adult Form Builder
            Form(
              key: _formKey,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  //Individual Passenger Card
                  ValueNotifier<String?> title = ValueNotifier(null);
                  ValueNotifier<String?> gender = ValueNotifier(null);
                  ValueNotifier<String?> document = ValueNotifier(null);
                  ValueNotifier<Country?> nationality = ValueNotifier(null);
                  return Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.sp, vertical: 20.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (passengers[index].isChild ?? false)
                                  ? 'Child ${index - (widget.bookingModel.totalAdults ?? 1) + 1}'
                                  : 'Adult ${index + 1}',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: buildTitleDropDown(
                                      title: title,
                                      onChanged: (p0) {
                                        passengers[index].title = p0;
                                        title.value = p0;
                                      },
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    flex: 7,
                                    child: CustomTextFormField(
                                        validator: RequiredValidator(
                                            errorText: "Please Enter a Value"),
                                        onChanged: (p0) =>
                                            passengers[index].firstName = p0,
                                        hintText: "First Name")),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                                hintText: "Middle Name",
                                onChanged: (p0) =>
                                    passengers[index].middleName = p0),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                                hintText: "Last Name",
                                onChanged: (p0) =>
                                    passengers[index].lastName = p0,
                                validator: RequiredValidator(
                                    errorText: "Please Enter a Value")),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: buildGenderDropDown(
                                      validate: true,
                                      gender: gender,
                                      onChanged: (p0) {
                                        passengers[index].gender = p0;
                                        gender.value = p0;
                                      },
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  flex: 6,
                                  child: InkWell(
                                    onTap: () {
                                      showCountryPicker(
                                          context: context,
                                          onSelect: (value) {
                                            nationality.value = value;
                                            passengers[index].nationality =
                                                value.name;
                                          },
                                          showPhoneCode: true,
                                          favorite: ['NP']);
                                    },
                                    child: ValueListenableBuilder(
                                        valueListenable: nationality,
                                        builder: (context, nation, _) {
                                          return Container(
                                            height: 36.h,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                nation != null
                                                    ? nation.name
                                                    : 'Nationality',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ValueListenableBuilder(
                                valueListenable: document,
                                builder: (context, value, _) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildDocumentDropDown(
                                        validate: true,
                                        document: document,
                                        onChanged: (p0) {
                                          passengers[index].documentType = p0;
                                          document.value = p0;
                                        },
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      AnimatedSizeAndFade.showHide(
                                          show: !['no-document', null]
                                              .any((e) => e == document.value),
                                          child: CustomTextFormField(
                                              hintText: "Document Number",
                                              onChanged: (p0) =>
                                                  passengers[index]
                                                      .documentNumber = p0,
                                              validator: RequiredValidator(
                                                  errorText:
                                                      "Please Enter a Value"))),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: (widget.bookingModel.totalAdults ?? 1) +
                    (widget.bookingModel.totalChildren ?? 0),
              ),
            ),
            Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: agreed,
                    builder: (context, v, _) {
                      return SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Transform.scale(
                          scale: 1.5.sp,
                          child: Checkbox(
                            value: v,
                            onChanged: (value) {
                              agreed.value = value ?? false;
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r)),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  width: 10.w,
                ),
                const Expanded(
                  child: Text(
                      'I now agree the Terms and Conditions to proceed for payment.*'),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            DefaultButton("Continue", () {
              if (agreed.value) {
                if (_formKey.currentState!.validate()) {
                  locator<NavigationService>().navigateTo(
                      Routes.bookConfirmationScreen,
                      arguments: widget.bookingModel
                          .copyWith(passengersTxtFieldModel: passengers));
                }
              } else {
                showToast(
                    "Please agree to the terms and conditions to proceed.",
                    toastType: ToastType.info);
              }
            })
          ],
        )),
      ),
    );
  }
}
