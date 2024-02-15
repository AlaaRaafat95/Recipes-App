import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class SuccessState extends StatelessWidget {
  final String mealNameFilter;
  final List<RecipeModel> filteredRecipesList;
  final List<RecipeModel> recipesList;
  const SuccessState(
      {super.key,
      required this.mealNameFilter,
      required this.filteredRecipesList,
      required this.recipesList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (mealNameFilter.isEmpty && recipesList.isNotEmpty)
              const Column(
                children: [
                  CustomText(
                    title: AppStrings.recentlyViewed,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              )
            else if (mealNameFilter.isNotEmpty && filteredRecipesList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomText(
                  title: "${AppStrings.noRecipesFound} : $mealNameFilter .",
                  color: Colors.red,
                ),
              )
            else if (mealNameFilter.isNotEmpty &&
                filteredRecipesList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomText(
                  title: "${AppStrings.filteredByMealName} : $mealNameFilter .",
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Container(),
            ...List.generate(
              mealNameFilter.isNotEmpty
                  ? filteredRecipesList.length
                  : recipesList.length,
              (index) => Slidable(
                key: ValueKey<RecipeModel>(
                  mealNameFilter.isNotEmpty
                      ? filteredRecipesList[index]
                      : recipesList[index],
                ),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        return await showDialog(
                          context: context,
                          builder: (context) {
                            return OverlayWidget.alertDialog(
                              context: context,
                              content: AppStrings.doYouWantToDelete,
                              onPressed: () {
                                Provider.of<RecipeProvider>(context,
                                        listen: false)
                                    .removeRecentlyViewedRecipeToUser(
                                        recipeId: recipesList[index].docId!);
                                Navigation.popRoute(context);
                              },
                            );
                          },
                        );
                      },
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      icon: Icons.delete,
                      label: AppStrings.delete,
                    ),
                  ],
                ),
                child: RecommendedRecipeCard(
                  recipeModel: mealNameFilter.isNotEmpty
                      ? filteredRecipesList[index]
                      : recipesList[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
