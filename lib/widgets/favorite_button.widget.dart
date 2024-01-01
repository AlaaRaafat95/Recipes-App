import 'package:recipe_app/utilities/exports.utilities.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isPressed
          ? const Icon(
              Icons.favorite,
              color: AppColors.red,
            )
          : const Icon(Icons.favorite_outline),
      onPressed: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
    );
  }
}
