import 'package:recipe_app/utilities/exports.utilities.dart';

class PopUpMsg extends StatelessWidget {
  final String title;
  final UserState userState;
  const PopUpMsg({super.key, required this.title, required this.userState});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: userState == UserState.success
            ? Colors.green
            : userState == UserState.failed
                ? Colors.red
                : Colors.black12,
        boxShadow: const [
          BoxShadow(
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 5),
              color: Colors.black12)
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
      ),
    );
  }
}

enum UserState { success, failed }
