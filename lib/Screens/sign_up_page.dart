import 'package:recipe_app/Constants/exports.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppStrings.mainPic,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomText(
                    title: " Cook Like A Chef",
                    color: AppColors.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColors.primaryColor.withOpacity(0.5),
                    AppColors.primaryColor.withOpacity(0.2),
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustomField(
                      hintText: AppStrings.name,
                    ),
                    const CustomField(
                      hintText: AppStrings.email,
                    ),
                    const CustomField(
                      hintText: AppStrings.password,
                    ),
                    CustomButton(
                      title: AppStrings.signUp,
                      onPressed: () {
                        pushReplaceRoute(
                          context: context,
                          route: const HomePage(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
