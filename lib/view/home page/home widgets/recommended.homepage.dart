import 'package:recipe_app/utilities/exports.utilities.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipes, _) => recipes.recommendedRecipesList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : recipes.recommendedRecipesList?.isEmpty ?? false
              ? const Center(
                  child: CustomText(
                      title: "No Recommended Recipes",
                      color: AppColors.primaryColor,
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                )
              : Column(
                  children: recipes.recommendedRecipesList!
                      .map(
                        (e) => RecommendedRecipeCard(recipeModel: e),
                      )
                      .toList(),
                ),
    );
  }
}
