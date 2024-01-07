import 'package:recipe_app/utilities/exports.utilities.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  late AppValueNotifier appValueNotifier;
  late AuthCubit authCubit;
  @override
  void initState() {
    appValueNotifier = AppValueNotifier();
    authCubit = BlocProvider.of<AuthCubit>(context);
    authCubit.formKey = GlobalKey<FormState>();
    authCubit.emailController = TextEditingController();
    authCubit.passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, _) => Form(
        key: authCubit.formKey,
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
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 30.0,
            ),
            CustomField(
              keyboardType: TextInputType.emailAddress,
              controller: authCubit.emailController,
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
                controller: authCubit.passwordController,
                obscureText: !value,
                labelText: AppStrings.password,
                prefixIcon: Icons.lock_outline,
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
              onPressed: () {
                authCubit.checkLogIn(context);
              },
              child: const CustomText(
                title: AppStrings.signIn,
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
                  title: AppStrings.haveNotAccount,
                  color: AppColors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                CustomTextButton(
                  route: SignUpPage(),
                  title: AppStrings.register,
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
}
