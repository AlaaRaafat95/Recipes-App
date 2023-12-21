import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomIconButton extends StatelessWidget {
  bool isShow = false;
  final VoidCallback onPressed;
  CustomIconButton({super.key, required this.isShow, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: isShow
          ? const Icon(
              Icons.visibility_outlined,
              size: 20,
            )
          : const Icon(
              Icons.visibility_off_outlined,
              size: 20,
              color: AppColors.lightGrey,
            ),
    );
  }
}
