import 'package:recipe_app/Providers/language.provider.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class RecipeModel {
  String? docId;
  String? mealDesc;
  String? image;
  String? mealType;
  String? mealName;
  int? mealRate;
  int? mealCalories;
  int? mealTime;
  int? serving;
  List<String>? mealIngredients;
  bool? isFresh;
  List<String>? favoritesUsersIds;
  List<String>? recentlyViewedUsersIds;
  Map<String, String>? mealDirections;

  RecipeModel.fromJson(Map<String, dynamic> jsonData, [String? doc]) {
    bool currentLocale = Provider.of<LanguageProvider>(
                navigatorKey.currentContext!,
                listen: false)
            .currentLocale ==
        "en";
    docId = doc;
    image = jsonData["image"];
    mealType =
        currentLocale ? jsonData["mealType_en"] : jsonData["mealType_ar"];
    mealName =
        currentLocale ? jsonData["mealName_en"] : jsonData["mealName_ar"];
    mealDesc =
        currentLocale ? jsonData["mealDesc_en"] : jsonData["mealDesc_ar"];
    mealRate = jsonData["mealRate"];
    mealCalories = jsonData["mealCalories"];

    mealTime = jsonData["mealTime"];
    serving = jsonData["serving"];
    mealIngredients = currentLocale
        ? jsonData["mealIngredients"] != null
            ? List<String>.from(
                jsonData["mealIngredients"].map(
                  (e) => e.toString(),
                ),
              )
            : null
        : jsonData["mealIngredients_ar"] != null
            ? List<String>.from(
                jsonData["mealIngredients_ar"].map(
                  (e) => e.toString(),
                ),
              )
            : null;
    isFresh = jsonData["isFresh"];
    favoritesUsersIds = jsonData["favoritesUsersIds"] != null
        ? List<String>.from(
            jsonData["favoritesUsersIds"].map(
              (e) => e.toString(),
            ),
          )
        : null;
    recentlyViewedUsersIds = jsonData["recentlyViewedUsersIds"] != null
        ? List<String>.from(
            jsonData["recentlyViewedUsersIds"].map(
              (e) => e.toString(),
            ),
          )
        : null;
    mealDirections = currentLocale
        ? jsonData["mealDirections"] != null
            ? Map<String, String>.from(jsonData["mealDirections"])
            : null
        : jsonData["mealDirections_ar"] != null
            ? Map<String, String>.from(jsonData["mealDirections_ar"])
            : null;
  }
  Map<String, dynamic> toJson() {
    return {
      "docId": docId,
      "mealDesc": mealDesc,
      "image": image,
      "mealType": mealType,
      "mealName": mealName,
      "mealRate": mealRate,
      "mealCalories": mealCalories,
      "mealTime": mealTime,
      "serving": serving,
      "mealIngredients": mealIngredients,
      "isFresh": isFresh,
      "recentlyViewedUsersIds": recentlyViewedUsersIds,
      "favoritesUsersIds": favoritesUsersIds,
      "mealDirections": mealDirections
    };
  }
}
