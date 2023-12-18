import 'dart:ui';

import 'package:recipe_app/utilities/exports.utilities.dart';

class GlassBlurEffect extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  const GlassBlurEffect(
      {super.key,
      required this.height,
      required this.width,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        color: AppColors.transparent,
        height: height,
        width: width,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
              child: Container(),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.darkGrey.withOpacity(0.3),
                  ),
                  gradient: LinearGradient(colors: [
                    AppColors.primaryColor.withOpacity(0.4),
                    AppColors.primaryColor.withOpacity(0.2),
                  ], begin: Alignment.topLeft, end: Alignment.bottomLeft),
                ),
                child: child),
          ],
        ),
      ),
    );
  }
}
