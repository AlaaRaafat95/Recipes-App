import 'package:recipe_app/utilities/exports.utilities.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key, required this.recipeModel});
  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    title: recipeModel.mealType!,
                    color: AppColors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                  const Spacer(),
                  const FavoriteButton()
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  recipeModel.image!,
                  height: 200,
                ),
              ),
              CustomText(
                title: recipeModel.mealName!,
                fontFamily: "Abril Fatface",
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(title: recipeModel.mealDesc!),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                title: "${recipeModel.mealCalories.toString()} Calories",
                color: AppColors.primaryColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 10.0,
              ),
              StarDisplay(value: recipeModel.mealRate!),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Image.asset("assets/images/time.png"),
                  const SizedBox(
                    width: 5.0,
                  ),
                  CustomText(
                    title: " ${recipeModel.mealTime} mins",
                    fontSize: 8.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightGrey,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Image.asset("assets/images/serving.png"),
                  const SizedBox(
                    width: 5.0,
                  ),
                  CustomText(
                      title: "${recipeModel.serving} Serving",
                      fontSize: 8.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightGrey),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                title: "Ingredients : ",
                fontFamily: "Abril Fatface",
                fontSize: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recipeModel.mealIngredients!.length,
                  itemBuilder: (context, index) => CustomText(
                      title:
                          "${index + 1} - ${recipeModel.mealIngredients![index]}"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
