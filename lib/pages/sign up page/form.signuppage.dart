import 'package:recipe_app/services/app_value_notifier.services.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late AppValueNotifier appValueNotifier;
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    appValueNotifier = AppValueNotifier();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
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
            title: AppStrings.register,
            fontSize: 18.0,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            height: 30.0,
          ),
          CustomField(
            keyboardType: TextInputType.name,
            controller: nameController,
            labelText: AppStrings.name,
            prefixIcon: Icons.person_4_outlined,
            validator: (value) {
              return Validation.nameValidator(value ?? "");
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
              return Validation.emailValidator(value ?? "");
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          ValueListenableBuilder(
            valueListenable: appValueNotifier.iconNotifier,
            builder: (context, value, _) => CustomField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              labelText: AppStrings.password,
              prefixIcon: Icons.lock_outline,
              obscureText: !value,
              suffixIcon: CustomIconButton(
                icon: value
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
                  appValueNotifier.changeIcon();
                },
              ),
              validator: (value) {
                return Validation.passwordValidator(value ?? "");
              },
            ),
          ),
          const SizedBox(
            height: 50.0,
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
              title: AppStrings.register,
              color: AppColors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(flex: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: AppStrings.haveAccount,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
              CustomTextButton(
                route: LogInPage(),
                title: AppStrings.signIn,
                color: AppColors.primaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void checkAndNavigate() {
    if (formKey.currentState?.validate() ?? false) {
      GetIt.I.get<SharedPreferences>().setString("name", nameController.text);
      GetIt.I.get<SharedPreferences>().setString("email", emailController.text);
      GetIt.I
          .get<SharedPreferences>()
          .setString("password", passwordController.text);

      // SharedPreferencesServices.setPrefs(
      //     name: nameController.text,
      //     email: emailController.text,
      //     password: passwordController.text);
      clearData();
      Nagivation.pushReplaceRoute(
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
    appValueNotifier.iconNotifier.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
