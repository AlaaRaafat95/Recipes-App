import 'package:recipe_app/utilities/exports.utilities.dart';

// ignore: must_be_immutable
class DefaultFilterState extends StatefulWidget {
  final Map<String, dynamic> filter;
  final VoidCallback applyButton;
  double servingSlider;
  double caloriesSlider;
  double timeSlider;
  DefaultFilterState(
      {super.key,
      required this.filter,
      required this.applyButton,
      required this.servingSlider,
      required this.caloriesSlider,
      required this.timeSlider});

  @override
  State<DefaultFilterState> createState() => _DefaultFilterState();
}

class _DefaultFilterState extends State<DefaultFilterState> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            title: "Meal",
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          Center(
            child: Wrap(
              spacing: 10.0,
              children: MealType.values
                  .map(
                    (type) => FilterChip(
                      side: const BorderSide(color: AppColors.lightGrey),
                      backgroundColor: AppColors.greyAccent,
                      selectedColor: AppColors.primaryColor,
                      checkmarkColor: widget.filter.containsValue(type.name)
                          ? AppColors.white
                          : AppColors.transparent,
                      label: CustomText(
                        title: type.name,
                        color: widget.filter.containsValue(type.name)
                            ? AppColors.white
                            : AppColors.primaryColor,
                      ),
                      selected: widget.filter.containsValue(type.name),
                      onSelected: (selected) {
                        setState(
                          () {
                            widget.filter["mealType"] =
                                selected ? type.name : "";
                          },
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          ...MealDetails.values.map(
            (details) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  title: details.name,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 10,
                ),
                Slider(
                  value: details.name == "Serving"
                      ? widget.servingSlider
                      : details.name == "Calories"
                          ? widget.caloriesSlider
                          : widget.timeSlider,
                  label: details.name == "Serving"
                      ? widget.servingSlider.round().toString()
                      : details.name == "Calories"
                          ? widget.caloriesSlider.round().toString()
                          : widget.timeSlider.round().toString(),
                  max: details.name == "Serving"
                      ? 10
                      : details.name == "Calories"
                          ? 1000
                          : 120,
                  divisions: details.name == "Serving" ? 5 : 10,
                  onChanged: (serving) {
                    details.name == "Serving"
                        ? widget.servingSlider = serving
                        : details.name == "Calories"
                            ? widget.caloriesSlider = serving
                            : widget.timeSlider = serving;
                    details.name == "Serving"
                        ? widget.filter["serving"] = widget.servingSlider
                        : details.name == "Calories"
                            ? widget.filter["mealCalories"] =
                                widget.caloriesSlider
                            : widget.filter["mealTime"] = widget.timeSlider;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          CustomButton(
            onPressed: widget.applyButton,
            minimumSize: const Size.fromHeight(50.0),
            backgroundColor: AppColors.primaryColor,
            child: const CustomText(
              title: "Apply",
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// in these enums i am sorry for using enum names start with capital letters
// but i store them in firestore with capital letters and these must be the same
// ignore: constant_identifier_names
enum MealType { Breakfast, Dinner, Launch }

// ignore: constant_identifier_names
enum MealDetails { Serving, Calories, Time }
