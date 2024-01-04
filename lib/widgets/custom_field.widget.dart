import 'package:recipe_app/utilities/exports.utilities.dart';

class CustomField extends StatelessWidget {
  final String labelText;
  final Widget? suffixIcon;
  final IconData prefixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  const CustomField(
      {super.key,
      this.controller,
      required this.labelText,
      required this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      required this.keyboardType,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      style: const TextStyle(color: AppColors.primaryColor),
      obscureText: obscureText ?? false,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        prefixIconColor: AppColors.lightGrey,
        floatingLabelStyle: const TextStyle(
            fontSize: 14.0,
            color: AppColors.lightGrey,
            fontWeight: FontWeight.w400),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: AppColors.primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        labelText: labelText,
        labelStyle: const TextStyle(
            fontSize: 14.0,
            color: AppColors.lightGrey,
            fontWeight: FontWeight.w400),
      ),
      validator: validator,
    );
  }
}
