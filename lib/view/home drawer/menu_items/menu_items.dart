import 'package:recipe_app/utilities/exports.utilities.dart';

abstract class MenuItems {
  static const home =
      DrawerItemModel(icon: Icons.home_outlined, title: AppStrings.home);
  static const ingredients = DrawerItemModel(
      icon: Icons.food_bank_outlined, title: AppStrings.ingredients);
  static const favorites =
      DrawerItemModel(icon: Icons.favorite_outline, title: AppStrings.favorite);
  static const recentlyViewed = DrawerItemModel(
      icon: Icons.play_arrow_outlined, title: AppStrings.recentlyViewed);
  static const settings = DrawerItemModel(
      icon: Icons.settings_outlined, title: AppStrings.settings);
  static const signOut =
      DrawerItemModel(icon: Icons.logout_outlined, title: AppStrings.signOut);

  static const allMenu = [
    home,
    ingredients,
    favorites,
    recentlyViewed,
    settings
  ];
}
