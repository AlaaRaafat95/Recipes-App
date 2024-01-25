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

  List<String>? usersIds;

  RecipeModel.fromJson(Map<String, dynamic> jsonData, [String? doc]) {
    docId = doc;
    image = jsonData["image"];
    mealType = jsonData["mealType"];
    mealName = jsonData["mealName"];
    mealDesc = jsonData["mealDesc"];
    mealRate = jsonData["mealRate"];
    mealCalories = jsonData["mealCalories"];
    mealTime = jsonData["mealTime"];
    serving = jsonData["serving"];
    mealIngredients = jsonData["mealIngredients"] != null
        ? List<String>.from(
            jsonData["mealIngredients"].map(
              (e) => e.toString(),
            ),
          )
        : null;
    isFresh = jsonData["isFresh"];

    usersIds = jsonData["usersIds"] != null
        ? List<String>.from(
            jsonData["usersIds"].map(
              (e) => e.toString(),
            ),
          )
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
      "usersIds": usersIds
    };
  }
}
