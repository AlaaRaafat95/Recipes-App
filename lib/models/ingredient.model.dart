class IngredientsModel {
  String? docId;
  String? name;
  List<String>? usersIds;
  IngredientsModel.fromJson(Map<String, dynamic> jsonData, [String? doc]) {
    docId = doc;
    name = jsonData["name"];
    usersIds = jsonData["usersIds"] != null
        ? List<String>.from(
            jsonData["usersIds"].map(
              (e) => e.toString(),
            ),
          )
        : null;
  }
  Map<String, dynamic> toJson() {
    return {"id": docId, "name": name, "usersIds": usersIds};
  }
}
