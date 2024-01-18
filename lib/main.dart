import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_app/firebase_options.dart';
import 'package:recipe_app/reuseable%20functions/log_in_auth.function.dart';
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
            ..readAds()
            ..readRecipes(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserRegisterAuth(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserLogInAuth(),
        )
      ],
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
    );
  }
}
