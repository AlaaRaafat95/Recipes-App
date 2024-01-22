import 'package:recipe_app/utilities/exports.utilities.dart';

class HeadLineTitle extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const HeadLineTitle(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title: title,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
        CustomTextButton(
          onPressed: onPressed,
          title: AppStrings.seeAll,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
          fontSize: 14.0,
        ),
      ],
    );
  }
}
