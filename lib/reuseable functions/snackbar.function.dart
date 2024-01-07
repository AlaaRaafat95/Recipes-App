import 'package:recipe_app/utilities/exports.utilities.dart';

abstract class OverlayWidget {
  static void showSnackBar(
      {required BuildContext context, required String title}) {
    SnackBar snackBar = SnackBar(
      content: CustomText(
        title: title,
      ),
      backgroundColor: AppColors.primaryColor,
      showCloseIcon: true,
      elevation: 2,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
