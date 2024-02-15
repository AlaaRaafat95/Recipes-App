import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomListTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget? subTitle;
  final Widget? trailing;
  final bool? selected;
  final VoidCallback? onTap;
  final Color titleColor;
  const CustomListTile(
      {super.key,
      required this.title,
      required this.icon,
      this.subTitle,
      this.onTap,
      required this.titleColor,
      this.trailing,
      this.selected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: -1.0),
      splashColor: AppColors.primaryColor.withOpacity(0.5),
      minVerticalPadding: 0,
      selected: selected ?? false,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: AppColors.transparent,
        ),
      ),
      selectedTileColor: AppColors.primaryColor.withOpacity(0.5),
      onTap: onTap,
      leading: icon,
      title: CustomText(
          title: title,
          color: titleColor,
          fontSize: 17.0,
          fontWeight: FontWeight.w400),
      subtitle: subTitle,
      trailing: trailing,
    );
  }
}
