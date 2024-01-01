import 'package:recipe_app/utilities/exports.utilities.dart';

class CarouselSliderEx extends StatelessWidget {
  final List<AdModel> items;
  final dynamic Function(int, CarouselPageChangedReason) onPageChanged;
  final CarouselController carouselController;

  const CarouselSliderEx(
      {super.key,
      required this.items,
      required this.carouselController,
      required this.onPageChanged});

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
            (e) => Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(e.imageUrl!),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.primaryColor.withOpacity(0.5),
                  ),
                  child: CustomText(
                    title: e.title.toString(),
                    color: AppColors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
