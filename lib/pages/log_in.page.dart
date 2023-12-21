import 'package:recipe_app/utilities/exports.utilities.dart';
import 'package:recipe_app/widgets/reuseable%20functions/validations.function.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late GlobalKey<FormState> formKey;
  bool isShow = false;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
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
                  title: AppStrings.signIn,
                  fontSize: 18.0,
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                ),
                const Spacer(flex: 2),
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
                  height: 20.0,
                ),
                CustomField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: !isShow,
                  labelText: AppStrings.password,
                  prefixIcon: Icons.lock_outline,
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
                  height: 10.0,
                ),
                const Row(
                  children: [
                    Spacer(),
                    CustomTextButton(
                      route: Text(""),
                      title: AppStrings.forgetPassword,
                      color: AppColors.blue,
                      fontSize: 12.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                CustomButton(
                  title: AppStrings.signIn,
                  fontSize: 16.0,
                  onPressed: () {
                    checkAndNavigate();
                  },
                ),
                const Spacer(flex: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: AppStrings.haveNotAccount,
                      color: AppColors.white,
                      fontSize: 14.0,
                    ),
                    CustomTextButton(
                      route: SignUpPage(),
                      title: AppStrings.register,
                      color: AppColors.primaryColor,
                      fontSize: 14.0,
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
    if (formKey.currentState?.validate() ?? false) {
      if (SharedPreferencesServices.getEmail() == emailController.text &&
          SharedPreferencesServices.getPassword() == passwordController.text) {
        clearData();
        pushReplaceRoute(
          context: context,
          route: const HomePage(),
        );
      } else {
        showSnackBar(context);
      }
    }
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
