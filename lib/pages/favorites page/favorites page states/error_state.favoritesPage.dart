import 'package:recipe_app/utilities/exports.utilities.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/error state.png",
            scale: 1.3,
          ),
          const CustomText(
            title: "Ooops , Something Went Wrong !",
            fontFamily: "Abril Fatface",
            fontSize: 15,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
