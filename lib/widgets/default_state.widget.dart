import 'package:recipe_app/utilities/exports.utilities.dart';

class DefaultState extends StatelessWidget {
  final String imageUrl;
  final String title;
  const DefaultState({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            imageUrl,
            scale: 1.7,
          ),
          CustomText(
            title: title,
            fontFamily: "Abril Fatface",
            fontSize: 15.0,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
