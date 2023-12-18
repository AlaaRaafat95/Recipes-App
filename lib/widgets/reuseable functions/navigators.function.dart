import 'package:recipe_app/utilities/exports.utilities.dart';

void pushRoute({required BuildContext context, required Widget route}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => route),
  );
}

void pushReplaceRoute({required BuildContext context, required Widget route}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => route),
  );
}

void popRoute(BuildContext context) {
  Navigator.pop(
    context,
  );
}
