import 'package:recipe_app/utilities/exports.utilities.dart';

class AppValueNotifier {
  ValueNotifier iconNotifier = ValueNotifier(false);
  ValueNotifier selectedIndexNotifier = ValueNotifier(0);

  void changeIcon() {
    iconNotifier.value = !iconNotifier.value;
  }

  void pageChanged(int index) {
    selectedIndexNotifier.value = index;
  }

  void position(int position) {
    selectedIndexNotifier.value = position;
  }
}
