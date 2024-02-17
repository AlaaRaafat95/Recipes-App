import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  late UserLogInProvider userLogInAuth;

  @override
  void initState() {
    userLogInAuth = Provider.of<UserLogInProvider>(context, listen: false);
    userLogInAuth.initLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserLogInProvider>(
      builder: (context, userLogIn, _) => Form(
        key: userLogIn.formKey,
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
              title: tr("signIn"),
              fontSize: 18.0,
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 30.0,
            ),
            CustomField(
              keyboardType: TextInputType.emailAddress,
              controller: userLogIn.emailController,
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
              controller: userLogIn.passwordController,
              obscureText: userLogIn.isIconPressed,
              labelText: tr("password"),
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: CustomIconButton(
                icon: userLogIn.isIconPressed
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
                  userLogIn.changeVisibility();
                },
              ),
              validator: (value) {
                return Validation.passwordValidator(value ?? "");
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                const Spacer(),
                CustomTextButton(
                  onPressed: () async {
                    await OverlayWidget.showBottomSheet(
                      context: context,
                      widget: const UserResetPassword(),
                    );
                  },
                  title: tr("forgetPassword"),
                  color: AppColors.blue,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
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
              onPressed: () async {
                await userLogIn.logIn(context);
              },
              child: CustomText(
                title: tr("signIn"),
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
                  title: tr("haveNotAccount"),
                  color: AppColors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                CustomTextButton(
                  onPressed: () {
                    userLogIn.clearLogInData();
                    Navigation.pushReplaceRoute(
                      context: context,
                      route: const SignUpPage(),
                    );
                  },
                  title: tr("register"),
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
    userLogInAuth.disposeControllers();
    super.dispose();
  }
}
