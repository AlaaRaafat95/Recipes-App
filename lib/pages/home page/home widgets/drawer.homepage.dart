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
              title:
                  FirebaseAuth.instance.currentUser?.displayName.toString() ??
                      "No Name",
            ),
            accountEmail: CustomText(
              title: FirebaseAuth.instance.currentUser?.email.toString() ??
                  "No Email",
            ),
            currentAccountPicture: CircleAvatar(
              radius: 10.0,
              child: CustomText(
                title: Provider.of<UserRegisterProvider>(context)
                    .getUserNameCapitalLetters(
                        username: FirebaseAuth.instance.currentUser?.displayName
                                .toString() ??
                            "",
                        limitTo: 2),
              ),
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
            onPressed: () =>
                Provider.of<UserRegisterProvider>(context, listen: false)
                    .signOut(context),
          ),
        ],
      ),
    );
  }
}
