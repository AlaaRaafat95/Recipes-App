import 'package:recipe_app/utilities/exports.utilities.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void checkUserFound() {
    final bool isLogin = SharedPreferencesServices.getEmail().isNotEmpty;
    isLogin
        ? Future.delayed(
            Duration.zero,
            () {
              pushReplaceRoute(
                context: context,
                route: const HomePage(),
              );
            },
          )
        : null;
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
            CustomButton(
              title: AppStrings.register,
              fontSize: 16.0,
              onPressed: () {
                pushReplaceRoute(
                  context: context,
                  route: const SignUpPage(),
                );
              },
            ),
            const SizedBox(height: 20.0),
            const CustomTextButton(
              route: LogInPage(),
              title: "Sign in",
              color: AppColors.white,
              fontSize: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
