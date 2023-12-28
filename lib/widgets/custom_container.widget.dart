import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Decoration decoration;
  final double? height;
  final double? width;

  const CustomContainer({
    super.key,
    required this.child,
    required this.padding,
    required this.decoration,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        padding: padding,
        decoration: decoration,
        child: child);
  }
}
