import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

// sorry for using global variable but solve the problem of passing context along alot of widgets
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesServices.prefs = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: "assets/translation",
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RecipeProvider()
            ..getFreshRecipes()
            ..getRecommendedRecipes(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserRegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserLogInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(create: (context) => AdsProvider()..readAds()),
        ChangeNotifierProvider(
          create: (context) => IngredientsProvider()..getIngredients(),
        ),
      ],
      child: OverlayKit(
        child: MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Recipes App',
          theme: ThemeData(
            fontFamily: "Hellix",
            colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
                primary: AppColors.primaryColor),
            useMaterial3: true,
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
