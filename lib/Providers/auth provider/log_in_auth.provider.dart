import 'package:easy_localization/easy_localization.dart';
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
            widget: PopUpMsg(
              title: tr("logInSuccessfully"),
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
            widget: PopUpMsg(
                title: tr("yourEmailIsn'tVerify"), userState: UserState.failed),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if (e.code == 'user-not-found') {
        if (context.mounted) {
          OverlayWidget.showSnackBar(
            context: context,
            title: tr("noUserFoundForThatEmail"),
          );
        }
      } else if (e.code == 'wrong-password') {
        if (context.mounted) {
          OverlayWidget.showSnackBar(
            context: context,
            title: tr("wrongPasswordProvidedForThatUser"),
          );
        }
      } else if (e.code == "user-disabled") {
        if (context.mounted) {
          OverlayWidget.showSnackBar(
            context: context,
            title: tr("thisEmailAccountWasDisabled"),
          );
        }
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      if (context.mounted) {
        OverlayWidget.showSnackBar(
            context: context, title: tr("errorStateTitle"));
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
        widget: PopUpMsg(
            title: tr("sendEmailSuccessfuly"), userState: UserState.success),
      );
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: PopUpMsg(
            title: tr("sendingEmailFaild"), userState: UserState.failed),
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
          widget: PopUpMsg(
            title: tr("uploadingPhotoSuccessfully"),
            userState: UserState.success,
          ),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: PopUpMsg(
          title: tr("uploadingPhotoFaild"),
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
