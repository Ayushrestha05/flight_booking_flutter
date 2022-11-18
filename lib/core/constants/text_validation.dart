import 'package:form_validator/form_validator.dart';

class TextValidation {
  static final emailValidation =
      ValidationBuilder().email("Please Enter a Value").required().build();
  static final requiredValidation = ValidationBuilder().required().build();
}
