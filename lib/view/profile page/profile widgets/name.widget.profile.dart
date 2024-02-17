import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class NameField extends StatefulWidget {
  const NameField({super.key});

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  late TextEditingController newNameController = TextEditingController();
  @override
  void initState() {
    newNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegisterProvider>(
      builder: (context, userRegister, _) => ProfileField(
          title: tr("name"),
          subTitle: FirebaseAuth.instance.currentUser?.displayName ?? "",
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
                      enabled: false,
                      keyboardType: TextInputType.name,
                      controller: userRegister.nameController,
                      labelText:
                          FirebaseAuth.instance.currentUser?.displayName ?? "",
                      prefixIcon: const Icon(
                        Icons.person_2_outlined,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomField(
                      keyboardType: TextInputType.name,
                      controller: newNameController,
                      labelText: tr("newName"),
                      prefixIcon: const Icon(
                        Icons.person_4_outlined,
                        color: AppColors.primaryColor,
                      ),
                      validator: (value) {
                        return Validation.nameValidator(value ?? "");
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
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
                                await userRegister.updateUserName(
                                    newName: newNameController.text);

                                if (context.mounted) {
                                  userRegister.getUserNameCapitalLetters(
                                      userName: newNameController.text);

                                  Navigation.popRoute(context);
                                  newNameController.clear();
                                }
                              }
                            },
                            minimumSize: const Size(30.0, 40.0),
                            child: CustomText(
                              title: tr("resetName"),
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
          icon: Icons.person_2_outlined),
    );
  }

  @override
  void dispose() {
    newNameController.dispose();
    super.dispose();
  }
}
