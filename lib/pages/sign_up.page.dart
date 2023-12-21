import 'package:recipe_app/utilities/exports.utilities.dart';
import 'package:recipe_app/widgets/reuseable%20functions/validations.function.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isShow = false;
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundImageContainer(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 4),
                Image.asset(AppStrings.logoPic),
                const Spacer(),
                const CustomText(
                  title: AppStrings.register,
                  fontSize: 18,
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                ),
                const Spacer(flex: 2),
                CustomField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  labelText: AppStrings.name,
                  prefixIcon: Icons.person_4_outlined,
                  validator: (value) {
                    return nameValidator(value ?? "");
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  labelText: AppStrings.email,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    return emailValidator(value ?? "");
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  labelText: AppStrings.password,
                  prefixIcon: Icons.lock_outline,
                  obscureText: !isShow,
                  suffixIcon: CustomIconButton(
                    isShow: isShow,
                    onPressed: () {
                      setState(
                        () {
                          isShow = !isShow;
                        },
                      );
                    },
                  ),
                  validator: (value) {
                    return passwordValidator(value ?? "");
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  title: AppStrings.register,
                  onPressed: () {
                    checkAndNavigate();
                  },
                ),
                const Spacer(flex: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: AppStrings.haveAccount,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    CustomTextButton(
                      route: LogInPage(),
                      title: AppStrings.signIn,
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkAndNavigate() {
    if (formKey.currentState!.validate()) {
      SharedPreferencesServices.setPrefs(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text);
      clearData();
      pushReplaceRoute(
        context: context,
        route: const HomePage(),
      );
    }
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
