import 'package:recipe_app/utilities/exports.utilities.dart';

class CarouselSliderEx extends StatelessWidget {
  const CarouselSliderEx(
      {super.key,
      required this.items,
      required this.carouselController,
      required this.onPageChanged});
  final List<String> items;
  final dynamic Function(int, CarouselPageChangedReason) onPageChanged;

  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          enlargeFactor: 0.25,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          onPageChanged: onPageChanged),
      items: items
          .map(
            (e) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(e),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
