import 'package:recipe_app/utilities/exports.utilities.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    Provider.of<FavouritesProvider>(context, listen: false).getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
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
      body: Consumer<FavouritesProvider>(
        builder: (context, favourites, child) =>
            favourites.favouritesList == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (favourites.favouritesList?.isEmpty ?? false)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/images/davecomiskey.png"),
                            const CustomText(
                              title: "No Favorites Recipes Yet",
                              fontFamily: " Abril Fatface",
                              fontSize: 15,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                title: "Favorites",
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SearchAndFilter(),
                              const SizedBox(
                                height: 10,
                              ),
                              RecommendedRecipeCard(
                                  recipeModel: favourites.favouritesList ?? []),
                            ],
                          ),
                        ),
                      ),
      ),
    );
  }
}
