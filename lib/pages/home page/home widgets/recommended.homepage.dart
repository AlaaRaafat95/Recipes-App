import 'package:recipe_app/utilities/exports.utilities.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipes, child) =>
          recipes.recommendedRecipesList == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : recipes.recommendedRecipesList?.isEmpty ?? false
                  ? const Center(
                      child: Text("No Data Found"),
                    )
                  : RecommendedRecipeCard(
                      recipeModel: recipes.recommendedRecipesList!),
    );
  }
}
