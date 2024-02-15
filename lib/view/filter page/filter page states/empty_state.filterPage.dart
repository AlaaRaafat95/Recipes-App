import 'package:recipe_app/utilities/exports.utilities.dart';

class EmptyFilterState extends StatelessWidget {
  const EmptyFilterState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            AppStrings.filterEmptyStateImage,
            scale: 1.5,
          ),
          const CustomText(
            title: AppStrings.filterEmptyStateTitle,
            fontFamily: "Abril Fatface",
            fontSize: 15.0,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
