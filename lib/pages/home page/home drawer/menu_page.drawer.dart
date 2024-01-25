import 'package:recipe_app/utilities/exports.utilities.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  // backgroundImage: NetworkImage(""),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: FirebaseAuth.instance.currentUser?.displayName ??
                          "No Name",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextButton(
                        onPressed: () {},
                        title: "View Profile",
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400)
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            CustomListTile(
              title: "Ingredients",
              icon: const Icon(
                Icons.menu_book_outlined,
                color: AppColors.primaryColor,
              ),
              onTap: () async {
                Navigation.pushRoute(
                  context: context,
                  route: const IngredientsPage(),
                );
                await ZoomDrawer.of(context)!.close.call();
              },
            ),
            CustomListTile(
              title: "Favorites",
              icon: const Icon(
                Icons.favorite_outline,
                color: AppColors.primaryColor,
              ),
              onTap: () async {
                Navigation.pushRoute(
                  context: context,
                  route: const FavouritesPage(),
                );
                await ZoomDrawer.of(context)!.close.call();
              },
            ),
            CustomListTile(
              title: "Recently Viewed",
              icon: const Icon(
                Icons.play_arrow_outlined,
                color: AppColors.primaryColor,
              ),
              onTap: () {},
            ),
            CustomListTile(
                title: "Settings",
                icon: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.primaryColor,
                ),
                onTap: () {}),
            CustomListTile(
              title: "Sign Out",
              icon: const Icon(
                Icons.logout_outlined,
                color: AppColors.primaryColor,
              ),
              onTap: () async {
                Provider.of<UserRegisterProvider>(context, listen: false)
                    .signOut(context);
                await ZoomDrawer.of(context)!.close.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
