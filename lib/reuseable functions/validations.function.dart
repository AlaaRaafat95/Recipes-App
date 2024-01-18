import 'package:recipe_app/utilities/exports.utilities.dart';

abstract class Validation {
  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return "Please enter email : Johndoe65@gmail.com";
    } else {
      if (!AppStrings.regex.hasMatch(value)) {
        return "Enter valid email";
      } else if (!value.endsWith(".com")) {
        return "Correct format email : Johndoe65@gmail.com";
      } else {
        return null;
      }
    }
  }

  static String? passwordValidator(String value) {
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

  static String? nameValidator(String value) {
    if (!validateUsername(value)) {
      return ("Please enter valid name like : John Doe");
    }
    return null;
  }

  static bool validateUsername(value) {
    List<String> words = value.split(' ');
    // check if username consist of two words
    if (words.length != 2) {
      return false;
    }

    // Check if each word starts with a capital letter

    return words.every((word) => word.startsWith(RegExp(r'^[A-Z]')));
  }
}
