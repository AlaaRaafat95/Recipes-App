import 'package:recipe_app/utilities/exports.utilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferencesServices.prefs = await SharedPreferences.getInstance();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes App',
      theme: ThemeData(
        fontFamily: "Hellix",
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryColor, primary: AppColors.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
