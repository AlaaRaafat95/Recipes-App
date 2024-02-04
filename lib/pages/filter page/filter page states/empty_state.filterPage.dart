import 'package:recipe_app/utilities/exports.utilities.dart';

class EmptyFilterState extends StatelessWidget {
  const EmptyFilterState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/Questions.gif",
            scale: 1.5,
          ),
          const CustomText(
            title: "Ooops, No Result Match Your Filter !",
            fontFamily: "Abril Fatface",
            fontSize: 15,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
