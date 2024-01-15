import 'package:recipe_app/utilities/exports.utilities.dart';

abstract class UserAuth {
  static late GlobalKey<FormState> formKey;
  static late TextEditingController emailController;
  static late TextEditingController passwordController;
  static late TextEditingController nameController;

  static void checkLogIn(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      if (GetIt.I.get<SharedPreferences>().getString("email") ==
              emailController.text &&
          GetIt.I.get<SharedPreferences>().getString("password") ==
              passwordController.text) {
        clearLogInData();
        Nagivation.pushReplaceRoute(
          context: context,
          route: const HomePage(),
        );
      } else {
        OverlayWidget.showSnackBar(
            context: context, title: AppStrings.emailNotFound);
      }
    }
  }

  static void clearLogInData() {
    emailController.clear();
    passwordController.clear();
  }

  static void checkSignUp(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      GetIt.I.get<SharedPreferences>().setString("name", nameController.text);
      GetIt.I.get<SharedPreferences>().setString("email", emailController.text);
      GetIt.I
          .get<SharedPreferences>()
          .setString("password", passwordController.text);

      // SharedPreferencesServices.setPrefs(
      //     name: nameController.text,
      //     email: emailController.text,
      //     password: passwordController.text);
      clearSignUpData();
      Nagivation.pushReplaceRoute(
        context: context,
        route: const HomePage(),
      );
    }
  }

  static void clearSignUpData() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  static void checkUserFound(BuildContext context) {
    bool? isLogin =
        GetIt.I.get<SharedPreferences>().getString("email")?.isNotEmpty;
    //  SharedPreferencesServices.getEmail().isNotEmpty;

    Future.delayed(
      const Duration(seconds: 4),
      () {
        Nagivation.pushReplaceRoute(
          context: context,
          route:
              isLogin ?? false ? const HomePage() : const SelectUserStatePage(),
        );
      },
    );
  }
}
