import 'package:recipe_app/utilities/exports.utilities.dart';
import 'package:recipe_app/view/recently%20viewed%20page/recently%20viewed%20states/success_state.recentlyViewed.dart';

class RecentlyViewedPage extends StatefulWidget {
  const RecentlyViewedPage({super.key});

  @override
  State<RecentlyViewedPage> createState() => _RecentlyViewedPageState();
}

class _RecentlyViewedPageState extends State<RecentlyViewedPage> {
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
      appBar: AppBar(
        leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(AppStrings.menuIcon),
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            }),
        title: TextField(
          decoration: const InputDecoration(
            labelText: AppStrings.searchByMealName,
          ),
          onChanged: (value) {
            onMealNameChanged(value);
          },
        ),
        forceMaterialTransparency: true,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
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
            .where("recentlyViewedUsersIds",
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (recipesList?.isNotEmpty ?? false) {
              return SuccessState(
                  mealNameFilter: mealNameFilter,
                  filteredRecipesList: filteredRecipesList!,
                  recipesList: recipesList!);
            } else {
              return const DefaultState(
                  imageUrl: AppStrings.recentlyViewedDefaultStateImage,
                  title: AppStrings.recentlyViewedDefaultStateTitle);
            }
          }
        },
      ),
    );
  }
}
