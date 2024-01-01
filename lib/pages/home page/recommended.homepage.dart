import 'package:recipe_app/utilities/exports.utilities.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key, required this.recipesList});
  final List<RecipeModel> recipesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: recipesList
          .map(
            (e) => e.id! >= 5
                ? Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CustomContainer(
                        height: 115.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.greyAccent,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        margin: const EdgeInsets.only(bottom: 10.0),
                      ),
                      CustomContainer(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              e.image.toString(),
                              scale: 3.5,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      title: e.mealType.toString(),
                                      fontSize: 10.0,
                                      color: AppColors.blue,
                                    ),
                                  ],
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
                                Row(
                                  children: [
                                    StarDisplay(
                                      value: e.mealRate!,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    CustomText(
                                      title:
                                          " ${e.mealCalories.toString()} Calories",
                                      fontSize: 10.0,
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
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
                                      width: 35.0,
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
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: FavoriteButton(),
                      ),
                    ],
                  )
                : Container(),
          )
          .toList(),
    );
  }
}
