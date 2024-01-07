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
            BlocBuilder<AdsCubit, AdsState>(
              builder: (context, _) => CarouselSliderEx(
                items: BlocProvider.of<AdsCubit>(context).adsList,
                carouselController: carouselController,
                onPageChanged: (index, _) {
                  BlocProvider.of<AdsCubit>(context).pageChanged(index);
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
          child: BlocBuilder<AdsCubit, AdsState>(
            builder: (context, _) => DotsIndicator(
              dotsCount: BlocProvider.of<AdsCubit>(context).adsList.length,
              position:
                  BlocProvider.of<AdsCubit>(context).selectedIndexNotifier,
              onTap: (position) async {
                await carouselController.animateToPage(position);
                BlocProvider.of<AdsCubit>(context).position(position);
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
