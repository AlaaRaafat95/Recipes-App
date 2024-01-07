import 'package:recipe_app/utilities/exports.utilities.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AdsCubit adsCubit;
  late RecipesCubit recipesCubit;
  @override
  void initState() {
    adsCubit = BlocProvider.of<AdsCubit>(context);
    recipesCubit = BlocProvider.of<RecipesCubit>(context);
    super.initState();
  }

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
      body: BlocBuilder<AdsCubit, AdsState>(
        builder: (context, state) => adsCubit.adsList.isEmpty &&
                recipesCubit.recipesList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title:
                              "Bonjor, ${GetIt.I.get<SharedPreferences>().getString("name")}",
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
                        const HeadLineTitle(title: AppStrings.todayRecipes),
                        const SizedBox(
                          height: 5.0,
                        ),
                        BlocBuilder<RecipesCubit, RecipesState>(
                          builder: (context, state) => const TodayRecipesBar(),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const HeadLineTitle(title: AppStrings.recommended),
                        BlocBuilder<RecipesCubit, RecipesState>(
                          builder: (context, _) => const Recommended(),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
