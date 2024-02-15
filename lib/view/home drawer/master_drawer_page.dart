import 'package:recipe_app/utilities/exports.utilities.dart';

class MasterDrawerPage extends StatefulWidget {
  const MasterDrawerPage({super.key});

  @override
  State<MasterDrawerPage> createState() => _MasterDrawerPageState();
}

class _MasterDrawerPageState extends State<MasterDrawerPage> {
  late ZoomDrawerController zoomDrawerController;
  DrawerItemModel currentIndex = MenuItems.home;
  bool canPop = true;
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
      mainScreen: PopScope(
        canPop: currentIndex == MenuItems.home ? true : false,
        onPopInvoked: (didPop) {
          Navigation.pushReplaceRoute(
            context: context,
            route: const MasterDrawerPage(),
          );
        },
        child: currentScreen(),
      ),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: AppColors.darkGrey,
      slideWidth: MediaQuery.of(context).size.width * .7,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      mainScreenScale: 0.35,
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
