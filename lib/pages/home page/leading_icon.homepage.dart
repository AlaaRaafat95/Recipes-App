import 'package:recipe_app/utilities/exports.utilities.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(AppStrings.menuIcon),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
