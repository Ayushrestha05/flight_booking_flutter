import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/services/shared_pref_services.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flight_booking/screens/auth/model/profile_model.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/form_fields.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileModel? profileModel;
  const EditProfileScreen({super.key, this.profileModel});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<File?> _imageNotifier = ValueNotifier(null);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController.text = widget.profileModel?.name ?? '';
    _emailController.text = widget.profileModel?.email ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //build Edit Profile Screen
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: ScreenPadding(
        child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(
              height: 20.h,
            ),
            //build Edit Profile Form
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  ValueListenableBuilder(
                      valueListenable: _imageNotifier,
                      builder: (context, image, _) {
                        return image != null
                            ? CircleAvatar(
                                radius: 60.r,
                                backgroundImage: FileImage(image as File),
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    widget.profileModel?.profileImage ?? '',
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 60.r,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) => CircleAvatar(
                                  radius: 60.r,
                                  backgroundImage: AssetImage(
                                      AssetImageSource.avatarPlaceholder),
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  radius: 60.r,
                                  backgroundImage: AssetImage(
                                      AssetImageSource.avatarPlaceholder),
                                ),
                              );
                      }),
                  Positioned(
                    bottom: 4,
                    right: 1,
                    child: InkWell(
                      onTap: () {
                        _showBottomSheetModel(context);
                      },
                      child: CircleAvatar(
                        radius: 13.r,
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
              hintText: 'Full Name',
              validator: RequiredValidator(errorText: 'Name is required'),
              controller: _nameController,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
              hintText: 'Email',
              controller: _emailController,
              enabled: false,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomPasswordTextField(
              hintText: 'Current Password',
              controller: _passwordController,
              validator: RequiredValidator(errorText: 'Password is required'),
            ),
          ]),
        ),
      ),
      bottomSheet: ScreenPadding(
          child: DefaultButton('Save', () {
        if (_formKey.currentState!.validate()) {
          locator<AuthBloc>().add(UpdateProfileEvent(
              fullName: _nameController.text,
              password: _passwordController.text,
              image: _imageNotifier.value));
        }
      })),
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
                        await _pickProfileImage(source: 'cam');
                        Navigator.pop(context);
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
                        await _pickProfileImage(source: 'gallery');
                        Navigator.pop(context);
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

  _pickProfileImage({required String source}) async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: source == 'cam' ? ImageSource.camera : ImageSource.gallery);
    if (pickedImage != null) {
      final imagePath = File(pickedImage.path);
      _imageNotifier.value = imagePath;
    } else {
      return null;
    }
  }
}
