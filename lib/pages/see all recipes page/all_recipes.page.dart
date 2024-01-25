import 'package:recipe_app/utilities/exports.utilities.dart';

class AllRecipesPage extends StatelessWidget {
  const AllRecipesPage({super.key, required this.recipeModel});
  final List<RecipeModel> recipeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Provider.of<RecipeProvider>(context, listen: false).getFreshRecipes(
              isLimit: true,
            );
            Provider.of<RecipeProvider>(context, listen: false)
                .getRecommendedRecipes();

            Navigation.popRoute(
              context,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
        child: GridView.builder(
          itemCount:
              Provider.of<RecipeProvider>(context).freshRecipesList!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 7 / 9, mainAxisSpacing: 10),
          itemBuilder: (context, index) => Stack(
            alignment: Alignment.topLeft,
            children: [
              GestureDetector(
                onTap: () => Navigation.pushRoute(
                  context: context,
                  route: MealDetails(
                    recipeModel: recipeModel[index],
                  ),
                ),
                child: CustomContainer(
                  width: 150.0,
                  height: 220.0,
                  padding: const EdgeInsets.all(10.0),
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
                          recipeModel[index].image.toString(),
                          height: 80.0,
                          width: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      CustomText(
                        title: recipeModel[index].mealType.toString(),
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue,
                      ),
                      CustomText(
                        title: recipeModel[index].mealName.toString(),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        overFlow: TextOverflow.ellipsis,
                      ),
                      StarDisplay(
                        value: recipeModel[index].mealRate!,
                      ),
                      CustomText(
                        title:
                            "${recipeModel[index].mealCalories.toString()} Calories",
                        fontSize: 10.0,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/time.png"),
                              const SizedBox(
                                width: 5.0,
                              ),
                              CustomText(
                                title: " ${recipeModel[index].mealTime} mins",
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
                                  title:
                                      "${recipeModel[index].serving} Serving",
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
                favId: recipeModel[index].docId ?? "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
