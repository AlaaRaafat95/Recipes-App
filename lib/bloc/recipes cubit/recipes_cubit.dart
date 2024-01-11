import 'package:recipe_app/utilities/exports.utilities.dart';
part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit() : super(RecipesInitial());
  List<RecipeModel> recipesList = [];
  Future<void> readRecipes() async {
    emit(RecipesLodaing());
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
      emit(RecipesSuccess(recipesList: recipesList));
    } catch (e) {
      emit(RecipesFailure(error: e.toString()));
    }
  }
}
