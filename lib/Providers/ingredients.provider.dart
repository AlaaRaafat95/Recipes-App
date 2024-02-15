import 'package:recipe_app/utilities/exports.utilities.dart';

class IngredientsProvider extends ChangeNotifier {
  List<IngredientsModel>? _ingredientsList;
  List<IngredientsModel>? get ingredientsList => _ingredientsList;

  Future<void> getIngredients() async {
    try {
      var ingredients =
          await FirebaseFirestore.instance.collection("ingredients").get();
      if (ingredients.docs.isNotEmpty) {
        _ingredientsList = List<IngredientsModel>.from(
          ingredients.docs.map(
            (doc) => IngredientsModel.fromJson(doc.data(), doc.id),
          ),
        );
      } else {
        _ingredientsList = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Loading Ingredients Faild", userState: UserState.failed),
      );
    }
  }

  Future<void> addIngredientsToUser(
      {required String ingredientId, required bool isAdd}) async {
    try {
      OverlayWidget.showAnimateLoading();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection("ingredients")
            .doc(ingredientId)
            .update({
          "usersIds":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection("ingredients")
            .doc(ingredientId)
            .update({
          "usersIds":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      OverlayLoadingProgress.stop();
      getIngredients();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Something Wrong ", userState: UserState.failed),
      );
    }
  }

  Widget chaeckIngredientsFoundToUser({required RecipeModel recipeModel}) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("ingredients")
          .where("usersIds",
              arrayContains: FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          var userIngredientsList = List<IngredientsModel>.from(
            snapshot.data!.docs
                .map(
                  (doc) => IngredientsModel.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );

          var userIngredientsTitles =
              userIngredientsList.map((e) => e.name?.toLowerCase()).toList();
          Widget checkIngredients({required String recipeIngredient}) {
            bool isExsist = false;
            for (var userIngredientsTitle in userIngredientsTitles) {
              if (recipeIngredient.contains(userIngredientsTitle!)) {
                isExsist = true;
                break;
              } else {
                isExsist = false;
              }
            }
            if (isExsist) {
              return const Icon(
                Icons.check,
                color: AppColors.primaryColor,
              );
            } else {
              return const Icon(
                Icons.close,
              );
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: recipeModel.mealIngredients!
                .map(
                  (ingredient) => Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: ingredient,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      checkIngredients(recipeIngredient: ingredient)
                    ],
                  ),
                )
                .toList(),
          );
        }
        return Container();
      },
    );
  }
}
