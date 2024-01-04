import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  // final AxisDirection direction;
  CustomPageRoute({required this.child})
      : super(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => child);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      ScaleTransition(
        scale: animation,
        child: child,
      );

  // >>>>>> this is for animation depends on direction <<<<<<

  // SlideTransition(position: Tween<Offset>(begin: getBeginOffset(),end: Offset.zero).animate(animation),child :child);

  // Offset getBeginOffset() {
  //   if (direction == AxisDirection.up) {
  //     return const Offset(0, 1);
  //   }
  //   if (direction == AxisDirection.down) {
  //     return const Offset(0, -1);
  //   }
  //   if (direction == AxisDirection.left) {
  //     return const Offset(-1, 0);
  //   } else {
  //     return const Offset(1, 0);
  //   }
  // }
}

abstract class Nagivation {
  static void pushRoute({
    required BuildContext context,
    required Widget route,
  }) {
    Navigator.push(
      context,
      CustomPageRoute(child: route),
    );
  }

  static void pushReplaceRoute({
    required BuildContext context,
    required Widget route,
  }) {
    Navigator.pushReplacement(
      context,
      CustomPageRoute(child: route),
    );
  }

  static void popRoute(BuildContext context) {
    Navigator.pop(
      context,
    );
  }
}
