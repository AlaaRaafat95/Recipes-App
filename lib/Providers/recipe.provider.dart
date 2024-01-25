import 'package:recipe_app/utilities/exports.utilities.dart';

class RecipeProvider extends ChangeNotifier {
  List<RecipeModel>? _freshRecipesList;
  List<RecipeModel>? _recommendedRecipesList;

  List<RecipeModel>? get freshRecipesList => _freshRecipesList;
  List<RecipeModel>? get recommendedRecipesList => _recommendedRecipesList;

  Future<void> getFreshRecipes({required bool isLimit}) async {
    try {
      var recipes = isLimit
          ? await FirebaseFirestore.instance
              .collection("fresh_recipes")
              .where("isFresh", isEqualTo: true)
              .limit(3)
              .get()
          : await FirebaseFirestore.instance.collection("fresh_recipes").get();
      if (recipes.docs.isNotEmpty) {
        _freshRecipesList = List<RecipeModel>.from(
          recipes.docs.map(
            (doc) => RecipeModel.fromJson(doc.data(), doc.id),
          ),
        );
      } else {
        _freshRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: const PopUpMsg(
          title: "Loading Fresh Recipes Faild",
          userState: UserState.failed,
        ),
      );
      notifyListeners();
    }
  }

  Future<void> getRecommendedRecipes() async {
    try {
      var recipes = await FirebaseFirestore.instance
          .collection("fresh_recipes")
          .where("isFresh", isEqualTo: false)
          .limit(3)
          .get();

      if (recipes.docs.isNotEmpty) {
        _recommendedRecipesList = List<RecipeModel>.from(
          recipes.docs.map(
            (doc) => RecipeModel.fromJson(doc.data(), doc.id),
          ),
        );
      } else {
        _recommendedRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: const PopUpMsg(
          title: "Loading Recommended Recipes Faild",
          userState: UserState.failed,
        ),
      );
      notifyListeners();
    }
  }
}
