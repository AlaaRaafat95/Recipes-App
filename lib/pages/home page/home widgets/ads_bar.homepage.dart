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
    return Consumer<AdsProvider>(
      builder: (context, ads, child) => ads.adsList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (ads.adsList?.isEmpty ?? false)
              ? const Center(
                  child: Text("No Data Found"),
                )
              : Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CarouselSliderEx(
                          items: ads.adsList!,
                          carouselController: carouselController,
                          onPageChanged: (index, _) {
                            ads.pageChanged(index);
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
                        dotsCount: ads.adsList!.length,
                        position: ads.selectedIndex,
                        onTap: (position) async {
                          await carouselController.animateToPage(position);

                          ads.position(position);
                        },
                        decorator: const DotsDecorator(
                          activeSize: Size(25.0, 15.0),
                          size: Size(20.0, 11.0),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
