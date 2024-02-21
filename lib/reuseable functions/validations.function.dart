import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

abstract class Validation {
  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return "pleaseEnterEmail".tr();
    } else {
      if (!AppImageAssets.regex.hasMatch(value)) {
        return "enterValidEmail".tr();
      } else if (!value.endsWith(".com")) {
        return "enterValidEmail".tr();
      } else {
        return null;
      }
    }
  }

  static String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "pleaseEnterPassword".tr();
    } else {
      if (!AppImageAssets.regex.hasMatch(value)) {
        return "enterValidPassword".tr();
      } else {
        return null;
      }
    }
  }

  static String? nameValidator(String value) {
    if (!validateUsername(value)) {
      return "pleaseEnterValidName".tr();
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
