import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/custom_dropdown.dart';
import 'package:flight_booking/widgets/form_fields.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/routes/route_names.dart';
import '../../core/services/navigation_service.dart';
import '../../core/services/service_locator.dart';

class BookPassengerScreen extends StatelessWidget {
  ValueNotifier<String?> title = ValueNotifier(null);
  ValueNotifier<String?> gender = ValueNotifier(null);
  ValueNotifier<String?> document = ValueNotifier(null);
  ValueNotifier<bool> agreed = ValueNotifier(false);
  BookPassengerScreen({super.key});

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
              '*Please make sure you enter the name as per your valid photo ID.',
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp)),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 3, child: buildTitleDropDown(title)),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            flex: 7,
                            child: CustomTextFormField(hintText: "First Name")),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFormField(hintText: "Middle Name"),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFormField(hintText: "Last Name"),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(flex: 3, child: buildGenderDropDown(gender)),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          flex: 6,
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  onSelect: (value) {},
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
                                  alignment: Alignment.centerLeft,
                                  child: Text('Nationality')),
                            ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDocumentDropDown(document),
                              SizedBox(
                                height: 10.h,
                              ),
                              AnimatedSizeAndFade.showHide(
                                  show: !['no-document', null]
                                      .any((e) => e == document.value),
                                  child: CustomTextFormField(
                                      hintText: "Document Number"))
                            ],
                          );
                        }),
                  ],
                ),
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
                Expanded(
                  child: Text(
                      'I now agree the Terms and Conditions to proceed for payment.*'),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            DefaultButton("Continue", () {
              locator<NavigationService>()
                  .navigateTo(Routes.bookConfirmationScreen);
            })
          ],
        )),
      ),
    );
  }
}
