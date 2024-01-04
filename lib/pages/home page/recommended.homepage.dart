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
                              e.image.toString(),
                              height: 70.0,
                              width: 100.0,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                  Row(
                                    children: [
                                      StarDisplay(
                                        value: e.mealRate!,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      CustomText(
                                        title:
                                            "${e.mealCalories.toString()} Calories",
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColor,
                                      ),
                                    ],
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
                                            title: "${e.mealTime} mins",
                                            fontSize: 8.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.lightGrey,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/images/serving.png"),
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
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10.0),
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
