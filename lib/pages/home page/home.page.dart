import 'package:recipe_app/utilities/exports.utilities.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0.0,
        leading: const LeadingIcon(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CustomIconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                size: 30.0,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: const DrawerEX(),
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
                const SearchAndFilter(),
                const SizedBox(
                  height: 5.0,
                ),
                const AdsBar(),
                const SizedBox(
                  height: 5.0,
                ),
                HeadLineTitle(
                  title: AppStrings.todayRecipes,
                  onPressed: () {
                    Provider.of<RecipeProvider>(context, listen: false)
                        .getFreshRecipes(isLimit: false);
                    Navigation.pushRoute(
                      context: context,
                      route: const AllRecipesPage(
                        isRecommended: false,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const TodayRecipesBar(),
                const SizedBox(
                  height: 5.0,
                ),
                HeadLineTitle(
                  title: AppStrings.recommended,
                  onPressed: () {
                    Provider.of<RecipeProvider>(context, listen: false)
                        .getRecommendedRecipes(isLimit: false);
                    Navigation.pushRoute(
                      context: context,
                      route: const AllRecipesPage(isRecommended: true),
                    );
                  },
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
