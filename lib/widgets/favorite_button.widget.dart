import 'package:recipe_app/utilities/exports.utilities.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppValueNotifier appValueNotifier = AppValueNotifier();
    return ValueListenableBuilder(
      valueListenable: appValueNotifier.iconNotifier,
      builder: (context, value, _) => IconButton(
        icon: value
            ? const Icon(
                Icons.favorite,
                color: AppColors.primaryColor,
              )
            : const Icon(Icons.favorite_outline),
        onPressed: () {
          appValueNotifier.changeIcon();
        },
      ),
    );
  }
}
