import 'package:recipe_app/utilities/exports.utilities.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () => Navigation.pushRoute(
            context: context,
            route: const FilterPage(),
          ),
          child: CustomContainer(
            decoration: BoxDecoration(
              color: AppColors.greyAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width * 0.75,
            child: const Row(
              children: [
                Icon(
                  Icons.search_outlined,
                  color: AppColors.lightGrey,
                ),
                SizedBox(
                  width: 5,
                ),
                CustomText(
                  title: AppStrings.search,
                  color: AppColors.lightGrey,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () => Navigation.pushRoute(
            context: context,
            route: const FilterPage(),
          ),
          child: CustomContainer(
            decoration: BoxDecoration(
              color: AppColors.greyAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              AppStrings.filterIcon,
              scale: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
