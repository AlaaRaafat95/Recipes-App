import 'package:recipe_app/utilities/exports.utilities.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(AppStrings.menuIcon),
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            }),
        forceMaterialTransparency: true,
        elevation: 0.0,
      ),
      body: Consumer<IngredientsProvider>(
        builder: (context, ingredient, child) => ingredient.ingredientsList ==
                null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (ingredient.ingredientsList?.isEmpty ?? false)
                ? const Center(
                    child: Text("No Ingredients Found"),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          title: AppStrings.myIngredients,
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
