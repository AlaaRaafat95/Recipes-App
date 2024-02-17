import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class TodayRecipesBar extends StatelessWidget {
  const TodayRecipesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Consumer<RecipeProvider>(
        builder: (context, recipes, _) => recipes.freshRecipesList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : recipes.freshRecipesList?.isEmpty ?? false
                ? Center(
                    child: CustomText(
                        title: tr("noTodayRecipesFound"),
                        color: AppColors.primaryColor,
                        fontSize: 15,
                        fontStyle: FontStyle.italic),
                  )
                : Row(
                    children: recipes.freshRecipesList!
                        .map(
                          (e) => FreshRecipesCard(
                            recipeModel: e,
                          ),
                        )
                        .toList(),
                  ),
      ),
    );
  }
}
