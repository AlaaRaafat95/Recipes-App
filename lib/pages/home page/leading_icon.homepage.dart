import 'package:recipe_app/utilities/exports.utilities.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Image.asset(AppStrings.menuIcon),
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
