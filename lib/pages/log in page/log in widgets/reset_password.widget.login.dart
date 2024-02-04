import 'package:recipe_app/utilities/exports.utilities.dart';

class UserResetPassword extends StatefulWidget {
  const UserResetPassword({super.key});

  @override
  State<UserResetPassword> createState() => _UserResetPasswordState();
}

class _UserResetPasswordState extends State<UserResetPassword> {
  late GlobalKey<FormState>? resetFormKey;
  late TextEditingController resetEmailController;
  @override
  void initState() {
    resetFormKey = GlobalKey<FormState>();
    resetEmailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Form(
        key: resetFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomField(
              keyboardType: TextInputType.emailAddress,
              controller: resetEmailController,
              labelText: AppStrings.email,
              prefixIcon: const Icon(Icons.email_outlined),
              validator: (value) {
                return Validation.emailValidator(value ?? "");
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              backgroundColor: AppColors.primaryColor.withOpacity(0.5),
              onPressed: () async {
                if (resetFormKey?.currentState?.validate() ?? false) {
                  if (resetEmailController.text ==
                      Provider.of<UserLogInProvider>(context, listen: false)
                          .emailController
                          ?.text) {
                    await Provider.of<UserLogInProvider>(context, listen: false)
                        .resetPasswordEmail(
                            resetEmail: resetEmailController.text);
                    if (context.mounted) {
                      Navigation.popRoute(context);
                    }

                    resetEmailController.clear();
                  } else {
                    OverlayToastMessage.show(
                      widget: const PopUpMsg(
                          title: "Email Not Vaild",
                          userState: UserState.failed),
                    );
                  }
                }
              },
              minimumSize: const Size(30, 40),
              child: const CustomText(
                title: "Send",
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
