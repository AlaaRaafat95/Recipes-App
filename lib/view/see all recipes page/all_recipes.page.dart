import 'package:recipe_app/utilities/exports.utilities.dart';

class AllRecipesPage extends StatelessWidget {
  const AllRecipesPage({super.key, required this.recipeModel});
  final List<RecipeModel> recipeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          title: AppStrings.allRecipes,
        ),
        forceMaterialTransparency: true,
      ),
      body: GridView.builder(
        itemCount: Provider.of<RecipeProvider>(context).allRecipesList!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 7 / 9),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 10.0, top: 10.0),
          child: FreshRecipesCard(
            recipeModel: recipeModel[index],
          ),
        ),
      ),
    );
  }
}
