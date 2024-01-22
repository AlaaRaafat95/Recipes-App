class RecipeModel {
  String? mealDesc;
  String? image;
  String? mealType;
  String? mealName;
  int? mealRate;
  int? mealCalories;
  int? mealTime;
  int? serving;
  List<dynamic>? mealIngredients;

  RecipeModel.fromJson(Map<String, dynamic> jsonData) {
    image = jsonData["image"];
    mealType = jsonData["mealType"];
    mealName = jsonData["mealName"];
    mealDesc = jsonData["mealDesc"];
    mealRate = jsonData["mealRate"];
    mealCalories = jsonData["mealCalories"];
    mealTime = jsonData["mealTime"];
    serving = jsonData["serving"];
    mealIngredients = jsonData["mealIngredients"];
  }
  Map<String, dynamic> toJson() {
    return {
      "mealDesc": mealDesc,
      "image": image,
      "mealType": mealType,
      "mealName": mealName,
      "mealRate": mealRate,
      "mealCalories": mealCalories,
      "mealTime": mealTime,
      "serving": serving,
      "mealIngredients": mealIngredients
    };
  }
}
