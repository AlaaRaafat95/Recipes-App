import 'package:recipe_app/pages/profile%20page/profile.page.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(AppStrings.menuIcon),
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              title: "Settings",
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            CustomContainer(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.greyAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const CustomListTile(
                titleColor: AppColors.black,
                icon: Icon(
                  Icons.language_outlined,
                  color: AppColors.black,
                ),
                title: "Language",
                trailing: CustomText(
                  title: "English",
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              title: "Profile",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            CustomContainer(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.greyAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomListTile(
                titleColor: AppColors.black,
                icon: const Icon(
                  Icons.person_2_outlined,
                  color: AppColors.black,
                ),
                title: "Account",
                trailing: CustomTextButton(
                  onPressed: () {
                    Navigation.pushRoute(
                      context: context,
                      route: const ProfilePage(),
                    );
                  },
                  title: "Edit",
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
