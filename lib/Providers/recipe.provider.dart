import 'package:recipe_app/utilities/exports.utilities.dart';

class RecipeProvider extends ChangeNotifier {
  List<RecipeModel>? _freshRecipesList;
  List<RecipeModel>? _recommendedRecipesList;

  List<RecipeModel>? get freshrecipesList => _freshRecipesList;
  List<RecipeModel>? get recommendedRecipesList => _recommendedRecipesList;

  Future<void> getFreshRecipes({required bool isLimit}) async {
    try {
      var recipes = isLimit
          ? await FirebaseFirestore.instance
              .collection("fresh_recipes")
              .limit(3)
              .get()
          : await FirebaseFirestore.instance.collection("fresh_recipes").get();
      if (recipes.docs.isNotEmpty) {
        _freshRecipesList = List<RecipeModel>.from(
          recipes.docs.map(
            (doc) => RecipeModel.fromJson(
              doc.data(),
            ),
          ),
        );
      } else {
        _freshRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      print(e);

      OverlayToastMessage.show(
        widget: const PopUpMsg(
          title: "There was an error",
          userState: UserState.failed,
        ),
      );
      notifyListeners();
    }
  }

  Future<void> getRecommendedRecipes({required bool isLimit}) async {
    try {
      var recipes = isLimit
          ? await FirebaseFirestore.instance
              .collection("recommended_recipes")
              .limit(3)
              .get()
          : await FirebaseFirestore.instance
              .collection("recommended_recipes")
              .get();
      if (recipes.docs.isNotEmpty) {
        _recommendedRecipesList = List<RecipeModel>.from(
          recipes.docs.map(
            (doc) => RecipeModel.fromJson(
              doc.data(),
            ),
          ),
        );
      } else {
        _recommendedRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      OverlayToastMessage.show(
        widget: const PopUpMsg(
          title: "There was an error",
          userState: UserState.failed,
        ),
      );
      notifyListeners();
    }
  }
}
