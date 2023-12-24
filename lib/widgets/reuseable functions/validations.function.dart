import 'package:recipe_app/utilities/exports.utilities.dart';

String? emailValidator(String value) {
  if (value.isEmpty) {
    return "Please enter password";
  } else {
    if (!AppStrings.regex.hasMatch(value)) {
      return "Enter valid password";
    } else {
      return null;
    }
  }
}

String? passwordValidator(String value) {
  if (value.isEmpty) {
    return "Please enter password";
  } else {
    if (!AppStrings.regex.hasMatch(value)) {
      return "Enter valid password";
    } else {
      return null;
    }
  }
}

String? nameValidator(String value) {
  if (value.isEmpty) {
    return "Please Enter Your Name";
  }
  if (!(value.startsWith(RegExp(r'[A-Z]')))) {
    return "Please,Start With Capital Letter";
  }
  return null;
}
