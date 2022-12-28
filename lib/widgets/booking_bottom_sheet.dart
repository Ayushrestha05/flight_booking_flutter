import 'package:cached_network_image/cached_network_image.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/model/book_model.dart';
import 'package:flight_booking/core/model/class_model.dart';
import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/utils/show_toast.dart';
import 'package:flight_booking/screens/home/search_screen/model/flight_search_view_model.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flight_booking/screens/home/my_tickets/widgets/flight_details_bottom_sheet.dart';

showFlightBookingBottomSheet(
  BuildContext context, {
  bool? isReturn,
  bool? isReturnNavigate,
  FlightModel? model,
  BookingModel? bookingModel,
  FlightSearchViewModel? viewModel,
  int? totalAdults,
  int? totalChildren,
}) {
  ValueNotifier<int?> _selectedClass = ValueNotifier(null);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 19.h,
            ),
            // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Flight Details',
                  style: TextStyle(fontSize: 20.sp),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            // Flight Company and Logo
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: model?.company?.image ?? '',
                  placeholder: (context, url) => CircleAvatar(
                    radius: 25.r,
                    backgroundImage: AssetImage(ImageSource.imagePlaceholder),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 25.r,
                    backgroundImage: AssetImage(ImageSource.imagePlaceholder),
                  ),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 25.r,
                    backgroundImage: imageProvider,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  model?.company?.name ?? '',
                  style: TextStyle(fontSize: 16.sp),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            // Flight Route and Price
            buildFlightDetails(
              model: model!,
            ),
            SizedBox(
              height: 15.h,
            ),
            ValueListenableBuilder(
                valueListenable: _selectedClass,
                builder: (context, value, child) {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.sp,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      ClassModel currentClass = model.classes![index];
                      return InkWell(
                        onTap: () {
                          if (value == currentClass.id) {
                            _selectedClass.value = null;
                          } else {
                            _selectedClass.value = currentClass.id;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: value == currentClass.id
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: value == currentClass.id ? 2 : 1),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(currentClass.className ?? ''),
                              Text(
                                "NRs ${currentClass.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: model.classes?.length ?? 0,
                  );
                }),
            SizedBox(
              height: 15.h,
            ),
            // Book Button
            DefaultButton("Book Flight", () {
              if (_selectedClass.value == null) {
                showToast("Please select a class",
                    toastType: ToastType.error,
                    toastDuration: const Duration(milliseconds: 800));
              } else {
                //Check if this is a Two-Way Flight
                if (isReturn ?? false) {
                  //Check if the Two-Way Flight List Navigation should be done
                  if (isReturnNavigate ?? false) {
                    locator<NavigationService>().navigateTo(
                        Routes.bookContactScreen,
                        arguments: viewModel!.bookingModel!.copyWith(
                            departure_flight: model,
                            departure_class_id: _selectedClass.value));
                  } else {
                    locator<NavigationService>().navigateTo(
                        Routes.returnFlightListScreen,
                        arguments: viewModel!.copyWith(
                            bookingModel: BookingModel(
                                totalAdults: totalAdults,
                                totalChildren: totalChildren,
                                arrival_flight: model,
                                arrival_class_id: _selectedClass.value)));
                  }
                } else {
                  locator<NavigationService>().navigateTo(
                      Routes.bookContactScreen,
                      arguments: BookingModel(
                          totalAdults: totalAdults,
                          totalChildren: totalChildren,
                          arrival_flight: model,
                          arrival_class_id: _selectedClass.value));
                }
              }
            }),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      );
    },
  );
}
