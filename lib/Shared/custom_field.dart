import 'package:recipe_app/Constants/exports.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  const CustomField(
      {super.key, required this.hintText, this.suffixIcon, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                blurStyle: BlurStyle.outer,
                blurRadius: 3,
                color: AppColors.darkGrey)
          ]),
      child: TextFormField(
        style: const TextStyle(color: AppColors.primaryColor),
        obscureText: obscureText ?? false,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.primaryColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: AppColors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: AppColors.primaryColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: AppColors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
