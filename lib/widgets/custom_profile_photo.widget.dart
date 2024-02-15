import 'package:recipe_app/utilities/exports.utilities.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  void initState() {
    // this future.delayed used only to avoid initState() error due to use  notifyListeners();
    Future.delayed(Duration.zero).then((_) {
      Provider.of<UserRegisterProvider>(context, listen: false)
          .getUserNameCapitalLetters(
              userName:
                  FirebaseAuth.instance.currentUser!.displayName.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserLogInProvider>(
      builder: (context, updatePhoto, _) => InkWell(
        customBorder: const CircleBorder(),
        onTap: () async {
          showPopover(
            context: context,
            bodyBuilder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  CustomListTile(
                    title: AppStrings.uploadPhoto,
                    icon: const Icon(
                      Icons.photo_camera_outlined,
                      color: AppColors.primaryColor,
                    ),
                    titleColor: AppColors.black,
                    onTap: () async {
                      Navigation.popRoute(context);
                      await updatePhoto.updateUerPhotoUrl();
                    },
                  ),
                  const Divider(
                    color: AppColors.primaryColor,
                  ),
                  CustomListTile(
                      title: AppStrings.removePhoto,
                      icon: const Icon(
                        Icons.no_photography_outlined,
                        color: AppColors.primaryColor,
                      ),
                      titleColor: AppColors.black,
                      onTap: () async {
                        Navigation.popRoute(context);
                        await updatePhoto.removeUerPhotoUrl();
                      }),
                ],
              ),
            ),
            direction: PopoverDirection.bottom,
            height: 130.0,
            width: 170.0,
            arrowHeight: 15.0,
            arrowWidth: 30.0,
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
                radius: 60.0,
                child: FirebaseAuth.instance.currentUser?.photoURL == null
                    ? CustomText(
                        title: Provider.of<UserRegisterProvider>(context)
                            .userName
                            .toString(),
                        fontSize: 20.0,
                      )
                    : null),
            const Icon(
              Icons.photo_camera_outlined,
              color: AppColors.primaryColor,
              size: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
