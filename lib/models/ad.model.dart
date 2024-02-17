import 'package:recipe_app/Providers/language.provider.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class AdModel {
  String? title;
  String? imageUrl;
  AdModel.fromJson(Map<String, dynamic> jsonData) {
    title = Provider.of<LanguageProvider>(navigatorKey.currentContext!,
                    listen: false)
                .currentLocale ==
            "en"
        ? jsonData["title_en"]
        : jsonData["title_ar"];
    imageUrl = jsonData["imageUrl"];
  }
  Map<String, dynamic> toJson() {
    return {"title": title, "imageUrl": imageUrl};
  }
}
