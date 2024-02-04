import 'package:recipe_app/pages/profile%20page/profile%20widgets/profile_field.profile.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class NameField extends StatefulWidget {
  const NameField({super.key});

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegisterProvider>(
      builder: (context, userRegister, child) => ProfileField(
          title: FirebaseAuth.instance.currentUser?.displayName ?? "",
          buttontitle: "Edit Name",
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
                      height: 10,
                    ),
                    CustomField(
                      keyboardType: TextInputType.name,
                      controller: userRegister.nameController,
                      labelText: "New Name",
                      prefixIcon: const Icon(
                        Icons.person_4_outlined,
                        color: AppColors.primaryColor,
                      ),
                      validator: (value) {
                        return Validation.nameValidator(value ?? "");
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        CustomButton(
                          backgroundColor: AppColors.primaryColor,
                          onPressed: () async {
                            if (userRegister.formKey?.currentState
                                    ?.validate() ??
                                false) {
                              await userRegister.updateUserName();

                              if (context.mounted) {
                                Navigation.popRoute(context);
                                userRegister.nameController?.clear();
                              }
                            }
                          },
                          minimumSize: const Size(30, 40),
                          child: const CustomText(
                            title: "Reset Name",
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
          icon: Icons.person_2_outlined),
    );
  }
}
