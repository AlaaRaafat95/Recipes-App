import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late TextEditingController newPasswordController;
  @override
  void initState() {
    newPasswordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegisterProvider>(
      builder: (context, userRegister, _) => ProfileField(
          title: tr("password"),
          subTitle: "********",
          onPressed: () async {
            await OverlayWidget.showBottomSheet(
              context: context,
              widget: Form(
                key: userRegister.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: userRegister.passwordController,
                      labelText: tr("oldPassword"),
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
                    CustomField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: newPasswordController,
                      labelText: tr("newPassword"),
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
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: SharedPreferencesServices.getLocale() == "en"
                              ? const EdgeInsets.only(right: 20.0)
                              : const EdgeInsets.only(left: 20.0),
                          child: CustomButton(
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () async {
                              if (userRegister.formKey?.currentState
                                      ?.validate() ??
                                  false) {
                                await userRegister.updateUserPassword(
                                    currentPassword:
                                        userRegister.passwordController!.text,
                                    newPassword: newPasswordController.text);
                                if (context.mounted) {
                                  Navigation.popRoute(context);
                                }

                                userRegister.passwordController?.clear();
                                newPasswordController.clear();
                              }
                            },
                            minimumSize: const Size(30.0, 40.0),
                            child: CustomText(
                              title: tr("resetPassword"),
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    )
                  ],
                ),
              ),
            );
          },
          icon: Icons.password_outlined),
    );
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }
}
