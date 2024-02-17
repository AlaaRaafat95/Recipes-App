import 'package:easy_localization/easy_localization.dart';
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
              Column(
                children: [
                  CustomText(
                    title: tr("favorite"),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            if (mealNameFilter.isNotEmpty && filteredRecipesList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomText(
                  title: '${tr("noRecipesFound")} : $mealNameFilter .',
                  color: Colors.red,
                  fontSize: 15.0,
                ),
              )
            else if (mealNameFilter.isNotEmpty &&
                filteredRecipesList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomText(
                    title: '${tr("filteredByMealName")} : $mealNameFilter .',
                    fontWeight: FontWeight.bold),
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
