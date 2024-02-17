import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class MenuPage extends StatelessWidget {
  final ValueChanged<DrawerItemModel> onSelectedItem;

  final DrawerItemModel selectedIndex;
  const MenuPage(
      {super.key, required this.onSelectedItem, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  const ProfilePhoto(),
                  const SizedBox(
                    width: 10.0,
                  ),
                  // the only use of the consumer here to listen about the change in username
                  // when i change the username from profilePage change here with consumer Automatically
                  // without consumer doesn't change till i click on hot reload
                  Consumer<UserRegisterProvider>(
                    builder: (context, value, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title:
                              FirebaseAuth.instance.currentUser?.displayName ??
                                  "No Name",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomTextButton(
                            onPressed: () async {
                              Navigation.pushRoute(
                                context: context,
                                route: const ProfilePage(),
                              );
                              await ZoomDrawer.of(context)?.close.call();
                            },
                            title: tr("viewProfile"),
                            fontSize: 12.0,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400)
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              ...MenuItems.allMenu
                  .map(
                    (item) => CustomListTile(
                      titleColor: selectedIndex == item
                          ? AppColors.primaryColor
                          : AppColors.lightGrey,
                      selected: selectedIndex == item,
                      icon: Icon(
                        item.icon,
                        size: 27,
                        color: selectedIndex == item
                            ? AppColors.primaryColor
                            : AppColors.lightGrey,
                      ),
                      title: item.title,
                      onTap: () => onSelectedItem(item),
                    ),
                  )
                  .toList(),
              CustomListTile(
                titleColor: AppColors.lightGrey,
                title: tr("signOut"),
                icon: const Icon(
                  Icons.logout_outlined,
                  color: AppColors.lightGrey,
                ),
                onTap: () async {
                  await Provider.of<UserRegisterProvider>(context,
                          listen: false)
                      .signOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
