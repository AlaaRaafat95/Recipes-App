import 'package:recipe_app/utilities/exports.utilities.dart';

class PopUpMsg extends StatelessWidget {
  final String title;
  final UserState userState;
  const PopUpMsg({super.key, required this.title, required this.userState});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: userState == UserState.success
            ? Colors.green
            : userState == UserState.failed
                ? AppColors.red
                : AppColors.black.withOpacity(0.4),
        boxShadow: [
          BoxShadow(
            spreadRadius: 3.0,
            blurRadius: 10.0,
            offset: const Offset(0.0, 5.0),
            color: AppColors.black.withOpacity(0.4),
          )
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: CustomText(
          title: title,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 15),
    );
  }
}

enum UserState { success, failed }
