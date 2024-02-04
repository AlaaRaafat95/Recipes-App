import 'package:recipe_app/utilities/exports.utilities.dart';

class DefaultState extends StatelessWidget {
  const DefaultState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/Eating donuts.gif",
            scale: 1.7,
          ),
          const CustomText(
            title: "No Favorites Recipes Yet\n Try To Add",
            fontFamily: "Abril Fatface",
            fontSize: 15,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
