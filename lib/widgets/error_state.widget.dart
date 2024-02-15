import 'package:recipe_app/utilities/exports.utilities.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            AppStrings.errorStateImage,
            scale: 1.3,
          ),
          const CustomText(
            title: AppStrings.errorStateTitle,
            fontFamily: "Abril Fatface",
            fontSize: 15.0,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
