import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';

class AdsBar extends StatefulWidget {
  const AdsBar({
    super.key,
  });

  @override
  State<AdsBar> createState() => _AdsBarState();
}

class _AdsBarState extends State<AdsBar> {
  @override
  void initState() {
    Provider.of<AdsProvider>(context, listen: false).initCarousel();
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
              ? Center(
                  child: CustomText(
                      title: tr("noAdsFoundNow"),
                      color: AppColors.primaryColor,
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic),
                )
              : Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CarouselSliderEx(
                          items: ads.adsList!,
                          carouselController: ads.carouselController,
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
                                await ads.carouselController.previousPage();
                              },
                              child: const Icon(Icons.arrow_back_outlined),
                            ),
                            CustomButton(
                              padding: const EdgeInsets.all(5.0),
                              minimumSize: Size.zero,
                              onPressed: () async {
                                await ads.carouselController.nextPage();
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
                          await ads.carouselController.animateToPage(position);

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
