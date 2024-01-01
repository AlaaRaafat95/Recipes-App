import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final double? height;
  final double? width;

  const CustomContainer(
      {super.key,
      this.child,
      this.padding,
      this.decoration,
      this.height,
      this.width,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        height: height,
        width: width,
        padding: padding,
        decoration: decoration,
        child: child);
  }
}
