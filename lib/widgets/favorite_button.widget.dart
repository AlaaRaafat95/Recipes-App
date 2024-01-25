import 'package:recipe_app/utilities/exports.utilities.dart';

class FavoriteButton extends StatelessWidget {
  final String favId;
  const FavoriteButton({super.key, required this.favId});

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
          appValueNotifier.toggleIcon(context: context, favId: favId);
        },
      ),
    );
  }
}
