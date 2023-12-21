import 'package:recipe_app/utilities/exports.utilities.dart';

class BackgroundImageContainer extends StatelessWidget {
  final Widget child;
  const BackgroundImageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppStrings.mainPic), fit: BoxFit.cover),
        ),
        child: child);
  }
}
