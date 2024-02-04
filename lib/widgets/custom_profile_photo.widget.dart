import 'package:popover/popover.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserLogInProvider>(
      builder: (context, updatePhoto, _) => InkWell(
        customBorder: const CircleBorder(),
        onTap: () async {
          showPopover(
            context: context,
            bodyBuilder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  CustomListTile(
                      title: "Upload Photo",
                      icon: const Icon(Icons.photo_camera_outlined),
                      titleColor: AppColors.black,
                      onTap: () async {
                        Navigation.popRoute(context);
                        await updatePhoto.updateUerPhotoUrl();
                      }),
                  CustomListTile(
                      title: "remove Photo",
                      icon: const Icon(Icons.no_photography_outlined),
                      titleColor: AppColors.black,
                      onTap: () async {
                        Navigation.popRoute(context);
                        await updatePhoto.removeUerPhotoUrl();
                      }),
                ],
              ),
            ),
            direction: PopoverDirection.bottom,
            height: 100,
            width: 150,
            arrowHeight: 15,
            arrowWidth: 30,
          );
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
                backgroundImage:
                    FirebaseAuth.instance.currentUser?.photoURL == null
                        ? null
                        : NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL!),
                backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                radius: 50,
                child: FirebaseAuth.instance.currentUser?.photoURL == null
                    ? CustomText(
                        title: updatePhoto.getUserNameCapitalLetters(
                          username: FirebaseAuth
                              .instance.currentUser?.displayName
                              .toString(),
                        ),
                        fontSize: 20,
                      )
                    : null),
            const Icon(
              Icons.photo_camera_outlined,
              color: AppColors.primaryColor,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
