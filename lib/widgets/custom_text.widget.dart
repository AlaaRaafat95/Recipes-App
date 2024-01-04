import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final String? fontFamily;

  const CustomText(
      {super.key,
      required this.title,
      this.color,
      this.fontSize,
      this.fontFamily,
      this.fontStyle,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontStyle: fontStyle,
          fontFamily: fontFamily,
          fontWeight: fontWeight),
    );
  }
}
