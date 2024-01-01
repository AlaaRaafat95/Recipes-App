class RecipeModel {
  int? id;
  String? image;
  String? mealType;
  String? mealName;
  int? mealRate;
  int? mealCalories;
  int? mealTime;
  int? serving;
  RecipeModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData["id"];
    image = jsonData["image"];
    mealType = jsonData["mealType"];
    mealName = jsonData["mealName"];
    mealRate = jsonData["mealRate"];
    mealCalories = jsonData["mealCalories"];
    mealTime = jsonData["mealTime"];
    serving = jsonData["serving"];
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "mealType": mealType,
      "mealName": mealName,
      "mealRate": mealRate,
      "mealCalories": mealCalories,
      "mealTime": mealTime,
      "serving": serving
    };
  }
}
