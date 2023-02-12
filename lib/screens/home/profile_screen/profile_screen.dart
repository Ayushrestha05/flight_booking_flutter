import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/constants/network_state.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/cubit/theme_cubit.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/utils/show_toast.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flight_booking/screens/home/my_tickets/model/my_ticket_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../../../core/network/api_manager.dart';

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
                      onTap: () {
                        launchUrl(Uri.parse(baseServerUrl + "/terms"),
                            mode: LaunchMode.externalApplication);
                      },
                      title: Text("Terms and Conditions"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      leading: Icon(Icons.admin_panel_settings),
                      onTap: () {
                        launchUrl(Uri.parse(baseServerUrl + "/privacy"),
                            mode: LaunchMode.externalApplication);
                      },
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
                    ListTile(
                      onTap: () async {
                        _showBottomSheetModel(context);
                      },
                      leading: Icon(Icons.qr_code_scanner),
                      title: Text("Flight QR Scanner"),
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
                      BlocBuilder<ThemeCubit, bool>(
                        builder: (context, state) {
                          return ListTile(
                            leading: Icon(Icons.dark_mode),
                            title: Text("Dark Mode"),
                            trailing: CupertinoSwitch(
                                value: state,
                                onChanged: (value) {
                                  locator<ThemeCubit>().toggleTheme();
                                }),
                          );
                        },
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

  _showBottomSheetModel(BuildContext context) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) {
          return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white),
              height: 150.h,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        // Camera
                        XFile? file = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (file != null) {
                          Uint8List bytes = await file.readAsBytes();
                          String barcode = await scanner.scanBytes(bytes);
                          if (RegExp('(fqr_[0-9]*)').hasMatch(barcode)) {
                            getTicketData(barcode.replaceAll('fqr_', ''));
                          } else {
                            showToast('Invalid QR Code',
                                toastType: ToastType.error);
                          }
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            size: 30,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            'Camera',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80.w,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        //Gallery
                        XFile? file = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (file != null) {
                          Uint8List bytes = await file.readAsBytes();
                          String barcode = await scanner.scanBytes(bytes);
                          if (RegExp('(fqr_[0-9]*)').hasMatch(barcode)) {
                            getTicketData(barcode.replaceAll('fqr_', ''));
                          } else {
                            showToast('Invalid QR Code',
                                toastType: ToastType.error);
                          }
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.photo,
                            size: 30,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            'Gallery',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  getTicketData(String ticketID) async {
    var cancel = BotToast.showLoading();
    final ApiManager _apiManager = ApiManager();
    final ticketQRURL = '/get-ticket-qr';

    Response response = await _apiManager.dio!.post(ticketQRURL, data: {
      'ticket_id': ticketID,
    });

    var data = response.data['data'];
    if (data == null) {
      showToast('Invalid QR Code', toastType: ToastType.error);
    } else if (data.length == 0) {
      showToast('Invalid QR Code', toastType: ToastType.error);
    } else {
      List<MyTicketModel> ticketList = [];
      data.map((e) => ticketList.add(MyTicketModel.fromMap(e))).toList();
      locator<NavigationService>()
          .navigateTo(Routes.bookingDetailsScreen, arguments: ticketList.first);
    }
    cancel();
  }
}
