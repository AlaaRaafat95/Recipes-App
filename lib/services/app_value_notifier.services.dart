import 'package:recipe_app/utilities/exports.utilities.dart';

class AppValueNotifier {
  ValueNotifier iconNotifier = ValueNotifier(false);

  void changeIcon() {
    iconNotifier.value = !iconNotifier.value;
  }
}
