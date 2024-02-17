import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

abstract class MenuItems {
  static DrawerItemModel home =
      DrawerItemModel(icon: Icons.home_outlined, title: tr("home"));
  static DrawerItemModel ingredients =
      DrawerItemModel(icon: Icons.food_bank_outlined, title: tr("ingredients"));
  static DrawerItemModel favorites =
      DrawerItemModel(icon: Icons.favorite_outline, title: tr("favorite"));
  static DrawerItemModel recentlyViewed = DrawerItemModel(
      icon: Icons.play_arrow_outlined, title: tr("recentlyViewed"));
  static DrawerItemModel settings =
      DrawerItemModel(icon: Icons.settings_outlined, title: tr("settings"));
  static DrawerItemModel signOut =
      DrawerItemModel(icon: Icons.logout_outlined, title: tr("signOut"));

  static List<DrawerItemModel> allMenu = [
    home,
    ingredients,
    favorites,
    recentlyViewed,
    settings
  ];
}
