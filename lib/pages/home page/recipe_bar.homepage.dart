import 'package:recipe_app/utilities/exports.utilities.dart';

class TodayRecipesBar extends StatelessWidget {
  final List<RecipeModel> recipesList;
  const TodayRecipesBar({super.key, required this.recipesList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: recipesList
            .map(
              (e) => e.id! >= 1 && e.id! <= 4
                  ? Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topLeft,
                      children: [
                        CustomContainer(
                          width: 160.0,
                          height: 240.0,
                          decoration: BoxDecoration(
                            color: AppColors.greyAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(right: 30.0),
                        ),
                        Positioned(
                          top: 20.0,
                          left: 40.0,
                          child: Image.asset(
                            e.image.toString(),
                            scale: 4.0,
                          ),
                        ),
                        Positioned(
                          top: 80.0,
                          child: CustomContainer(
                            padding: const EdgeInsets.all(10.0),
                            width: 170.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: e.mealType.toString(),
                                  fontSize: 10.0,
                                  color: AppColors.blue,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                CustomText(
                                  title: e.mealName.toString(),
                                  fontSize: 14.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                StarDisplay(
                                  value: e.mealRate!,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                CustomText(
                                  title:
                                      "${e.mealCalories.toString()} Calories",
                                  fontSize: 10.0,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/images/time.png"),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    CustomText(
                                      title: "${e.mealTime} mins",
                                      fontSize: 8.0,
                                      color: AppColors.lightGrey,
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Image.asset("assets/images/serving.png"),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    CustomText(
                                        title: "${e.serving} Serving",
                                        fontSize: 8.0,
                                        color: AppColors.lightGrey),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const FavoriteButton()
                      ],
                    )
                  : Container(),
            )
            .toList(),
      ),
    );
  }
}
