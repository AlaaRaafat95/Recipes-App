import 'package:recipe_app/utilities/exports.utilities.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomContainer(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppStrings.mainPic,
                ),
                fit: BoxFit.cover),
          ),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
