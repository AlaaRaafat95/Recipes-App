import 'package:easy_localization/easy_localization.dart';
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
              ? Center(
                  child: CustomText(
                      title: tr("noRecommendedRecipes"),
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
