import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Padding(
              padding: SharedPreferencesServices.getLocale() == "en"
                  ? const EdgeInsets.only(left: 20.0)
                  : const EdgeInsets.only(right: 20.0),
              child: Image.asset(AppImageAssets.menuIcon),
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            }),
      ),
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: tr("settings"),
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
              CustomContainer(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.greyAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CustomListTile(
                  titleColor: AppColors.black,
                  icon: const Icon(
                    Icons.language_outlined,
                    color: AppColors.black,
                  ),
                  title: tr("language"),
                  trailing: SizedBox(
                    width: 100.0,
                    child: DropdownButton(
                      iconEnabledColor: AppColors.primaryColor,
                      style: const TextStyle(color: AppColors.primaryColor),
                      value: SharedPreferencesServices.getLocale() == "en"
                          ? tr("english")
                          : tr("arabic"),
                      items: [
                        ("english"),
                        ("arabic"),
                      ]
                          .map(
                            (language) => DropdownMenuItem(
                              value: (language).tr(),
                              child: CustomText(
                                title: (language).tr(),
                              ),
                            ),
                          )
                          .toList(),
                      isExpanded: true,
                      onChanged: (value) async {
                        languageProvider.changeValue(value);

                        await languageProvider.changeLanguage(
                            context: context,
                            language:
                                languageProvider.dropdownValue == tr("english")
                                    ? "en"
                                    : "ar");
                      },
                    ),
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 10.0,
              ),
              CustomText(
                title: tr("profile"),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              CustomContainer(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.greyAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CustomListTile(
                  titleColor: AppColors.black,
                  icon: const Icon(
                    Icons.person_2_outlined,
                    color: AppColors.black,
                  ),
                  title: tr("account"),
                  trailing: CustomTextButton(
                    onPressed: () {
                      Navigation.pushRoute(
                        context: context,
                        route: const ProfilePage(),
                      );
                    },
                    title: tr("edit"),
                    color: AppColors.primaryColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
