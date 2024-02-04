import 'package:recipe_app/pages/filter%20page/filter.page.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0.0,
        leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(AppStrings.menuIcon),
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigation.pushRoute(
                  context: context,
                  route: const FilterPage(),
                );
              },
              child: Image.asset(
                AppStrings.filterIcon,
                scale: 1.5,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title:
                      "Bonjor, ${FirebaseAuth.instance.currentUser?.displayName.toString()}",
                  color: AppColors.lightGrey,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const CustomText(
                  title: AppStrings.todayCook,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                  fontFamily: "Abril Fatface",
                ),
                const SizedBox(
                  height: 5.0,
                ),
                // const SearchAndFilter(),
                const SizedBox(
                  height: 5.0,
                ),
                const AdsBar(),
                const SizedBox(
                  height: 5.0,
                ),
                const HeadLineTitle(
                  title: AppStrings.todayRecipes,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const TodayRecipesBar(),
                const SizedBox(
                  height: 5.0,
                ),
                const HeadLineTitle(
                  title: AppStrings.recommended,
                ),
                const Recommended(),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}