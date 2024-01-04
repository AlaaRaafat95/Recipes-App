import 'package:recipe_app/services/app_value_notifier.services.dart';
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
  late CarouselController carouselController;
  late AppValueNotifier appValueNotifier;
  @override
  void initState() {
    carouselController = CarouselController();
    appValueNotifier = AppValueNotifier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: appValueNotifier.selectedIndexNotifier,
              builder: (context, value, _) => CarouselSliderEx(
                items: widget.adsList,
                carouselController: carouselController,
                onPageChanged: (index, _) {
                  appValueNotifier.pageChanged(index);
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
          child: ValueListenableBuilder(
            valueListenable: appValueNotifier.selectedIndexNotifier,
            builder: (context, value, _) => DotsIndicator(
              dotsCount: widget.adsList.length,
              position: value,
              onTap: (position) async {
                await carouselController.animateToPage(position);
                appValueNotifier.position(position);
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

  @override
  void dispose() {
    appValueNotifier.selectedIndexNotifier.dispose();
    super.dispose();
  }
}
