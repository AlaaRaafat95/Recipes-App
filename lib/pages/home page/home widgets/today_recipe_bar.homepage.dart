import 'package:recipe_app/utilities/exports.utilities.dart';

class TodayRecipesBar extends StatelessWidget {
  const TodayRecipesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Consumer<RecipeProvider>(
        builder: (context, recipes, child) => recipes.freshRecipesList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : recipes.freshRecipesList?.isEmpty ?? false
                ? const Center(
                    child: Text("No Data Found"),
                  )
                : const FreshRecipesCard(),
      ),
    );
  }
}
