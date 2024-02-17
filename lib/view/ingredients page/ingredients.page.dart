import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Padding(
              padding: SharedPreferencesServices.getLocale() == "en"
                  ? const EdgeInsets.only(left: 20.0)
                  : const EdgeInsets.only(right: 20.0),
              child: Image.asset(AppStrings.menuIcon),
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            }),
        forceMaterialTransparency: true,
        elevation: 0.0,
      ),
      body: Consumer<IngredientsProvider>(
        builder: (context, ingredient, _) => ingredient.ingredientsList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (ingredient.ingredientsList?.isEmpty ?? false)
                ? Center(
                    child: CustomText(
                      title: tr("noIngredientsFound"),
                      fontSize: 30.0,
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: tr("myIngredients"),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        ),
                        ...List.generate(
                          ingredient.ingredientsList!.length,
                          (index) => CustomListTile(
                            titleColor: AppColors.black,
                            title:
                                ingredient.ingredientsList![index].name ?? "",
                            icon: Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                  horizontal: -4.0, vertical: -4.0),
                              side: const BorderSide(color: AppColors.black),
                              value: ingredient.ingredientsList![index].usersIds
                                  ?.contains(
                                      FirebaseAuth.instance.currentUser?.uid),
                              onChanged: (value) {
                                ingredient.addIngredientsToUser(
                                    ingredientId: ingredient
                                        .ingredientsList![index].docId!,
                                    isAdd: value ?? false);
                              },
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
