import 'package:intl/intl.dart';

extension DateTimeConvertString on DateTime {
  String convertToDateTimeString() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
