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
                    title: "Recently Viewed",
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            if (mealNameFilter.isNotEmpty && filteredRecipesList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "No recipes found for $mealNameFilter .",
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else if (mealNameFilter.isNotEmpty &&
                filteredRecipesList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Filtered by Meal Name: $mealNameFilter',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            else
              Container(),
            ...List.generate(
              mealNameFilter.isNotEmpty
                  ? filteredRecipesList.length
                  : recipesList.length,
              (index) => Slidable(
                key: ValueKey<RecipeModel>(recipesList[index]),
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
                              content: "Do You Want To Delete This Recipe ?",
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
                      label: 'Delete',
                    ),
                  ],
                ),
                child: RecommendedRecipeCard(
                  recipeModel: recipesList[index],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
