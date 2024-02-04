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

  static Future showBottomSheet(
      {required BuildContext context, required Widget widget}) {
    return showModalBottomSheet(context: context, builder: (context) => widget);
  }

  static Widget alertDialog(
      {required BuildContext context,
      required String content,
      required VoidCallback onPressed}) {
    return AlertDialog(
      title: const CustomText(
        title: "Delete Recipe",
      ),
      content: CustomText(
        title: content,
        fontSize: 15,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const CustomText(
            title: "Cancel",
            fontSize: 15,
          ),
        ),
        CustomButton(
          minimumSize: const Size(50, 50),
          backgroundColor: AppColors.primaryColor,
          onPressed: onPressed,
          child: const CustomText(
            color: AppColors.white,
            fontSize: 15,
            title: "Confirm",
          ),
        ),
      ],
    );
  }
}
