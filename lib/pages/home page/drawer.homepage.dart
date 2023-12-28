import 'package:recipe_app/utilities/exports.utilities.dart';

class DrawerEX extends StatelessWidget {
  const DrawerEX({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: CustomText(
              title: SharedPreferencesServices.getName(),
            ),
            accountEmail: CustomText(
              title: SharedPreferencesServices.getEmail(),
            ),
            currentAccountPicture: const CircleAvatar(
              radius: 10.0,
            ),
          ),
          CustomButton(
            minimumSize: const Size.fromHeight(50.0),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const CustomText(
              title: AppStrings.logOut,
              fontSize: 16.0,
              color: AppColors.white,
            ),
            onPressed: () {
              pushReplaceRoute(
                context: context,
                route: const LogInPage(),
              );
            },
          ),
        ],
      ),
    );
  }
}
