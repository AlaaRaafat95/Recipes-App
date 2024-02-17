import 'package:easy_localization/easy_localization.dart';
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
      elevation: 2.0,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
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
      title: CustomText(
        title: tr("deleteRecipe"),
      ),
      content: CustomText(
        title: content,
        fontSize: 15.0,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: CustomText(
            title: tr("cancel"),
            fontSize: 15.0,
          ),
        ),
        CustomButton(
          minimumSize: const Size(50.0, 50.0),
          backgroundColor: AppColors.primaryColor,
          onPressed: onPressed,
          child: CustomText(
            color: AppColors.white,
            fontSize: 15.0,
            title: tr("confirm"),
          ),
        ),
      ],
    );
  }

  static void showAnimateLoading() {
    OverlayLoadingProgress.start(
      widget: Center(
        child: LoadingAnimationWidget.waveDots(
            color: AppColors.primaryColor, size: 80.0),
      ),
    );
  }
}
