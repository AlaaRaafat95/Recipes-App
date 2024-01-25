import 'package:recipe_app/utilities/exports.utilities.dart';

class FavouritesProvider extends ChangeNotifier {
  List<RecipeModel>? _favouritesList;
  List<RecipeModel>? get favouritesList => _favouritesList;

  Future<void> getFavourites() async {
    try {
      var favourite = await FirebaseFirestore.instance
          .collection("fresh_recipes")
          .where("usersIds",
              arrayContains: FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (favourite.docs.isNotEmpty) {
        _favouritesList = List<RecipeModel>.from(
          favourite.docs.map(
            (doc) => RecipeModel.fromJson(doc.data(), doc.id),
          ),
        );
      } else {
        _favouritesList = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Loading Favorites Faild", userState: UserState.failed),
      );
    }
  }

  Future<void> addFavouritesToUser(
      {required String favouriteId, required bool isFav}) async {
    try {
      OverlayLoadingProgress.start();
      if (isFav) {
        await FirebaseFirestore.instance
            .collection("fresh_recipes")
            .doc(favouriteId)
            .update({
          "usersIds":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection("fresh_recipes")
            .doc(favouriteId)
            .update({
          "usersIds":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      notifyListeners();
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: " Something Wrong", userState: UserState.failed),
      );
    }
  }
}
