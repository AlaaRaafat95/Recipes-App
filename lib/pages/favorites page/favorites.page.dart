import 'package:recipe_app/pages/favorites%20page/favorites%20page%20states/success_state.favoritesPage.dart';
import 'package:recipe_app/pages/filter%20page/filter.page.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

import 'favorites page states/default_state.favoritesPage.dart';
import 'favorites page states/error_state.favoritesPage.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    super.key,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<RecipeModel>? recipesList = [];
  List<RecipeModel>? filteredRecipesList = [];
  String mealNameFilter = '';

  void onMealNameChanged(String value) {
    setState(() {
      mealNameFilter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: FloatingActionButton(
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
                          []),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(AppStrings.menuIcon),
            ),
            onPressed: () {
              ZoomDrawer.of(context)?.toggle();
            }),
        title: TextField(
          decoration: const InputDecoration(
            labelText: 'Search by Meal Name',
          ),
          onChanged: (value) {
            onMealNameChanged(value);
          },
        ),
        forceMaterialTransparency: true,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigation.pushRoute(
                  context: context,
                  route: const FilterPage(),
                );
              },
              child: Image.asset(
                AppStrings.filterIcon,
                scale: 1.5,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('fresh_recipes')
            .where("favoritesUsersIds",
                arrayContains: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshots) {
          recipesList = snapshots.data?.docs
              .map(
                (e) => RecipeModel.fromJson(e.data(), e.id),
              )
              .toList();
          filteredRecipesList = recipesList
              ?.where(
                (recipe) => recipe.mealName!
                    .toLowerCase()
                    .contains(mealNameFilter.toLowerCase()),
              )
              .toList();
          if (snapshots.hasError) {
            return const ErrorState();
          } else if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (recipesList?.isNotEmpty ?? false) {
              return SuccessState(
                  mealNameFilter: mealNameFilter,
                  filteredRecipesList: filteredRecipesList!,
                  recipesList: recipesList!);
            } else {
              return const DefaultState();
            }
          }
        },
      ),
    );
  }
}
