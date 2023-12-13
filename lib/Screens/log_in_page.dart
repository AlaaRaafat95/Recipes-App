import 'package:recipe_app/Constants/exports.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppStrings.mainPic),
                    fit: BoxFit.fitHeight),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.primaryColor.withOpacity(0.4),
                  AppColors.primaryColor.withOpacity(0.2),
                ], begin: Alignment.topRight, end: Alignment.bottomLeft),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomField(
                    hintText: AppStrings.email,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomField(
                    obscureText: !isShow,
                    hintText: AppStrings.password,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      icon: isShow
                          ? const Icon(
                              Icons.visibility_outlined,
                              size: 20,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              size: 20,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    title: AppStrings.logIn,
                    onPressed: () {
                      pushReplaceRoute(
                        context: context,
                        route: const HomePage(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      CustomText(
                        title: "Haven't an account ?",
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      CustomTextButton(
                          route: SignUpPage(), title: AppStrings.signUp)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
