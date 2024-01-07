import 'package:recipe_app/utilities/exports.utilities.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsState());
  List<AdModel> adsList = [];
  int selectedIndexNotifier = 0;

  void pageChanged(int index) {
    selectedIndexNotifier = index;
    emit(AdsState());
  }

  void position(int position) {
    selectedIndexNotifier = position;
    emit(AdsState());
  }

  Future<void> readAds(BuildContext context) async {
    try {
      String response = await rootBundle.loadString("assets/data/data.json");
      List<Map<String, dynamic>> responseDecode =
          List<Map<String, dynamic>>.from(
        jsonDecode(response)["ads"],
      );

      adsList = responseDecode
          .map(
            (e) => AdModel.fromJson(e),
          )
          .toList();
      emit(AdsState());
    } catch (e) {
      OverlayWidget.showSnackBar(
          context: context, title: "Faild Loading Data , Try Again");
    }
  }
}
