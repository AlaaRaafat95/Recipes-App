import 'package:recipe_app/utilities/exports.utilities.dart';

class HeadLineTitle extends StatelessWidget {
  final String title;
  const HeadLineTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title: title,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        const CustomTextButton(
          route: Text(""),
          title: AppStrings.seeAll,
          color: AppColors.primaryColor,
          fontSize: 14.0,
        ),
      ],
    );
  }
}
