import 'package:country_picker/country_picker.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/custom_dropdown.dart';
import 'package:flight_booking/widgets/form_fields.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookContactScreen extends StatelessWidget {
  ValueNotifier<bool> isPassenger = ValueNotifier<bool>(false);
  ValueNotifier<String?> title = ValueNotifier(null);
  BookContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Information'),
      ),
      body: SingleChildScrollView(
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
              children: [
                Expanded(flex: 2, child: buildTitleDropDown(title)),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    flex: 5,
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
                InkWell(
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
                        alignment: Alignment.centerLeft, child: Text('+977')),
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
                Expanded(child: CustomTextFormField(hintText: "Phone Number")),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFormField(hintText: "Email (optional)"),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: isPassenger,
                    builder: (context, v, _) {
                      return SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Transform.scale(
                          scale: 1.5.sp,
                          child: Checkbox(
                            value: v,
                            onChanged: (value) {
                              isPassenger.value = value ?? false;
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
                const Text('I am a passenger on the flight.')
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            DefaultButton("Next", () {
              locator<NavigationService>()
                  .navigateTo(Routes.bookPassengerScreen);
            })
          ],
        )),
      ),
    );
  }
}
