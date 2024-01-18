import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class UserLogInAuth extends ChangeNotifier {
  GlobalKey<FormState>? formKey;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool isIconPressed = true;
  void initLogin() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> logIn(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController!.text, password: passwordController!.text);

        clearLogInData();
        Navigation.pushReplaceRoute(
          context: context,
          route: const HomePage(),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        OverlayWidget.showSnackBar(
            context: context, title: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        OverlayWidget.showSnackBar(
            context: context, title: 'Wrong password provided for that user.');
      } else if (e.code == "user-disabled") {
        OverlayWidget.showSnackBar(
            context: context, title: 'This email Account was disabled');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void clearLogInData() {
    emailController?.clear();
    passwordController?.clear();
  }

  void disposeControllers() {
    emailController?.dispose();
    passwordController?.dispose();
    isIconPressed = true;
  }

  void changeVisibility() {
    isIconPressed = !isIconPressed;
    notifyListeners();
  }
}
