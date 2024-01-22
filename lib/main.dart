import 'package:recipe_app/utilities/exports.utilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
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
            ..getFreshRecipes(isLimit: true)
            ..getRecommendedRecipes(isLimit: true),
        ),
        ChangeNotifierProvider(
          create: (context) => UserRegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserLogInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdsProvider()..readAds(),
        ),
      ],
      child: OverlayKit(
        child: MaterialApp(
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
