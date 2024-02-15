import 'package:recipe_app/utilities/exports.utilities.dart';
import 'package:recipe_app/view/filter%20page/filter%20page%20states/default_state.filterPage.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  Map<String, dynamic> filter = {};
  var servingSlider = 0.0;
  var timeSlider = 0.0;
  var caloriesSlider = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const CustomText(
          title: AppStrings.filter,
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CustomTextButton(
                onPressed: () {
                  setState(
                    () {
                      Provider.of<RecipeProvider>(context, listen: false)
                          .filteredList = null;

                      filter.clear();
                      servingSlider = 0.0;
                      timeSlider = 0.0;
                      caloriesSlider = 0.0;
                    },
                  );
                },
                title: AppStrings.reset,
                fontSize: 17.0,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, filteredRecipes, _) =>
            filteredRecipes.filteredList == null
                ? DefaultFilterState(
                    filter: filter,
                    applyButton: () async {
                      Provider.of<RecipeProvider>(context, listen: false)
                          .filter = Map<String, dynamic>.from(filter);
                      await filteredRecipes.getFilteredRecipes();
                    },
                    servingSlider: servingSlider,
                    caloriesSlider: caloriesSlider,
                    timeSlider: timeSlider)
                : filteredRecipes.filteredList!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: ListView.builder(
                          itemCount: filteredRecipes.filteredList!.length,
                          itemBuilder: (context, index) =>
                              RecommendedRecipeCard(
                            recipeModel: filteredRecipes.filteredList![index],
                          ),
                        ),
                      )
                    : const EmptyFilterState(),
      ),
    );
  }
}
