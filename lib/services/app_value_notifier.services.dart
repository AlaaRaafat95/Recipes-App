import 'package:recipe_app/utilities/exports.utilities.dart';

class AppValueNotifier {
  ValueNotifier iconNotifier = ValueNotifier(false);

  void toggleIcon(
      {required BuildContext context, required String favId}) async {
    iconNotifier.value = !iconNotifier.value;
    Provider.of<FavouritesProvider>(context, listen: false)
        .addFavouritesToUser(favouriteId: favId, isFav: iconNotifier.value);
  }
}
