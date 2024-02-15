import 'package:recipe_app/utilities/exports.utilities.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback onPressed;
  const ProfileField(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      titleColor: AppColors.black,
      subTitle: CustomText(
        title: subTitle,
        color: AppColors.primaryColor,
      ),
      icon: Icon(
        icon,
      ),
      title: title,
      trailing: CustomIconButton(
        onPressed: title == "Email" ? null : onPressed,
        icon: title == "Delete"
            ? const Icon(
                Icons.delete_forever_outlined,
              )
            : title == "Email"
                ? const Text("")
                : const Icon(
                    Icons.edit_outlined,
                  ),
      ),
    );
  }
}
