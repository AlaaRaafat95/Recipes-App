import 'package:recipe_app/utilities/exports.utilities.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AdModel> adsList = [];
  List<RecipeModel> recipesList = [];
  void readAds() async {
    String response = await rootBundle.loadString("assets/data/data.json");
    List<Map<String, dynamic>> responseDecode = List<Map<String, dynamic>>.from(
      jsonDecode(response)["ads"],
    );

    adsList = responseDecode
        .map(
          (e) => AdModel.fromJson(e),
        )
        .toList();
    setState(() {});
  }

  void readRecipes() async {
    String response = await rootBundle.loadString("assets/data/data.json");
    List<Map<String, dynamic>> responseDecode = List<Map<String, dynamic>>.from(
      jsonDecode(response)["fresh_reipes"],
    );

    recipesList = responseDecode
        .map(
          (e) => RecipeModel.fromJson(e),
        )
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    readAds();
    readRecipes();

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
      body: adsList.isEmpty
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
                        title: "Bonjor, ${SharedPreferencesServices.getName()}",
                        color: AppColors.lightGrey,
                        fontSize: 12.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const CustomText(
                        title: AppStrings.todayCook,
                        fontSize: 20.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const SearchAndFilter(),
                      const SizedBox(
                        height: 5.0,
                      ),
                      AdsBar(
                        adsList: adsList,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const HeadLineTitle(title: AppStrings.todayRecipes),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TodayRecipesBar(
                        recipesList: recipesList,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const HeadLineTitle(title: AppStrings.recommended),
                      Recommended(recipesList: recipesList),
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
