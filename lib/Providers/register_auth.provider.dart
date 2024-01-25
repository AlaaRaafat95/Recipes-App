import 'package:recipe_app/utilities/exports.utilities.dart';

class UserRegisterProvider extends ChangeNotifier {
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
        OverlayLoadingProgress.start();
        var credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text,
        );
        if (credential.user != null) {
          await credential.user?.updateDisplayName(nameController!.text);
          OverlayLoadingProgress.stop();
          clearSignUpData();
          if (context.mounted) {
            Navigation.pushReplaceRoute(
              context: context,
              route: const MasterDrawerPage(),
            );
          }
        }
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          OverlayWidget.showSnackBar(
              context: context,
              title: 'The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      OverlayLoadingProgress.stop();
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

  Future<void> signOut(BuildContext context) async {
    OverlayLoadingProgress.start();
    await Future.delayed(
      const Duration(seconds: 2),
    );
    await FirebaseAuth.instance.signOut();

    if (context.mounted) {
      Navigation.pushReplaceRoute(
        context: context,
        route: const LogInPage(),
      );
    }
    OverlayLoadingProgress.stop();
  }
}
