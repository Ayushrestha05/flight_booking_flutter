import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            CircleAvatar(
              radius: 60.r,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Sanskriti Pokharel",
              style: TextStyle(fontFamily: "SFPro", fontSize: 16.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Card(
              child: Column(children: [
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("Edit Profile"),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.policy),
                  title: Text("Terms and Conditions"),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.admin_panel_settings),
                  title: Text("Privacy Policy"),
                  trailing: Icon(Icons.chevron_right),
                ),
              ]),
            ),
            Container(
                margin: EdgeInsets.only(left: 8.w, top: 10.h, bottom: 10.h),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Settings",
                  style: TextStyle(
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp),
                )),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text("Language"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("English"),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.dark_mode),
                    title: Text("Dark Mode"),
                    trailing:
                        CupertinoSwitch(value: false, onChanged: (value) {}),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text("Logout"),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
