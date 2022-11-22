import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flight_booking/core/constants/airport_names.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
    return Expanded(
      child: Container(
        color: const Color(0xFF03314B),
        // height: double.maxFinite,
        // width: double.maxFinite,
        child: Column(
          children: [
            Expanded(child: Container()),
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
                    DropdownButton2(
                      items: airportList,
                      buttonWidth: double.maxFinite,
                      onChanged: (value) {},
                    ),
                    DefaultButton("Search for Flights", () {})
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
