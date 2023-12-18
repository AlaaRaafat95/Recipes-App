import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomField extends StatelessWidget {
  final String labelText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  const CustomField(
      {super.key,
      this.controller,
      required this.labelText,
      this.suffixIcon,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: AppColors.white),
      obscureText: obscureText ?? false,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        floatingLabelStyle:
            const TextStyle(fontSize: 15, color: AppColors.white),
        suffixIcon: suffixIcon,
        suffixIconColor: AppColors.primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 15,
          color: AppColors.white,
        ),
      ),
    );
  }
}
