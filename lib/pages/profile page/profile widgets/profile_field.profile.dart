import 'package:recipe_app/utilities/exports.utilities.dart';

class ProfileField extends StatelessWidget {
  final String? buttontitle;
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  const ProfileField(
      {super.key,
      required this.buttontitle,
      required this.title,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.greyAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomListTile(
        titleColor: AppColors.black,
        icon: Icon(
          icon,
        ),
        title: title,
        trailing: CustomTextButton(
          onPressed: onPressed,
          title: buttontitle ?? "",
          color: AppColors.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
