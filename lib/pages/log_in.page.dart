import 'package:recipe_app/utilities/exports.utilities.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isShow = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppStrings.mainPic),
                    fit: BoxFit.fitHeight),
              ),
            ),
            GlassBlurEffect(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomField(
                    controller: emailController,
                    labelText: AppStrings.email,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomField(
                    controller: passwordController,
                    obscureText: !isShow,
                    labelText: AppStrings.password,
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
                      if (SharedPreferencesServices.getEmail(email: "email")
                              .isNotEmpty &&
                          SharedPreferencesServices.getName(name: "name")
                              .isNotEmpty) {
                        clearData();
                        pushReplaceRoute(
                          context: context,
                          route: const HomePage(),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      CustomText(
                        title: AppStrings.haveNotAccount,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      CustomTextButton(
                        route: SignUpPage(),
                        title: AppStrings.signUp,
                        color: AppColors.primaryColor,
                        fontSize: 15,
                      )
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

  void clearData() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
