import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Size minimumSize;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final Color? backgroundColor;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.child,
      required this.minimumSize,
      this.padding,
      this.backgroundColor,
      this.shape});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: minimumSize,
          padding: padding,
          shape: shape,
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: child);
  }
}
