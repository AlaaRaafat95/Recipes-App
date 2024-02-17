import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';
import 'package:recipe_app/view/favorites%20page/favorites%20page%20states/success_state.favoritesPage.dart';

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
              padding: SharedPreferencesServices.getLocale() == "en"
                  ? const EdgeInsets.only(left: 20.0)
                  : const EdgeInsets.only(right: 20.0),
              child: Image.asset(AppStrings.menuIcon),
            ),
            onPressed: () {
              ZoomDrawer.of(context)?.toggle();
            }),
        title: TextField(
          decoration: InputDecoration(
            labelText: tr("searchByMealName"),
          ),
          onChanged: (value) {
            onMealNameChanged(value);
          },
        ),
        forceMaterialTransparency: true,
        elevation: 0.0,
        actions: [
          Padding(
            padding: SharedPreferencesServices.getLocale() == "en"
                ? const EdgeInsets.only(right: 20.0)
                : const EdgeInsets.only(left: 20.0),
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
                (recipe) => recipe.mealName!.toLowerCase().contains(
                      mealNameFilter.toLowerCase(),
                    ),
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
              return DefaultState(
                imageUrl: AppStrings.favoriteDefaultStateImage,
                title: tr("favoriteDefaultStateTitle"),
              );
            }
          }
        },
      ),
    );
  }
}
