import 'package:recipe_app/utilities/exports.utilities.dart';

class FavoriteButton extends StatefulWidget {
  final RecipeModel recipeModel;
  const FavoriteButton({super.key, required this.recipeModel});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool get isUserInList => widget.recipeModel.favoritesUsersIds!
      .contains(FirebaseAuth.instance.currentUser?.uid);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isUserInList
          ? const Icon(
              Icons.favorite,
              color: AppColors.primaryColor,
            )
          : const Icon(Icons.favorite_outline),
      onPressed: () {
        Provider.of<RecipeProvider>(context, listen: false).addfavoritesToUser(
            recipeId: widget.recipeModel.docId!, isFav: !isUserInList);
        if (isUserInList) {
          widget.recipeModel.favoritesUsersIds!
              .remove(FirebaseAuth.instance.currentUser?.uid);
        } else {
          widget.recipeModel.favoritesUsersIds!
              .add(FirebaseAuth.instance.currentUser!.uid);
        }
        setState(() {});
      },
    );
  }
}
