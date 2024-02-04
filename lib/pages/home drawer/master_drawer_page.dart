import 'package:recipe_app/models/drawer.model.dart';
import 'package:recipe_app/pages/home%20drawer/menu_items/menu_items.dart';
import 'package:recipe_app/pages/recently%20viewed%20page/recently_viewed.page.dart';
import 'package:recipe_app/pages/settings%20page/settings.page.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class MasterDrawerPage extends StatefulWidget {
  const MasterDrawerPage({super.key});

  @override
  State<MasterDrawerPage> createState() => _MasterDrawerPageState();
}

class _MasterDrawerPageState extends State<MasterDrawerPage> {
  late ZoomDrawerController zoomDrawerController;
  DrawerItemModel currentIndex = MenuItems.home;
  @override
  void initState() {
    zoomDrawerController = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreenWidth: double.infinity,
      menuBackgroundColor: AppColors.white,
      disableDragGesture: true,
      mainScreenTapClose: true,
      controller: zoomDrawerController,
      style: DrawerStyle.defaultStyle,
      menuScreen: Builder(builder: (context) {
        return MenuPage(
            selectedIndex: currentIndex,
            onSelectedItem: (item) {
              setState(() {
                currentIndex = item;
              });
              ZoomDrawer.of(context)?.close.call();
            });
      }),
      mainScreen: currentScreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey.shade700,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }

  Widget currentScreen() {
    switch (currentIndex) {
      case MenuItems.home:
        return const HomePage();
      case MenuItems.ingredients:
        return const IngredientsPage();
      case MenuItems.favorites:
        return const FavoritesPage();
      case MenuItems.recentlyViewed:
        return const RecentlyViewedPage();
      case MenuItems.settings:
        return const SettingsPage();

      default:
        return const HomePage();
    }
  }
}
