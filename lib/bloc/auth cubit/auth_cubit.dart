import 'package:recipe_app/utilities/exports.utilities.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  AuthCubit() : super(AuthState());

  void checkLogIn(BuildContext context) {
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

  void clearLogInData() {
    emailController.clear();
    passwordController.clear();
  }

  void checkSignUp(BuildContext context) {
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

  void clearSignUpData() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
