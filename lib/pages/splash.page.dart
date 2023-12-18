import 'package:recipe_app/utilities/exports.utilities.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool? isLogin =
      SharedPreferencesServices.getEmail(email: "email").toString().isNotEmpty;
  void handelSplashScreenTimer() {
    Future.delayed(const Duration(seconds: 10), () {
      pushReplaceRoute(
        context: context,
        route: isLogin! ? const HomePage() : const LogInPage(),
      );
    });
  }

  @override
  void initState() {
    handelSplashScreenTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.splash,
        body: Center(
          child: Image.asset(
            AppStrings.splashScreen,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
