import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class SelectUserStatePage extends StatelessWidget {
  const SelectUserStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 20.0, left: 30.0, right: 30.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppStrings.splashPic),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Image.asset(
              AppStrings.logoPic,
              scale: 3.0,
            ),
            const SizedBox(
              height: 5.0,
            ),
            CustomText(
              title: tr("logoName"),
              color: AppColors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
            const Spacer(
              flex: 3,
            ),
            CustomButton(
              minimumSize: const Size.fromHeight(50.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                Navigation.pushReplaceRoute(
                  context: context,
                  route: const SignUpPage(),
                );
              },
              child: CustomText(
                title: tr("register"),
                color: AppColors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30.0),
            CustomTextButton(
              onPressed: () {
                Navigation.pushReplaceRoute(
                  context: context,
                  route: const LogInPage(),
                );
              },
              title: tr("signIn"),
              color: AppColors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
