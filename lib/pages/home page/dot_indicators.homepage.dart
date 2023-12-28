import 'package:recipe_app/utilities/exports.utilities.dart';

class DotIndicators extends StatelessWidget {
  final int dotsCount;
  final int position;
  final void Function(int) onTap;
  const DotIndicators(
      {super.key,
      required this.dotsCount,
      required this.position,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: DotsIndicator(
        dotsCount: dotsCount,
        position: position,
        onTap: onTap,
        decorator: const DotsDecorator(
            activeSize: Size(25.0, 15.0), size: Size(20.0, 11.0)),
      ),
    );
  }
}
