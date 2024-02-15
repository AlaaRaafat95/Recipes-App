import 'package:recipe_app/utilities/exports.utilities.dart';

class FreshRecipesCard extends StatelessWidget {
  final RecipeModel recipeModel;
  const FreshRecipesCard({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        GestureDetector(
          onTap: () => Navigation.pushRoute(
            context: context,
            route: MealDetails(
              recipeModel: recipeModel,
            ),
          ),
          child: CustomContainer(
            // width: 150.0,
            height: 250.0,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(right: 20.0),
            decoration: BoxDecoration(
              color: AppColors.greyAccent,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(30.0, 0.0),
                  child: Image.asset(
                    recipeModel.image.toString(),
                    height: 95.0,
                    width: 140.0,
                    fit: BoxFit.cover,
                  ),
                ),
                CustomText(
                  title: recipeModel.mealType.toString(),
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue,
                ),
                CustomText(
                  title: recipeModel.mealName.toString(),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  overFlow: TextOverflow.ellipsis,
                ),
                StarDisplay(
                  value: recipeModel.mealRate!,
                ),
                CustomText(
                  title: "${recipeModel.mealCalories.toString()} Calories",
                  fontSize: 10.0,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppStrings.timeIcon),
                        const SizedBox(
                          width: 5.0,
                        ),
                        CustomText(
                          title: " ${recipeModel.mealTime} mins",
                          fontSize: 8.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightGrey,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(AppStrings.servingIcon),
                        const SizedBox(
                          width: 5.0,
                        ),
                        CustomText(
                            title: "${recipeModel.serving} Serving",
                            fontSize: 8.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightGrey),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        FavoriteButton(
          recipeModel: recipeModel,
        ),
      ],
    );
  }
}
