import 'package:recipe_app/utilities/exports.utilities.dart';

class AllRecipesPage extends StatelessWidget {
  const AllRecipesPage({super.key, required this.isRecommended});
  final bool isRecommended;

  @override
  Widget build(BuildContext context) {
    var recipesListType = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          title: isRecommended ? "Recommended" : "Fresh Recipes",
          color: AppColors.primaryColor,
        ),
        leading: IconButton(
          onPressed: () {
            Provider.of<RecipeProvider>(context, listen: false)
                .getFreshRecipes(isLimit: true);
            Provider.of<RecipeProvider>(context, listen: false)
                .getRecommendedRecipes(isLimit: true);

            Navigation.popRoute(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: isRecommended
            ? RecipeCard(recipesList: recipesListType.recommendedRecipesList!)
            : RecipeCard(recipesList: recipesListType.freshrecipesList!),
      ),
    );
  }
}
