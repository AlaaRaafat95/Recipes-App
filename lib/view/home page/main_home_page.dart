import 'package:easy_localization/easy_localization.dart';
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
        leading: CustomIconButton(
            icon: Padding(
              padding: SharedPreferencesServices.getLocale() == "en"
                  ? const EdgeInsets.only(left: 20.0)
                  : const EdgeInsets.only(right: 20.0),
              child: Image.asset(AppStrings.menuIcon),
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            }),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // this consumer just to update the display name automatically
                // without this consumer the name doesn't update
                Consumer<UserRegisterProvider>(
                  builder: (context, value, _) => CustomText(
                    title:
                        "${tr("bonjor")}, ${FirebaseAuth.instance.currentUser?.displayName.toString()}",
                    color: AppColors.lightGrey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                CustomText(
                  title: tr("todayCook"),
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                  fontFamily: "Abril Fatface",
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const SearchAndFilter(),
                const SizedBox(
                  height: 5.0,
                ),
                const AdsBar(),
                const SizedBox(
                  height: 5.0,
                ),
                HeadLineTitle(
                  title: tr("todayRecipes"),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const TodayRecipesBar(),
                const SizedBox(
                  height: 5.0,
                ),
                HeadLineTitle(
                  title: tr("recommended"),
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
