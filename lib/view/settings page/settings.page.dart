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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              title: AppStrings.settings,
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
            CustomContainer(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: AppColors.greyAccent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const CustomListTile(
                titleColor: AppColors.black,
                icon: Icon(
                  Icons.language_outlined,
                  color: AppColors.black,
                ),
                title: AppStrings.language,
                trailing: CustomText(
                  title: AppStrings.english,
                  color: AppColors.primaryColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10.0,
            ),
            const CustomText(
              title: AppStrings.profile,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            CustomContainer(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: AppColors.greyAccent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: CustomListTile(
                titleColor: AppColors.black,
                icon: const Icon(
                  Icons.person_2_outlined,
                  color: AppColors.black,
                ),
                title: AppStrings.account,
                trailing: CustomTextButton(
                  onPressed: () {
                    Navigation.pushRoute(
                      context: context,
                      route: const ProfilePage(),
                    );
                  },
                  title: AppStrings.edit,
                  color: AppColors.primaryColor,
                  fontSize: 14.0,
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
