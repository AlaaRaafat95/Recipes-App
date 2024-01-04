import 'package:recipe_app/utilities/exports.utilities.dart';

class TodayRecipesBar extends StatelessWidget {
  final List<RecipeModel> recipesList;
  const TodayRecipesBar({super.key, required this.recipesList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: recipesList
            .map(
              (e) => e.id! >= 1 && e.id! <= 4
                  ? Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        CustomContainer(
                          width: 150.0,
                          height: 220.0,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(right: 40.0),
                          decoration: BoxDecoration(
                            color: AppColors.greyAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.translate(
                                offset: const Offset(30.0, 5.0),
                                child: Image.asset(
                                  e.image.toString(),
                                  height: 80.0,
                                  width: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              CustomText(
                                title: e.mealType.toString(),
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blue,
                              ),
                              CustomText(
                                title: e.mealName.toString(),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                              StarDisplay(
                                value: e.mealRate!,
                              ),
                              CustomText(
                                title: "${e.mealCalories.toString()} Calories",
                                fontSize: 10.0,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/time.png"),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      CustomText(
                                        title: " ${e.mealTime} mins",
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.lightGrey,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset("assets/images/serving.png"),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      CustomText(
                                          title: "${e.serving} Serving",
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
                        const FavoriteButton(),
                      ],
                    )
                  : Container(),
            )
            .toList(),
      ),
    );
  }
}
