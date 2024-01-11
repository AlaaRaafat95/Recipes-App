import 'package:recipe_app/utilities/exports.utilities.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsInitial());
  List<AdModel> adsList = [];
  int selectedIndex = 0;

  void pageChanged(int index) {
    selectedIndex = index;
    emit(AdsInitial());
  }

  void position(int position) {
    selectedIndex = position;
    emit(AdsInitial());
  }

  Future<void> readAds() async {
    emit(AdsLoading());
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
      emit(AdsSuccess(adsList: adsList));
    } catch (e) {
      emit(AdsFailure(error: e.toString()));
    }
  }
}
