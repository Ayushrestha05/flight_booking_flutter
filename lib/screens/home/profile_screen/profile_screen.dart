import 'package:cached_network_image/cached_network_image.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                CachedNetworkImage(
                  imageUrl: state.profileModel?.profileImage ?? '',
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 60.r,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    radius: 60.r,
                    backgroundImage:
                        AssetImage(AssetImageSource.avatarPlaceholder),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 60.r,
                    backgroundImage:
                        AssetImage(AssetImageSource.avatarPlaceholder),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  state.profileModel?.name ??
                      state.profileModel?.email ??
                      'Guest',
                  style: TextStyle(fontFamily: "SFPro", fontSize: 16.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                  child: Column(children: [
                    ListTile(
                      onTap: () {
                        locator<NavigationService>().navigateTo(
                            Routes.editProfileScreen,
                            arguments: state.profileModel);
                      },
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
                    ListTile(
                      onTap: () {
                        locator<NavigationService>()
                            .navigateTo(Routes.reviewScreen);
                      },
                      leading: Icon(Icons.reviews),
                      title: Text("Review / Inquiry"),
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
                      // ListTile(
                      //   leading: Icon(Icons.language),
                      //   title: Text("Language"),
                      //   trailing: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Text("English"),
                      //       Icon(Icons.chevron_right),
                      //     ],
                      //   ),
                      // ),
                      ListTile(
                        leading: Icon(Icons.dark_mode),
                        title: Text("Dark Mode"),
                        trailing: CupertinoSwitch(
                            value: false, onChanged: (value) {}),
                      ),
                      ListTile(
                        onTap: () {
                          locator<AuthBloc>().add(LogoutEvent());
                        },
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
      },
    );
  }
}
