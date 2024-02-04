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
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Loading Ingredients Faild", userState: UserState.failed),
      );
    }
  }

  Future<void> addIngredientsToUser(
      {required String ingredientId, required bool isAdd}) async {
    try {
      OverlayLoadingProgress.start(
        widget: Center(
          child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor, size: 80),
        ),
      );
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
}
