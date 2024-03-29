import 'package:recipe_app/utilities/exports.utilities.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CustomContainer(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppImageAssets.mainPic,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            CustomContainer(
              padding:
                  const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.5),
              ),
              child: const SignUpForm(),
            )
          ],
        ),
      ),
    );
  }
}
