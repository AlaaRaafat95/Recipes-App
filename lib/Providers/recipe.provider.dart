import 'package:recipe_app/utilities/exports.utilities.dart';

class RecipeProvider extends ChangeNotifier {
  List<RecipeModel>? _allRecipesList;
  List<RecipeModel>? _freshRecipesList;
  List<RecipeModel>? _recommendedRecipesList;
  List<RecipeModel>? filteredList;
  // List<RecipeModel>? _favoritesList;

  List<RecipeModel>? get allRecipesList => _allRecipesList;
  List<RecipeModel>? get freshRecipesList => _freshRecipesList;
  List<RecipeModel>? get recommendedRecipesList => _recommendedRecipesList;
  // List<RecipeModel>? get favoritesList => _favoritesList;

  Map<String, dynamic> filter = {
    "mealType": "",
    "mealCalories": 0,
    "serving": 0,
    "mealTime": 0,
  };
  Future<void> getFilteredRecipes() async {
    try {
      OverlayLoadingProgress.start(
        widget: Center(
          child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor, size: 80),
        ),
      );
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
        widget: const PopUpMsg(
          title: "Loading Filtered Recipes Faild",
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
        widget: const PopUpMsg(
          title: "Loading All Recipes Faild",
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
          .limit(3)
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
      var recommendedRecipes = await FirebaseFirestore.instance
          .collection("fresh_recipes")
          .where("isFresh", isEqualTo: false)
          .limit(3)
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
        widget: const PopUpMsg(
          title: "Loading Recommended Recipes Faild",
          userState: UserState.failed,
        ),
      );
      notifyListeners();
    }
  }

  // Future<void> getfavoritesRecipes() async {
  //   try {
  //     var favouriteRecipes = await FirebaseFirestore.instance
  //         .collection("fresh_recipes")
  //         .where("favoritesUsersIds",
  //             arrayContains: FirebaseAuth.instance.currentUser?.uid)
  //         .get();
  //     if (favouriteRecipes.docs.isNotEmpty) {
  //       _favoritesList = List<RecipeModel>.from(
  //         favouriteRecipes.docs.map(
  //           (doc) => RecipeModel.fromJson(doc.data(), doc.id),
  //         ),
  //       );
  //     } else {
  //       _favoritesList = [];
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     OverlayToastMessage.show(
  //       widget: const PopUpMsg(
  //           title: "Loading Favorites Faild", userState: UserState.failed),
  //     );
  //   }
  // }

  Future<void> addfavoritesToUser(
      {required String recipeId, required bool isFav}) async {
    try {
      OverlayLoadingProgress.start(
        widget: Center(
          child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor, size: 80),
        ),
      );
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
      // await getfavoritesRecipes();

      await updateRecipe(recipeId: recipeId);
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: " Something Wrong", userState: UserState.failed),
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
        widget: const PopUpMsg(
            title: " Something Wrong", userState: UserState.failed),
      );
    }
  }

  Future<void> removeRecentlyViewedRecipeToUser(
      {required String recipeId}) async {
    try {
      OverlayLoadingProgress.start(
        widget: Center(
          child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor, size: 80),
        ),
      );
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
        widget: const PopUpMsg(
          title: "Updating Recipes Faild",
          userState: UserState.failed,
        ),
      );
    }
  }
}
