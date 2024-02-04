import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        OverlayLoadingProgress.start(
          widget: Center(
            child: LoadingAnimationWidget.waveDots(
                color: AppColors.primaryColor, size: 80),
          ),
        );
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController?.text ?? "",
            password: passwordController?.text ?? "");
        if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
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

  String getUserNameCapitalLetters({required String? username}) {
    String result =
        username!.split(' ').take(2).map((word) => word[0]).join('');

    return result;
  }

  Future<void> resetPasswordEmail({required String resetEmail}) async {
    try {
      OverlayLoadingProgress.start(
        widget: Center(
          child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor, size: 80),
        ),
      );
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
      OverlayLoadingProgress.start(
        widget: Center(
          child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor, size: 80),
        ),
      );
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
        OverlayToastMessage.show(
          widget: const PopUpMsg(
            title: "Uploading Photo Successfully",
            userState: UserState.success,
          ),
        );
      }

      OverlayLoadingProgress.stop();
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
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(null);
    notifyListeners();
  }
}
