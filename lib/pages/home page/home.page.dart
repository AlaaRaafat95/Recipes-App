import 'package:recipe_app/utilities/exports.utilities.dart';
import 'package:recipe_app/pages/home%20page/leading_icon.homepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CarouselController carouselController;
  int selectedIndex = 0;

  @override
  void initState() {
    carouselController = CarouselController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const LeadingIcon(),
        actions: [
          CustomIconButton(
            icon: const Icon(
              Icons.notifications_none_outlined,
              size: 30.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const DrawerEX(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: "Bonjor, ${SharedPreferencesServices.getName()}",
                color: AppColors.lightGrey,
                fontSize: 12.0,
              ),
              const SizedBox(
                height: 5.0,
              ),
              const CustomText(
                title: AppStrings.todayCook,
                fontSize: 20.0,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomContainer(
                    decoration: BoxDecoration(
                      color: AppColors.greyAccent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.search_outlined,
                          color: AppColors.lightGrey,
                        ),
                        CustomText(
                          title: AppStrings.search,
                          color: AppColors.lightGrey,
                          fontSize: 12.0,
                        ),
                      ],
                    ),
                  ),
                  CustomContainer(
                    decoration: BoxDecoration(
                      color: AppColors.greyAccent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Icon(Icons.tune_outlined),
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSliderEx(
                    items: AppStrings.items,
                    carouselController: carouselController,
                    onPageChanged: (index, _) {
                      setState(() {
                        selectedIndex = index;
                      });
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
              DotIndicators(
                dotsCount: AppStrings.items.length,
                position: selectedIndex,
                onTap: (position) async {
                  await carouselController.animateToPage(position);
                  setState(
                    () {
                      selectedIndex = position;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 5.0,
              ),
              const HeadLineTitle(title: AppStrings.todayRecipes),
            ],
          ),
        ),
      ),
    );
  }
}
