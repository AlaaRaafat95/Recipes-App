import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late UserRegisterProvider userRegisterAuth;
  @override
  void initState() {
    userRegisterAuth =
        Provider.of<UserRegisterProvider>(context, listen: false);
    userRegisterAuth.initSignUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegisterProvider>(
      builder: (context, userRegister, _) => Form(
        key: userRegister.formKey,
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
            CustomText(
              title: tr("register"),
              fontSize: 18.0,
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 30.0,
            ),
            CustomField(
              keyboardType: TextInputType.name,
              controller: userRegister.nameController,
              labelText: tr("fullName"),
              prefixIcon: const Icon(Icons.person_4_outlined),
              validator: (value) {
                return Validation.nameValidator(value ?? "");
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomField(
              keyboardType: TextInputType.emailAddress,
              controller: userRegister.emailController,
              labelText: tr("emailAddress"),
              prefixIcon: const Icon(Icons.email_outlined),
              validator: (value) {
                return Validation.emailValidator(value ?? "");
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomField(
              keyboardType: TextInputType.visiblePassword,
              controller: userRegister.passwordController,
              labelText: tr("password"),
              prefixIcon: const Icon(Icons.lock_outline),
              obscureText: userRegister.isIconPressed,
              suffixIcon: CustomIconButton(
                icon: userRegister.isIconPressed
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        size: 20.0,
                        color: AppColors.lightGrey,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        size: 20.0,
                      ),
                onPressed: () {
                  userRegister.changeVisibility();
                },
              ),
              validator: (value) {
                return Validation.passwordValidator(value ?? "");
              },
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
              onPressed: () async {
                await userRegister.signUp(context);
              },
              child: CustomText(
                title: tr("register"),
                color: AppColors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(flex: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title: tr("haveAccount"),
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
                CustomTextButton(
                  onPressed: () {
                    userRegister.clearSignUpData();
                    Navigation.pushReplaceRoute(
                      context: context,
                      route: const LogInPage(),
                    );
                  },
                  title: tr("signIn"),
                  color: AppColors.primaryColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    userRegisterAuth.disposeControllers();
  }
}
