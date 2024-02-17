import 'package:recipe_app/Providers/language.provider.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class IngredientsModel {
  String? docId;
  String? name;
  List<String>? usersIds;
  IngredientsModel.fromJson(Map<String, dynamic> jsonData, [String? doc]) {
    docId = doc;
    name = Provider.of<LanguageProvider>(navigatorKey.currentContext!,
                    listen: false)
                .currentLocale ==
            "en"
        ? jsonData["name_en"]
        : jsonData["name_ar"];
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
