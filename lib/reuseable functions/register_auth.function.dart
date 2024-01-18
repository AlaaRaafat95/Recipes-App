import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class UserRegisterAuth extends ChangeNotifier {
  GlobalKey<FormState>? formKey;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? nameController;
  bool isIconPressed = true;
  void initSignUp() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        var credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text,
        );
        if (credential.user != null) {
          await credential.user?.updateDisplayName(nameController!.text);
          clearSignUpData();
          Navigation.pushReplaceRoute(
            context: context,
            route: const HomePage(),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        OverlayWidget.showSnackBar(
            context: context,
            title: 'The account already exists for that email.');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void clearSignUpData() {
    nameController?.clear();
    emailController?.clear();
    passwordController?.clear();
  }

  void disposeControllers() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    isIconPressed = true;
  }

  Future<void> checkUserLogedIn(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5), () {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        Navigation.pushReplaceRoute(
          context: context,
          route: user != null ? const HomePage() : const SelectUserStatePage(),
        );
      });
    });
  }

  String getUserNameCapitalLetters(
      {required String? username, required int limitTo}) {
    String result =
        username!.split(' ').take(limitTo).map((word) => word[0]).join('');

    return result;
  }

  void changeVisibility() {
    isIconPressed = !isIconPressed;
    notifyListeners();
  }
}
