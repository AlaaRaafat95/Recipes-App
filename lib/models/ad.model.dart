class AdModel {
  String? title;
  String? imageUrl;
  AdModel.fromJson(Map<String, dynamic> jsonData) {
    title = jsonData["title"];
    imageUrl = jsonData["imageUrl"];
  }
  Map<String, dynamic> toJson() {
    return {"title": title, "imageUrl": imageUrl};
  }
}
