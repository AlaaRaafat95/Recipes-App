import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLocale = 'en';

  String dropdownValue = tr("english");

  Future<void> changeLanguage(
      {required BuildContext context, required String language}) async {
    OverlayWidget.showAnimateLoading();
    currentLocale = language;
    SharedPreferencesServices.setLocale(locale: currentLocale);
    await context.setLocale(Locale(language));
    if (context.mounted) {
      await reloadOnlineData(context);
    }

    notifyListeners();

    OverlayLoadingProgress.stop();
    // i forced to restart the app due to the language doesn't changed automatically till i hot restart
    await Restart.restartApp();
  }

  Future<void> reloadOnlineData(BuildContext context) async {
    await Provider.of<AdsProvider>(context, listen: false).readAds();

    await Provider.of<IngredientsProvider>(context, listen: false)
        .getIngredients();
    await Provider.of<RecipeProvider>(context, listen: false).getAllRecipes();
    await Provider.of<RecipeProvider>(context, listen: false).getFreshRecipes();
    await Provider.of<RecipeProvider>(context, listen: false)
        .getRecommendedRecipes();
  }

  void changeValue(newValue) {
    dropdownValue = newValue;
    notifyListeners();
  }
}
