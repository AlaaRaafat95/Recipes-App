import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class UserResetPassword extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController emailController;
  const UserResetPassword(
      {super.key, required this.emailController, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          CustomField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            labelText: tr("emailAddress"),
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          const SizedBox(
            height: 10.0,
          ),
          CustomButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: onPressed,
            minimumSize: const Size(30.0, 40.0),
            child: CustomText(
              title: tr("send"),
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
