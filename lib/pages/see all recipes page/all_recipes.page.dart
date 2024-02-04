import 'package:recipe_app/utilities/exports.utilities.dart';

class AllRecipesPage extends StatelessWidget {
  const AllRecipesPage({super.key, required this.recipeModel});
  final List<RecipeModel> recipeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(title: "All Recipes"),
        forceMaterialTransparency: true,
        // leading:
        // IconButton(
        //   onPressed: () {
        //     Provider.of<RecipeProvider>(context, listen: false)
        //         .getFreshRecipes();
        //     Provider.of<RecipeProvider>(context, listen: false)
        //         .getRecommendedRecipes();

        //     Navigation.popRoute(
        //       context,
        //     );
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //   ),
        // ),
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
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: GridView.builder(
          itemCount:
              Provider.of<RecipeProvider>(context).allRecipesList!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 7 / 9, mainAxisSpacing: 10),
          itemBuilder: (context, index) => FreshRecipesCard(
            recipeModel: recipeModel[index],
          ),
        ),
      ),
    );
  }
}
