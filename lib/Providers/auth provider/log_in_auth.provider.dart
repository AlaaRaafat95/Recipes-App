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
        OverlayWidget.showAnimateLoading();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController?.text ?? "",
            password: passwordController?.text ?? "");
        if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
          clearLogInData();
          if (context.mounted) {
            Provider.of<UserRegisterProvider>(context, listen: false)
                .getUserNameCapitalLetters(
              userName:
                  FirebaseAuth.instance.currentUser!.displayName.toString(),
            );
          }

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
        } else {
          OverlayLoadingProgress.stop();
          OverlayToastMessage.show(
            widget: const PopUpMsg(
                title:
                    "Your Email isn't Verify ,Please Check Your Email Inbox And Try Again",
                userState: UserState.failed),
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
        if (context.mounted) {
          OverlayWidget.showSnackBar(
              context: context, title: 'This email Account was disabled');
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

  Future<void> resetPasswordEmail({required String resetEmail}) async {
    try {
      OverlayWidget.showAnimateLoading();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: resetEmail);
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Send Email Successfuly", userState: UserState.success),
      );
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
            title: "Sending Email Faild , Try Again",
            userState: UserState.failed),
      );
    }
  }

  Future<void> updateUerPhotoUrl() async {
    try {
      OverlayWidget.showAnimateLoading();
      var imageUrl = await FilePicker.platform
          .pickFiles(type: FileType.image, withData: true);
      var refs = FirebaseStorage.instance
          .ref("profile_images/${imageUrl?.files.first.name}");
      if (imageUrl?.files.first.bytes != null) {
        await refs.putData(
          imageUrl!.files.first.bytes!,
          SettableMetadata(contentType: "image/png"),
        );
        await FirebaseAuth.instance.currentUser
            ?.updatePhotoURL(await refs.getDownloadURL());
        notifyListeners();
        OverlayLoadingProgress.stop();
        OverlayToastMessage.show(
          widget: const PopUpMsg(
            title: "Uploading Photo Successfully",
            userState: UserState.success,
          ),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: const PopUpMsg(
          title: "Uploading Photo Faild",
          userState: UserState.failed,
        ),
      );
    }
  }

  Future<void> removeUerPhotoUrl() async {
    OverlayWidget.showAnimateLoading();
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(null);
    notifyListeners();
    OverlayLoadingProgress.stop();
  }
}
