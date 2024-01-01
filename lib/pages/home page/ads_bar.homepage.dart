import 'package:recipe_app/utilities/exports.utilities.dart';

class AdsBar extends StatefulWidget {
  final List<AdModel> adsList;

  const AdsBar({
    super.key,
    required this.adsList,
  });

  @override
  State<AdsBar> createState() => _AdsBarState();
}

class _AdsBarState extends State<AdsBar> {
  CarouselController carouselController = CarouselController();

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CarouselSliderEx(
              items: widget.adsList,
              carouselController: carouselController,
              onPageChanged: (index, _) {
                setState(
                  () {
                    selectedIndex = index;
                  },
                );
              },
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
          child: DotsIndicator(
            dotsCount: widget.adsList.length,
            position: selectedIndex,
            onTap: (position) async {
              await carouselController.animateToPage(position);
              setState(
                () {
                  selectedIndex = position;
                },
              );
            },
            decorator: const DotsDecorator(
              activeSize: Size(25.0, 15.0),
              size: Size(20.0, 11.0),
            ),
          ),
        ),
      ],
    );
  }
}
