import 'package:recipe_app/utilities/exports.utilities.dart';

class UserModel {
  final TextEditingController? name;
  final TextEditingController email;
  final TextEditingController password;

  UserModel({this.name, required this.email, required this.password});
}
