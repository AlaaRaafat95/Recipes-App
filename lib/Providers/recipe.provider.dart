import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class RecipeProvider extends ChangeNotifier {
  List<RecipeModel>? _allRecipesList;
  List<RecipeModel>? _freshRecipesList;
  List<RecipeModel>? _recommendedRecipesList;
  List<RecipeModel>? filteredList;

  List<RecipeModel>? get allRecipesList => _allRecipesList;
  List<RecipeModel>? get freshRecipesList => _freshRecipesList;
  List<RecipeModel>? get recommendedRecipesList => _recommendedRecipesList;

  Map<String, dynamic> filter = {};
  Future<void> getFilteredRecipes() async {
    try {
      OverlayWidget.showAnimateLoading();
      Query<Map<String, dynamic>>? result;
      var ref = FirebaseFirestore.instance.collection("fresh_recipes");
      for (var entry in filter.entries) {
        result = ref.where(entry.key, isEqualTo: entry.value);
      }

      var filterRecipes = await result?.get();
      if (filterRecipes?.docs.isNotEmpty ?? false) {
        filteredList = List<RecipeModel>.from(
          filterRecipes!.docs.map(
            (doc) => RecipeModel.fromJson(doc.data(), doc.id),
          ),
        );
      } else {
        filteredList = [];
      }
      notifyListeners();
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();

      OverlayToastMessage.show(
        widget: PopUpMsg(
          title: tr("loadingFilteredRecipesFaild"),
          userState: UserState.failed,
        ),
      );
    }
  }

  Future<void> getAllRecipes() async {
    try {
      var allRecipes =
          await FirebaseFirestore.instance.collection("fresh_recipes").get();
      if (allRecipes.docs.isNotEmpty) {
        _allRecipesList = List<RecipeModel>.from(
          allRecipes.docs.map(
            (doc) => RecipeModel.fromJson(doc.data(), doc.id),
          ),
        );
      } else {
        _allRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: PopUpMsg(
          title: tr("loadingAllRecipesFaild"),
          userState: UserState.failed,
        ),
      );
      notifyListeners();
    }
  }

  Future<void> getFreshRecipes() async {
    try {
      var freshRecipes = await FirebaseFirestore.instance
          .collection("fresh_recipes")
          .where("isFresh", isEqualTo: true)
          .limit(5)
          .get();

      if (freshRecipes.docs.isNotEmpty) {
        _freshRecipesList = List<RecipeModel>.from(
          freshRecipes.docs.map(
            (doc) => RecipeModel.fromJson(doc.data(), doc.id),
          ),
        );
      } else {
        _freshRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: PopUpMsg(
          title: tr("loadingFreshRecipesFaild"),
          userState: UserState.failed,
        ),
      );
      notifyListeners();
    }
  }

  Future<void> getRecommendedRecipes() async {
    try {
      var recommendedRecipes = await FirebaseFirestore.instance
          .collection("fresh_recipes")
          .where("isFresh", isEqualTo: false)
          .limit(5)
          .get();

      if (recommendedRecipes.docs.isNotEmpty) {
        _recommendedRecipesList = List<RecipeModel>.from(
          recommendedRecipes.docs.map(
            (doc) => RecipeModel.fromJson(doc.data(), doc.id),
          ),
        );
      } else {
        _recommendedRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: PopUpMsg(
          title: tr("loadingRecommendedRecipesFaild"),
          userState: UserState.failed,
        ),
      );
      notifyListeners();
    }
  }

  Future<void> addfavoritesToUser(
      {required String recipeId, required bool isFav}) async {
    try {
      OverlayWidget.showAnimateLoading();

      if (isFav) {
        await FirebaseFirestore.instance
            .collection("fresh_recipes")
            .doc(recipeId)
            .update({
          "favoritesUsersIds":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection("fresh_recipes")
            .doc(recipeId)
            .update({
          "favoritesUsersIds":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }

      await updateRecipe(recipeId: recipeId);
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget:
            PopUpMsg(title: tr("somethingWrong"), userState: UserState.failed),
      );
    }
  }

  Future<void> addRecentlyViewedRecipeToUser({required String recipeId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("fresh_recipes")
          .doc(recipeId)
          .update({
        "recentlyViewedUsersIds":
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
      });
    } catch (e) {
      OverlayToastMessage.show(
        widget:
            PopUpMsg(title: tr("somethingWrong"), userState: UserState.failed),
      );
    }
  }

  Future<void> removeRecentlyViewedRecipeToUser(
      {required String recipeId}) async {
    try {
      OverlayWidget.showAnimateLoading();
      await FirebaseFirestore.instance
          .collection("fresh_recipes")
          .doc(recipeId)
          .update({
        "recentlyViewedUsersIds":
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
      });
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Error Deleting Recipe", userState: UserState.failed),
      );
    }
  }

  Future<void> updateRecipe({required String recipeId}) async {
    // 1- get recipe from firebase
    // 2- update recipe in all lists
    try {
      var allRecipes = await FirebaseFirestore.instance
          .collection("fresh_recipes")
          .doc(recipeId)
          .get();
      RecipeModel updateRecipe;
      if (allRecipes.data() != null) {
        updateRecipe = RecipeModel.fromJson(allRecipes.data()!, allRecipes.id);
      } else {
        return;
      }

      var recipeListIndex =
          allRecipesList?.indexWhere((recipe) => recipe.docId == recipeId);
      if (recipeListIndex != -1) {
        allRecipesList?.removeAt(recipeListIndex!);
        allRecipesList?.insert(recipeListIndex!, updateRecipe);
      }

      var freshRecipeListIndex =
          freshRecipesList?.indexWhere((recipe) => recipe.docId == recipeId);
      if (freshRecipeListIndex != -1) {
        freshRecipesList?.removeAt(freshRecipeListIndex!);
        freshRecipesList?.insert(freshRecipeListIndex!, updateRecipe);
      }
      var recommendedRecipeListIndex = recommendedRecipesList
          ?.indexWhere((recipe) => recipe.docId == recipeId);
      if (recommendedRecipeListIndex != -1) {
        recommendedRecipesList?.removeAt(recommendedRecipeListIndex!);
        recommendedRecipesList?.insert(
            recommendedRecipeListIndex!, updateRecipe);
      }
      // var favoritesRecipeListIndex =
      //     favoritesList?.indexWhere((recipe) => recipe.docId == recipeId);
      // if (favoritesRecipeListIndex != -1) {
      //   favoritesList?.removeAt(favoritesRecipeListIndex!);
      //   favoritesList?.insert(favoritesRecipeListIndex!, updateRecipe);
      // }

      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: PopUpMsg(
          title: tr("updatingRecipesFaild"),
          userState: UserState.failed,
        ),
      );
    }
  }
}
