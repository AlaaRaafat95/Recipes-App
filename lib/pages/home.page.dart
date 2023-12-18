import 'package:recipe_app/utilities/exports.utilities.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: CustomText(
                title:
                    SharedPreferencesServices.getName(name: "name").toString(),
              ),
              accountEmail: CustomText(
                title: SharedPreferencesServices.getEmail(email: "email")
                    .toString(),
              ),
              currentAccountPicture: const CircleAvatar(
                radius: 10,
              ),
            ),
            CustomButton(
              title: AppStrings.logOut,
              onPressed: () {
                SharedPreferencesServices.removePrefs();
                pushReplaceRoute(
                  context: context,
                  route: const LogInPage(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
