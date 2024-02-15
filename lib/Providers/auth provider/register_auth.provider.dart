import 'package:recipe_app/utilities/exports.utilities.dart';

class UserRegisterProvider extends ChangeNotifier {
  GlobalKey<FormState>? formKey;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? nameController;
  bool isIconPressed = true;
  String? _userName;
  String? get userName => _userName;
  void initSignUp() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        OverlayWidget.showAnimateLoading();

        var credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text,
        );
        if (credential.user != null) {
          await credential.user?.updateDisplayName(nameController!.text);
          getUserNameCapitalLetters(userName: nameController!.text);

          await verifyEmail();
          clearSignUpData();
          OverlayLoadingProgress.stop();
          OverlayToastMessage.show(
            widget: const PopUpMsg(
              title:
                  "Register Successfully , Sending Email Verification ......",
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
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
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
      if (context.mounted) {
        OverlayWidget.showSnackBar(
            context: context, title: AppStrings.errorStateTitle);
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
    OverlayWidget.showAnimateLoading();
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

  Future<void> updateUserName({required String newName}) async {
    try {
      OverlayWidget.showAnimateLoading();
      await FirebaseAuth.instance.currentUser?.updateDisplayName(newName);
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

  Future<void> updateUserPassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      OverlayWidget.showAnimateLoading();

      AuthCredential credential = EmailAuthProvider.credential(
        email: FirebaseAuth.instance.currentUser?.email ?? "",
        password: currentPassword,
      );

      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);

      await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);

      notifyListeners();

      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
          title: "Your Password Updated Successfully",
          userState: UserState.success,
        ),
      );
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if (e.code == 'wrong-password') {
        OverlayToastMessage.show(
          widget: const PopUpMsg(
            title: "Incorrect Old Password, Try Again",
            userState: UserState.failed,
          ),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
          title: "Password Update Failed, Try Again",
          userState: UserState.failed,
        ),
      );
    }
  }

  Future<void> deleteUser({required String currentPassword}) async {
    try {
      OverlayWidget.showAnimateLoading();
      AuthCredential credential = EmailAuthProvider.credential(
        email: FirebaseAuth.instance.currentUser!.email!,
        password: currentPassword,
      );

      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);

      await FirebaseAuth.instance.currentUser?.delete();
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Your Account Deleted Successfully",
            userState: UserState.success),
      );
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if (e.code == 'wrong-password') {
        OverlayToastMessage.show(
          widget: const PopUpMsg(
            title: "Incorrect Password, Try Again",
            userState: UserState.failed,
          ),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Your Account Didn't Deleted , Try Again",
            userState: UserState.failed),
      );
    }
  }

  void getUserNameCapitalLetters({required String userName}) async {
    String result = userName.split(' ').take(2).map((word) => word[0]).join('');
    _userName = result;
    notifyListeners();
  }

  Future<void> verifyEmail() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Sending Email Faild , Try Again",
            userState: UserState.failed),
      );
    }
  }
}
