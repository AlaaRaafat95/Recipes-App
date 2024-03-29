import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class RecommendedRecipeCard extends StatelessWidget {
  final RecipeModel recipeModel;
  const RecommendedRecipeCard({super.key, required this.recipeModel});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        GestureDetector(
          onTap: () {
            Navigation.pushRoute(
              context: context,
              route: MealDetails(
                recipeModel: recipeModel,
              ),
            );
          },
          child: CustomContainer(
            height: 110.0,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: AppColors.greyAccent,
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Image.asset(
                  recipeModel.image.toString(),
                  height: 110.0,
                  width: 120.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                SizedBox(
                  width: 150.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      ),
                      Row(
                        children: [
                          StarDisplay(
                            value: recipeModel.mealRate!,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          CustomText(
                            title:
                                "${recipeModel.mealCalories.toString()} ${tr("calories")}",
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(AppImageAssets.timeIcon),
                              const SizedBox(
                                width: 5.0,
                              ),
                              CustomText(
                                title: "${recipeModel.mealTime} ${tr("mins")}",
                                fontSize: 8.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightGrey,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(AppImageAssets.servingIcon),
                              const SizedBox(
                                width: 5.0,
                              ),
                              CustomText(
                                  title:
                                      "${recipeModel.serving} ${tr("serving")}",
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
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: FavoriteButton(
            recipeModel: recipeModel,
          ),
        ),
      ],
    );
  }
}
