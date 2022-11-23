import 'dart:developer';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flight_booking/core/constants/airport_names.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? departFrom, destinationTo;
  ValueNotifier<DateTime?> departDate = ValueNotifier(null);
  ValueNotifier<DateTime?> returnDate = ValueNotifier(null);
  int? adultCount, childCount;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> airportList = [];
    AirportNames.airportCodeMap.forEach(
      (key, value) => airportList.add(DropdownMenuItem(
        child: Text(value),
        value: key,
      )),
    );
    return Container(
      color: const Color(0xFF03314B),
      // height: double.maxFinite,
      // width: double.maxFinite,
      child: Column(
        children: [
          Expanded(
              child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.all(12.sp),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: SvgPicture.asset(
                    ImageSource.nepalMap,
                    width: 250.w,
                    height: 142.5.h,
                  ),
                ),
                Positioned(
                  left: 10.w,
                  bottom: 0,
                  child: Text(
                    "Let’s book you a flight ✈️",
                    style: TextStyle(
                        fontFamily: "SFPro",
                        color: Colors.white,
                        fontSize: 20.sp),
                  ),
                )
              ],
            ),
          )),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            margin: EdgeInsets.all(12.sp),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF6F6F4),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                        color: const Color(0xFF03314B),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Color(0xFFBEC2C9),
                      labelStyle: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                      tabs: const [
                        Tab(
                          text: 'One Way',
                        ),
                        Tab(
                          text: 'Round Trip',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  locationDropdown(
                      airportList: airportList,
                      value: departFrom,
                      hint: "From",
                      onChanged: (v) {
                        departFrom = v;
                        setState(() {});
                      }),
                  SizedBox(
                    height: 8.h,
                  ),
                  locationDropdown(
                    airportList: airportList,
                    value: destinationTo,
                    hint: "To",
                    onChanged: (v) {
                      destinationTo = v;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DateSelector(
                        date: departDate,
                        hintText: 'Depart',
                      ),
                      _tabController.index == 1
                          ? SizedBox(
                              width: 10.w,
                            )
                          : Container(),
                      _tabController.index == 1
                          ? DateSelector(
                              date: returnDate,
                              hintText: 'Return',
                              firstDate: departDate.value,
                            )
                          : Container()
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  //
                  InkWell(
                    onTap: () async {
                      List? values = await passengerDialog(context);
                      if (values != null) {
                        adultCount = values[0];
                        childCount = values[1];
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 55.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFBEC2C9)),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Passengers',
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFBEC2C9),
                                fontSize: 16.sp),
                          ),
                          Visibility(
                              visible: adultCount != null || childCount != null,
                              child:
                                  Text("$adultCount Adult, $childCount Child"))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  DefaultButton("Search for Flights", () {})
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> passengerDialog(BuildContext context) {
    ValueNotifier<int> adultCount = ValueNotifier(1);
    ValueNotifier<int> childCount = ValueNotifier(0);
    return showDialog(
        context: context,
        builder: ((context) => Dialog(
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total Passengers'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Adults"),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            if (adultCount.value >= 1 && adultCount.value < 9) {
                              adultCount.value++;
                              print('adult increased');
                            }
                          },
                          icon: Container(
                              color: Color(0xFF03314B),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        ValueListenableBuilder(
                            valueListenable: adultCount,
                            builder: (context, adults, _) {
                              return Text(adults.toString());
                            }),
                        IconButton(
                          onPressed: () {
                            if (adultCount.value >= 2 &&
                                adultCount.value < 10) {
                              adultCount.value--;
                              print('adult decreased');
                            }
                          },
                          icon: Container(
                              color: Color(0xFF03314B),
                              child: Center(
                                  child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Children"),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            if (childCount.value >= 0 && childCount.value < 8) {
                              childCount.value++;
                              print('child increased');
                            }
                          },
                          icon: Container(
                              color: Color(0xFF03314B),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        ValueListenableBuilder(
                            valueListenable: childCount,
                            builder: (context, child, _) {
                              return Text(child.toString());
                            }),
                        IconButton(
                          onPressed: () {
                            if (childCount.value >= 1 && childCount.value < 9) {
                              childCount.value--;
                              print('child decreased');
                            }
                          },
                          icon: Container(
                              color: Color(0xFF03314B),
                              child: Center(
                                  child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context,
                                  [adultCount.value, childCount.value]);
                            },
                            child: Text('Okay')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: const Color(0xFFBEC2C9),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  DropdownButton2 locationDropdown(
      {required List<DropdownMenuItem<dynamic>> airportList,
      required dynamic value,
      required String hint,
      required Function(dynamic)? onChanged}) {
    return DropdownButton2(
      items: airportList,
      value: value,
      customButton: Container(
        height: 55.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        width: double.maxFinite,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFBEC2C9)),
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hint,
              style: TextStyle(
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFBEC2C9),
                  fontSize: 14.sp),
            ),
            Visibility(
                visible: value != null,
                child: Text(
                  "${AirportNames.getAirportName(airportCode: value ?? "")} ($value)",
                  style: TextStyle(
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp),
                )),
          ],
        ),
      ),
      buttonWidth: double.maxFinite,
      onChanged: onChanged,
    );
  }
}

class DateSelector extends StatelessWidget {
  final ValueNotifier<DateTime?> date;
  final String hintText;
  final DateTime? firstDate;
  const DateSelector(
      {super.key, required this.date, required this.hintText, this.firstDate});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: date,
        builder: (context, value, child) {
          return Expanded(
            child: InkWell(
              onTap: () async {
                date.value = await showDatePicker(
                    context: context,
                    initialDate: firstDate ?? DateTime.now(),
                    firstDate: firstDate ?? DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                height: 55.h,
                // width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFBEC2C9)),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hintText,
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFBEC2C9),
                          fontSize: 14.sp),
                    ),
                    Visibility(
                        visible: date.value != null,
                        child: Text(
                          DateFormat("MMM d, y")
                              .format(date.value ?? DateTime.now()),
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
