import 'package:recipe_app/utilities/exports.utilities.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void checkUserFound() {
    final bool isLogin = SharedPreferencesServices.getEmail().isNotEmpty;

    Future.delayed(
      const Duration(seconds: 5),
      () {
        pushReplaceRoute(
          context: context,
          route: isLogin ? const HomePage() : const SelectUserStatePage(),
        );
      },
    );
  }

  @override
  void initState() {
    checkUserFound();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 20.0, left: 30.0, right: 30.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppStrings.splashPic), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(AppStrings.logoPic),
            const SizedBox(
              height: 10.0,
            ),
            const CustomText(
              title: AppStrings.logoName,
              color: AppColors.white,
              fontSize: 14.0,
            ),
            const Spacer(
              flex: 2,
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
