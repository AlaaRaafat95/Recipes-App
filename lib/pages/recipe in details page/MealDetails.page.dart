import 'package:recipe_app/utilities/exports.utilities.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key, required this.recipeModel});
  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CustomIconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                size: 30.0,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      title: recipeModel.mealType!,
                      color: AppColors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                    const Spacer(),
                    FavoriteButton(
                      favId: recipeModel.docId ?? "",
                    )
                  ],
                ),
                CustomText(
                  title: recipeModel.mealName!,
                  fontFamily: "Abril Fatface",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(title: recipeModel.mealDesc!),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  title: "${recipeModel.mealCalories.toString()} Calories",
                  color: AppColors.primaryColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                StarDisplay(value: recipeModel.mealRate!),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/images/time.png"),
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
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Image.asset("assets/images/serving.png"),
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
                    const Spacer(),
                    Image.asset(
                      recipeModel.image!,
                      width: 170,
                    ),
                  ],
                ),
                const CustomText(
                  title: "Ingredients : ",
                  fontFamily: "Abril Fatface",
                  fontSize: 15,
                ),
                const SizedBox(
                  height: 10,
                ),
                ...recipeModel.mealIngredients!.map(
                  (ingredient) => CustomText(title: ingredient),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
