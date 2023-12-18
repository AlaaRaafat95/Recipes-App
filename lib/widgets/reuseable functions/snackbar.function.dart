import 'package:recipe_app/utilities/exports.utilities.dart';

void showSnackBar(BuildContext context) {
  SnackBar snackBar = SnackBar(
    content: const CustomText(
      title: AppStrings.emailNotFound,
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
