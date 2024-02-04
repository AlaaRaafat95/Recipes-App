import 'package:recipe_app/pages/profile%20page/profile%20widgets/profile_field.profile.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late TextEditingController newPasswordControler;
  @override
  void initState() {
    newPasswordControler = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegisterProvider>(
      builder: (context, userRegister, child) => ProfileField(
          title: "********",
          buttontitle: "Reset Password",
          onPressed: () async {
            await OverlayWidget.showBottomSheet(
              context: context,
              widget: Form(
                key: userRegister.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CustomField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: userRegister.passwordController,
                      labelText: "New Password",
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
                      controller: newPasswordControler,
                      labelText: "re-try Password",
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
                        CustomButton(
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.5),
                          onPressed: () async {
                            if (userRegister.formKey?.currentState
                                    ?.validate() ??
                                false) {
                              if (userRegister.passwordController?.text ==
                                  newPasswordControler.text) {
                                await userRegister.updateUserPassword();
                                if (context.mounted) {
                                  Navigation.popRoute(context);
                                }

                                userRegister.passwordController?.clear();
                                newPasswordControler.clear();
                                setState(() {});
                              } else {
                                OverlayToastMessage.show(
                                  widget: const PopUpMsg(
                                      title: "Passwords Not Equal , Try Again",
                                      userState: UserState.failed),
                                );
                              }
                            }
                          },
                          minimumSize: const Size(30, 40),
                          child: const CustomText(
                            title: "Reset Password",
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            );
          },
          icon: Icons.password_outlined),
    );
  }
}
