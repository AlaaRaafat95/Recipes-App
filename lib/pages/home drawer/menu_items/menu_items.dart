import 'package:flutter/material.dart';
import 'package:recipe_app/models/drawer.model.dart';

abstract class MenuItems {
  static const home = DrawerItemModel(icon: Icons.home_outlined, title: "Home");
  static const ingredients =
      DrawerItemModel(icon: Icons.food_bank_outlined, title: "Ingredients");
  static const favorites =
      DrawerItemModel(icon: Icons.favorite_outline, title: "Favorites");
  static const recentlyViewed = DrawerItemModel(
      icon: Icons.play_arrow_outlined, title: "Recently Viewed");
  static const settings =
      DrawerItemModel(icon: Icons.settings_outlined, title: "Settings");
  static const signOut =
      DrawerItemModel(icon: Icons.logout_outlined, title: "Sign Out");

  static const allMenu = [
    home,
    ingredients,
    favorites,
    recentlyViewed,
    settings
  ];
}
