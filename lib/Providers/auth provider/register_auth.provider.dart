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
        OverlayLoadingProgress.start(
          widget: Center(
            child: LoadingAnimationWidget.waveDots(
                color: AppColors.primaryColor, size: 80),
          ),
        );

        var credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text,
        );
        if (credential.user != null) {
          await credential.user?.updateDisplayName(nameController!.text);
          await verifyEmail();
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
          OverlayLoadingProgress.stop();
          OverlayWidget.showSnackBar(
              context: context,
              title: 'The account already exists for that email.');
        }
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
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

  void changeVisibility() {
    isIconPressed = !isIconPressed;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    OverlayLoadingProgress.start(
      widget: Center(
        child: LoadingAnimationWidget.waveDots(
            color: AppColors.primaryColor, size: 80),
      ),
    );
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

  Future<void> updateUserName() async {
    try {
      OverlayLoadingProgress.start(
        widget: Center(
          child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor, size: 80),
        ),
      );
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(nameController?.text);
      notifyListeners();
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Your Name Updated Successfully",
            userState: UserState.success),
      );
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Your Name Didn't Updated , Try Again",
            userState: UserState.failed),
      );
    }
  }

  Future<void> updateUserPassword() async {
    try {
      OverlayLoadingProgress.start(
        widget: Center(
          child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor, size: 80),
        ),
      );
      await FirebaseAuth.instance.currentUser
          ?.updatePassword(passwordController?.text ?? "");
      notifyListeners();
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Your Password Updated Successfully",
            userState: UserState.success),
      );
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Your Password Didn't Updated , Try Again",
            userState: UserState.failed),
      );
    }
  }

  Future<void> deleteUser() async {
    try {
      OverlayLoadingProgress.start(
        widget: Center(
          child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor, size: 80),
        ),
      );
      // await FirebaseAuth.instance.currentUser
      //     ?.reauthenticateWithCredential(credential);
      await FirebaseAuth.instance.currentUser?.delete();
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Your Account Deleted Successfully",
            userState: UserState.success),
      );
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Your Account Didn't Deleted , Try Again",
            userState: UserState.failed),
      );
    }
  }

  Future<void> verifyEmail() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();

      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Sending Email Successfully", userState: UserState.success),
      );
    } catch (e) {
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Sending Email Faild , Try Again",
            userState: UserState.failed),
      );
    }
  }
}
