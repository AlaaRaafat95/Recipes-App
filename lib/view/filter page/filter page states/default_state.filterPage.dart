import 'package:easy_localization/easy_localization.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: tr("meal"),
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
          Center(
            child: Wrap(
              spacing: 20.0,
              children: MealType.values
                  .map(
                    (type) => FilterChip(
                      side: const BorderSide(color: AppColors.lightGrey),
                      backgroundColor: AppColors.greyAccent,
                      selectedColor: AppColors.primaryColor,
                      checkmarkColor: widget.filter
                              .containsValue(tr(type.name.toLowerCase()))
                          ? AppColors.white
                          : AppColors.transparent,
                      label: CustomText(
                        title: tr(type.name.toLowerCase()),
                        color: widget.filter
                                .containsValue(tr(type.name.toLowerCase()))
                            ? AppColors.white
                            : AppColors.primaryColor,
                      ),
                      selected: widget.filter
                          .containsValue(tr(type.name.toLowerCase())),
                      onSelected: (selected) {
                        setState(
                          () {
                            SharedPreferencesServices.getLocale() == "en"
                                ? widget.filter["mealType_en"] =
                                    selected ? tr(type.name.toLowerCase()) : ""
                                : widget.filter["mealType_ar"] =
                                    selected ? tr(type.name.toLowerCase()) : "";
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
                  height: 10.0,
                ),
                CustomText(
                  title: tr(details.name.toLowerCase()),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Slider(
                  value: tr(details.name.toLowerCase()) == tr("serving")
                      ? widget.servingSlider
                      : tr(details.name.toLowerCase()) == tr("calories")
                          ? widget.caloriesSlider
                          : widget.timeSlider,
                  label: tr(details.name.toLowerCase()) == tr("serving")
                      ? widget.servingSlider.round().toString()
                      : tr(details.name.toLowerCase()) == tr("calories")
                          ? widget.caloriesSlider.round().toString()
                          : widget.timeSlider.round().toString(),
                  max: tr(details.name.toLowerCase()) == tr("serving")
                      ? 10.0
                      : tr(details.name.toLowerCase()) == tr("calories")
                          ? 1000.0
                          : 120.0,
                  divisions:
                      tr(details.name.toLowerCase()) == tr("serving") ? 5 : 10,
                  onChanged: (filterName) {
                    tr(details.name.toLowerCase()) == tr("serving")
                        ? widget.servingSlider = filterName
                        : tr(details.name.toLowerCase()) == tr("calories")
                            ? widget.caloriesSlider = filterName
                            : widget.timeSlider = filterName;
                    tr(details.name.toLowerCase()) == tr("serving")
                        ? widget.filter["serving"] = widget.servingSlider
                        : tr(details.name.toLowerCase()) == tr("calories")
                            ? widget.filter["mealCalories"] =
                                widget.caloriesSlider
                            : widget.filter["mealTime"] = widget.timeSlider;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Spacer(),
          CustomButton(
            onPressed: widget.applyButton,
            minimumSize: const Size.fromHeight(50.0),
            backgroundColor: AppColors.primaryColor,
            child: CustomText(
              title: tr("apply"),
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
          Spacer(),
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
