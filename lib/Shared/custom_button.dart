import 'package:recipe_app/Constants/exports.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 9,
          shadowColor: AppColors.darkGrey),
      onPressed: onPressed,
      child: CustomText(title: title, color: AppColors.white),
    );
  }
}
