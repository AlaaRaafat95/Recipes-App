import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomTextButton extends StatelessWidget {
  final Widget route;
  final String title;
  final double? fontSize;
  final Color color;

  const CustomTextButton(
      {super.key,
      required this.route,
      required this.title,
      required this.color,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        pushReplaceRoute(context: context, route: route);
      },
      child: CustomText(
        title: title,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
