import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class HeadLineTitle extends StatelessWidget {
  final String title;
  const HeadLineTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title: title,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
        CustomTextButton(
          onPressed: () async {
            await Provider.of<RecipeProvider>(context, listen: false)
                .getAllRecipes();
            if (context.mounted) {
              Navigation.pushRoute(
                context: context,
                route: AllRecipesPage(
                  recipeModel:
                      Provider.of<RecipeProvider>(context, listen: false)
                              .allRecipesList ??
                          [],
                ),
              );
            }
          },
          title: tr("seeAll"),
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
          fontSize: 14.0,
        ),
      ],
    );
  }
}
