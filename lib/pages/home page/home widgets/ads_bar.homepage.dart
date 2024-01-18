import 'package:recipe_app/utilities/exports.utilities.dart';

class AdsBar extends StatefulWidget {
  const AdsBar({
    super.key,
  });

  @override
  State<AdsBar> createState() => _AdsBarState();
}

class _AdsBarState extends State<AdsBar> {
  late CarouselController carouselController;
  @override
  void initState() {
    carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Consumer<RecipeProvider>(
              builder: (context, ads, _) => CarouselSliderEx(
                items: ads.adsList,
                carouselController: carouselController,
                onPageChanged: (index, _) {
                  Provider.of<RecipeProvider>(context, listen: false)
                      .pageChanged(index);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  padding: const EdgeInsets.all(5.0),
                  minimumSize: Size.zero,
                  onPressed: () async {
                    await carouselController.previousPage();
                  },
                  child: const Icon(Icons.arrow_back_outlined),
                ),
                CustomButton(
                  padding: const EdgeInsets.all(5.0),
                  minimumSize: Size.zero,
                  onPressed: () async {
                    await carouselController.nextPage();
                  },
                  child: const Icon(Icons.arrow_forward_outlined),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        Center(
          child: Consumer<RecipeProvider>(
            builder: (context, ads, _) => DotsIndicator(
              dotsCount: ads.adsList.length,
              position: ads.selectedIndex,
              onTap: (position) async {
                await carouselController.animateToPage(position);

                Provider.of<RecipeProvider>(context, listen: false)
                    .position(position);
              },
              decorator: const DotsDecorator(
                activeSize: Size(25.0, 15.0),
                size: Size(20.0, 11.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
