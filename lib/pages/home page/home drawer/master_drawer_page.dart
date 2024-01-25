import 'package:recipe_app/utilities/exports.utilities.dart';

class MasterDrawerPage extends StatefulWidget {
  const MasterDrawerPage({super.key});

  @override
  State<MasterDrawerPage> createState() => _MasterDrawerPageState();
}

class _MasterDrawerPageState extends State<MasterDrawerPage> {
  late ZoomDrawerController zoomDrawerController;
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
      menuScreen: const MenuPage(),
      mainScreen: const HomePage(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey.shade700,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }
}
