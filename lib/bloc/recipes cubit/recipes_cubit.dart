import 'package:recipe_app/utilities/exports.utilities.dart';
part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit() : super(RecipesState());
  List<RecipeModel> recipesList = [];
  Future<void> readRecipes(BuildContext context) async {
    try {
      String response = await rootBundle.loadString("assets/data/data.json");
      List<Map<String, dynamic>> responseDecode =
          List<Map<String, dynamic>>.from(
        jsonDecode(response)["fresh_recipes"],
      );

      recipesList = responseDecode
          .map(
            (e) => RecipeModel.fromJson(e),
          )
          .toList();
      emit(RecipesState());
    } catch (e) {
      OverlayWidget.showSnackBar(
          context: context, title: "Faild Loading Data , Try Again");
    }
  }
}
