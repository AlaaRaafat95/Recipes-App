import 'package:recipe_app/utilities/exports.utilities.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
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
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Image.asset(
            AppStrings.logoPic,
            scale: 3.0,
          ),
          const SizedBox(
            height: 30.0,
          ),
          const CustomText(
            title: AppStrings.signIn,
            fontSize: 18.0,
            color: AppColors.white,
            fontWeight: FontWeight.w900,
          ),
          const SizedBox(
            height: 30.0,
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
            height: 20.0,
          ),
          CustomField(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            obscureText: !isShow,
            labelText: AppStrings.password,
            prefixIcon: Icons.lock_outline,
            suffixIcon: CustomIconButton(
              icon: isShow
                  ? const Icon(
                      Icons.visibility_outlined,
                      size: 20.0,
                    )
                  : const Icon(
                      Icons.visibility_off_outlined,
                      size: 20.0,
                      color: AppColors.lightGrey,
                    ),
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
            minimumSize: const Size.fromHeight(50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              checkAndNavigate();
            },
            child: const CustomText(
              title: AppStrings.signIn,
              color: AppColors.white,
              fontSize: 16.0,
            ),
          ),
          const Spacer(flex: 5),
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
