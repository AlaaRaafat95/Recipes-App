import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  late TextEditingController currentPasswordController;
  @override
  void initState() {
    currentPasswordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegisterProvider>(
      builder: (context, userRegister, _) => ProfileField(
          title: tr("delete"),
          subTitle: tr("deleteAccount"),
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
                      controller: currentPasswordController,
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
                                Navigation.popRoute(context);
                                return await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return OverlayWidget.alertDialog(
                                      title: tr("deleteAccount"),
                                      context: context,
                                      content: tr("doyouWantDeleteAccount"),
                                      onPressed: () async {
                                        await userRegister.deleteUser(
                                            currentPassword:
                                                currentPasswordController.text);

                                        if (context.mounted) {
                                          Navigation.pushReplaceRoute(
                                            context: context,
                                            route: const LogInPage(),
                                          );
                                        }

                                        currentPasswordController.clear();
                                      },
                                    );
                                  },
                                );
                              }
                            },
                            minimumSize: const Size(30.0, 40.0),
                            child: CustomText(
                              title: tr("deleteAccount"),
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
          icon: Icons.delete_forever_outlined),
    );
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    super.dispose();
  }
}
