import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  const CustomIconButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
          padding: EdgeInsets.zero, minimumSize: Size.zero),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
