import 'dart:async';
import 'package:recipe_app/utilities/exports.utilities.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription<User?>? listner;
  @override
  void initState() {
    initSPlash();
    super.initState();
  }

  void initSPlash() async {
    await Future.delayed(const Duration(seconds: 2));
    listner = FirebaseAuth.instance.authStateChanges().listen((user) {
      Navigation.pushReplaceRoute(
        context: context,
        route: user != null && user.emailVerified
            ? const MasterDrawerPage()
            : const SelectUserStatePage(),
      );
    });
  }

  @override
  void dispose() {
    listner?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 20.0, left: 30.0, right: 30.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppStrings.splashPic,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              AppStrings.logoPic,
              scale: 3,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const CustomText(
              title: AppStrings.logoName,
              color: AppColors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
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
