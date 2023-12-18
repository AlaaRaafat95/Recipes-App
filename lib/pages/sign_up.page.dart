import 'package:recipe_app/utilities/exports.utilities.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
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
                    image: AssetImage(
                      AppStrings.mainPic,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            GlassBlurEffect(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomField(
                    controller: nameController,
                    labelText: AppStrings.name,
                  ),
                  const CustomField(
                    labelText: AppStrings.country,
                  ),
                  CustomField(
                    controller: emailController,
                    labelText: AppStrings.email,
                  ),
                  CustomField(
                    controller: passwordController,
                    labelText: AppStrings.password,
                  ),
                  CustomButton(
                    title: AppStrings.signUp,
                    onPressed: () {
                      SharedPreferencesServices.setPrefs(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                      clearData();
                      pushReplaceRoute(
                        context: context,
                        route: const HomePage(),
                      );
                    },
                  ),
                  const Row(
                    children: [
                      CustomText(
                        title: AppStrings.haveAccount,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      CustomTextButton(
                        route: LogInPage(),
                        title: AppStrings.logIn,
                        color: AppColors.primaryColor,
                        fontSize: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearData() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
