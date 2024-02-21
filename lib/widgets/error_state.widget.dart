import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            AppImageAssets.errorStateImage,
            scale: 1.3,
          ),
          CustomText(
            title: tr("errorStateTitle"),
            fontFamily: "Abril Fatface",
            fontSize: 15.0,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
