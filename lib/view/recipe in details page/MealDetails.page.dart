import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({super.key, required this.recipeModel});
  final RecipeModel recipeModel;

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  @override
  void initState() {
    Provider.of<RecipeProvider>(context, listen: false)
        .addRecentlyViewedRecipeToUser(recipeId: widget.recipeModel.docId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      title: widget.recipeModel.mealType!,
                      color: AppColors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                    const Spacer(),
                    FavoriteButton(
                      recipeModel: widget.recipeModel,
                    )
                  ],
                ),
                CustomText(
                  title: widget.recipeModel.mealName!,
                  fontFamily: "Abril Fatface",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomText(title: widget.recipeModel.mealDesc!),
                const SizedBox(
                  height: 10.0,
                ),
                CustomText(
                  title:
                      "${widget.recipeModel.mealCalories.toString()} ${tr("calories")}",
                  color: AppColors.primaryColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                StarDisplay(value: widget.recipeModel.mealRate!),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppImageAssets.timeIcon),
                            const SizedBox(
                              width: 5.0,
                            ),
                            CustomText(
                              title:
                                  " ${widget.recipeModel.mealTime} ${tr("mins")}",
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightGrey,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Image.asset(AppImageAssets.servingIcon),
                            const SizedBox(
                              width: 5.0,
                            ),
                            CustomText(
                                title:
                                    "${widget.recipeModel.serving} ${tr("serving")}",
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightGrey),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      widget.recipeModel.image!,
                      width: 170.0,
                    ),
                  ],
                ),
                CustomText(
                  title: "${tr("ingredients")} : ",
                  fontFamily: "Abril Fatface",
                  fontSize: 15.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Provider.of<IngredientsProvider>(context, listen: false)
                    .chaeckIngredientsFoundToUser(
                        recipeModel: widget.recipeModel),
                const SizedBox(
                  height: 10.0,
                ),
                CustomText(
                  title: "${tr("directions")} : ",
                  fontFamily: "Abril Fatface",
                  fontSize: 15.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ...List.generate(
                  widget.recipeModel.mealDirections!.length,
                  (index) {
                    // the vaules diplay was not sorted although the map on firestore sorted
                    //example : {"1":"data1","2":"data2","3":"data3" , ........} as you said before in your session
                    //so here i sort the keys first then use them
                    List<String> keys =
                        widget.recipeModel.mealDirections!.keys.toList();
                    keys.sort();

                    var key = keys[index];
                    var value = widget.recipeModel.mealDirections?[key];
                    return RichText(
                      text: TextSpan(
                        text: "",
                        children: [
                          TextSpan(
                            text: "${tr("step")} ${index + 1} :\n",
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                          TextSpan(
                            text: "\n$value\n",
                            style: const TextStyle(color: AppColors.black),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
