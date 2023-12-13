import 'package:recipe_app/Constants/exports.dart';

class CustomTextButton extends StatelessWidget {
  final Widget route;
  final String title;

  const CustomTextButton({super.key, required this.route, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        pushRoute(context: context, route: route);
      },
      child: CustomText(title: title),
    );
  }
}
