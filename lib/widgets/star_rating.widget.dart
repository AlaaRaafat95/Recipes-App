import 'package:recipe_app/utilities/exports.utilities.dart';

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          return Icon(
            index < value ? Icons.star : Icons.star_border,
            color: AppColors.primaryColor,
            size: 15.0,
          );
        },
      ),
    );
  }
}
