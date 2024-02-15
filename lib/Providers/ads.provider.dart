import 'package:recipe_app/utilities/exports.utilities.dart';

class AdsProvider extends ChangeNotifier {
  List<AdModel>? _adsList;
  int selectedIndex = 0;
  late CarouselController carouselController;
  initCarousel() {
    carouselController = CarouselController();
  }

  List<AdModel>? get adsList => _adsList;
  Future<void> readAds() async {
    try {
      var ads = await FirebaseFirestore.instance.collection("ads").get();
      if (ads.docs.isNotEmpty) {
        _adsList = List<AdModel>.from(
          ads.docs.map(
            (doc) => AdModel.fromJson(
              doc.data(),
            ),
          ),
        );
      } else {
        _adsList = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: const PopUpMsg(
          title: "There was an error",
          userState: UserState.failed,
        ),
      );
    }
  }

  void pageChanged(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void position(int position) {
    selectedIndex = position;
    notifyListeners();
  }
}
