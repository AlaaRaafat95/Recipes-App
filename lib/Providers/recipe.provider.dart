import 'package:recipe_app/utilities/exports.utilities.dart';

class RecipeProvider extends ChangeNotifier {
  List<AdModel> adsList = [];
  List<RecipeModel> recipesList = [];
  int selectedIndex = 0;

  Future<void> readAds() async {
    String response = await rootBundle.loadString("assets/data/data.json");
    List<Map<String, dynamic>> responseDecode = List<Map<String, dynamic>>.from(
      jsonDecode(response)["ads"],
    );

    await Future.delayed(const Duration(seconds: 2), () {
      adsList = responseDecode
          .map(
            (e) => AdModel.fromJson(e),
          )
          .toList();
    });

    notifyListeners();
  }

  Future<void> readRecipes() async {
    String response = await rootBundle.loadString("assets/data/data.json");
    List<Map<String, dynamic>> responseDecode = List<Map<String, dynamic>>.from(
      jsonDecode(response)["fresh_recipes"],
    );

    await Future.delayed(const Duration(seconds: 2), () {
      recipesList = responseDecode
          .map(
            (e) => RecipeModel.fromJson(e),
          )
          .toList();
    });

    notifyListeners();
  }

  void pageChanged(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void position(int position) {
    selectedIndex = position;
    notifyListeners();
  }
}
