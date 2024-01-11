part of 'ads_cubit.dart';

abstract class AdsState {}

class AdsInitial extends AdsState {}

class AdsLoading extends AdsState {}

class AdsSuccess extends AdsState {
  List<AdModel> adsList;
  AdsSuccess({
    required this.adsList,
  });
}

class AdsFailure extends AdsState {
  String error;
  AdsFailure({required this.error});
}
