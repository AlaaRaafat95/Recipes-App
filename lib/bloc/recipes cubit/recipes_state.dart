part of 'recipes_cubit.dart';

abstract class RecipesState {}

class RecipesInitial extends RecipesState {}

class RecipesLodaing extends RecipesState {}

class RecipesSuccess extends RecipesState {
  List<RecipeModel> recipesList;
  RecipesSuccess({required this.recipesList});
}

class RecipesFailure extends RecipesState {
  String error;
  RecipesFailure({required this.error});
}
