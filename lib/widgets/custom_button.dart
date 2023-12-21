import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? fontSize;
  final VoidCallback onPressed;
  const CustomButton(
      {super.key, required this.title, required this.onPressed, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.primaryColor,
          elevation: 9,
          shadowColor: AppColors.darkGrey),
      onPressed: onPressed,
      child: CustomText(
        title: title,
        color: AppColors.white,
        fontSize: fontSize,
      ),
    );
  }
}
