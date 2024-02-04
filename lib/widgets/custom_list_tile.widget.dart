import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomListTile extends StatelessWidget {
  final Widget icon;
  final Widget? trailing;
  final String title;
  final bool? selected;
  final VoidCallback? onTap;
  final Color titleColor;
  const CustomListTile(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      required this.titleColor,
      this.trailing,
      this.selected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
      splashColor: AppColors.primaryColor.withOpacity(0.5),
      minVerticalPadding: 0,
      selected: selected ?? false,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: AppColors.transparent,
        ),
      ),
      selectedTileColor: AppColors.primaryColor.withOpacity(0.5),
      titleTextStyle: TextStyle(
          color: titleColor, fontSize: 15, fontWeight: FontWeight.w400),
      onTap: onTap,
      leading: icon,
      title: CustomText(title: title),
      trailing: trailing,
    );
  }
}
