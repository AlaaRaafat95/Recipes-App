import 'package:recipe_app/utilities/exports.utilities.dart';

class SuccessState extends StatelessWidget {
  final String mealNameFilter;
  final List<RecipeModel> recipesList;
  final List<RecipeModel> filteredRecipesList;
  const SuccessState(
      {super.key,
      required this.mealNameFilter,
      required this.recipesList,
      required this.filteredRecipesList});

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
                    title: "Favorites",
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
                  'No recipes found for : $mealNameFilter .',
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
              (index) => RecommendedRecipeCard(
                recipeModel: mealNameFilter.isNotEmpty
                    ? filteredRecipesList[index]
                    : recipesList[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
