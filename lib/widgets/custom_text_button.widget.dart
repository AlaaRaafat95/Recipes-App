import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? fontSize;
  final Color color;
  final FontWeight fontWeight;

  const CustomTextButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.color,
      required this.fontWeight,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: CustomText(
        title: title,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
