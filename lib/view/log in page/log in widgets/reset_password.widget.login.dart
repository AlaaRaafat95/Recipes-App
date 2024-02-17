import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class UserResetPassword extends StatefulWidget {
  const UserResetPassword({super.key});

  @override
  State<UserResetPassword> createState() => _UserResetPasswordState();
}

class _UserResetPasswordState extends State<UserResetPassword> {
  @override
  void initState() {
    Provider.of<UserLogInProvider>(context, listen: false).initLogin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserLogInProvider>(
      builder: (context, resetPassword, _) => CustomContainer(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: resetPassword.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              CustomField(
                keyboardType: TextInputType.emailAddress,
                controller: resetPassword.emailController,
                labelText: tr("emailAddress"),
                prefixIcon: const Icon(Icons.email_outlined),
                validator: (value) {
                  return Validation.emailValidator(value ?? "");
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomButton(
                backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                onPressed: () async {
                  if (resetPassword.formKey?.currentState?.validate() ??
                      false) {
                    if (resetPassword.emailController?.text ==
                        Provider.of<UserLogInProvider>(context, listen: false)
                            .emailController
                            ?.text) {
                      await Provider.of<UserLogInProvider>(context,
                              listen: false)
                          .resetPasswordEmail(
                              resetEmail: resetPassword.emailController!.text);
                      if (context.mounted) {
                        Navigation.popRoute(context);
                      }

                      resetPassword.emailController?.clear();
                    } else {
                      OverlayToastMessage.show(
                        widget: const PopUpMsg(
                            title: "Email Not Vaild",
                            userState: UserState.failed),
                      );
                    }
                  }
                },
                minimumSize: const Size(30.0, 40.0),
                child: CustomText(
                  title: tr("send"),
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Provider.of<UserLogInProvider>(context, listen: false).disposeControllers();
    super.dispose();
  }
}
