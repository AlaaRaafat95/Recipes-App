import 'package:recipe_app/utilities/exports.utilities.dart';

class UserLogInProvider extends ChangeNotifier {
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
        OverlayLoadingProgress.start();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController?.text ?? "",
            password: passwordController?.text ?? "");

        clearLogInData();
        OverlayLoadingProgress.stop();
        OverlayToastMessage.show(
          widget: const PopUpMsg(
            title: "Log In Successfully",
            userState: UserState.success,
          ),
        );

        if (context.mounted) {
          Navigation.pushReplaceRoute(
            context: context,
            route: const MasterDrawerPage(),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if (e.code == 'user-not-found') {
        if (context.mounted) {
          OverlayWidget.showSnackBar(
              context: context, title: 'No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (context.mounted) {
          OverlayWidget.showSnackBar(
              context: context,
              title: 'Wrong password provided for that user.');
        }
      } else if (e.code == "user-disabled") {
        OverlayLoadingProgress.stop();

        if (context.mounted) {
          OverlayWidget.showSnackBar(
              context: context, title: 'This email Account was disabled');
        }
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
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
