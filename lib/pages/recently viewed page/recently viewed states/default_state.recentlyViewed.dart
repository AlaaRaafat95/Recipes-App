import 'package:recipe_app/utilities/exports.utilities.dart';

class DefaultSatate extends StatelessWidget {
  const DefaultSatate({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/Recipe book.gif",
          ),
          const CustomText(
            title: "No Viewed Recipes Yet",
            fontFamily: "Abril Fatface",
            fontSize: 15,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
