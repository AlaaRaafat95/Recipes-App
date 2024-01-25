import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomListTile extends StatelessWidget {
  final Widget icon;
  final String title;

  final VoidCallback? onTap;
  const CustomListTile(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
      splashColor: AppColors.primaryColor.withOpacity(0.5),
      minVerticalPadding: 0,
      titleTextStyle: const TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w400),
      subtitleTextStyle: const TextStyle(color: AppColors.lightGrey),
      onTap: onTap,
      leading: icon,
      title: CustomText(title: title),
    );
  }
}
