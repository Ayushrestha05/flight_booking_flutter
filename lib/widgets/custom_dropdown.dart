import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customDropDown(ValueNotifier notifier,
    {required List<DropdownMenuItem> items,
    required String hint,
    bool? validate = true}) {
  return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, _) {
        return DropdownButtonFormField2(
          value: value,
          items: items,
          onChanged: (value) => notifier.value = value,
          validator: (value) {
            if (value == null && (validate ?? true)) {
              return "\t\t\t\tPlease Select a Value";
            }
            return null;
          },
          hint: Text(hint),
          buttonHeight: 36.h,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
          dropdownDecoration:
              BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          style: value == null ? const TextStyle(color: Colors.grey) : null,
        );
      });
}

Widget buildTitleDropDown(ValueNotifier title) {
  return customDropDown(title,
      items: [
        DropdownMenuItem(
          child: Text("Mr."),
          value: "Mr.",
        ),
        DropdownMenuItem(
          child: Text("Mrs."),
          value: "Mrs.",
        ),
        DropdownMenuItem(
          child: Text("Miss"),
          value: "Miss",
        ),
        DropdownMenuItem(
          child: Text("Master"),
          value: "Master",
        ),
        DropdownMenuItem(
          child: Text("None"),
          value: null,
        ),
      ],
      hint: "Title",
      validate: false);
}

Widget buildGenderDropDown(ValueNotifier gender) {
  return customDropDown(gender,
      items: [
        DropdownMenuItem(
          child: Text("Male"),
          value: "Mr.",
        ),
        DropdownMenuItem(
          child: Text("Female"),
          value: "Mrs.",
        ),
        DropdownMenuItem(
          child: Text("Others"),
          value: "Miss",
        ),
      ],
      hint: "Gender");
}

Widget buildDocumentDropDown(ValueNotifier document) {
  return customDropDown(document,
      items: [
        DropdownMenuItem(
          child: Text("No Document"),
          value: "no-document",
        ),
        DropdownMenuItem(
          child: Text("Citizenship"),
          value: "citizenship",
        ),
        DropdownMenuItem(
          child: Text("Passport"),
          value: "passport",
        ),
        DropdownMenuItem(
          child: Text("ID Card"),
          value: "id-card",
        ),
      ],
      hint: "Document Type");
}
