import 'package:recipe_app/pages/profile%20page/profile%20widgets/name.widget.profile.dart';
import 'package:recipe_app/pages/profile%20page/profile%20widgets/password.widget.profile.dart';
import 'package:recipe_app/pages/profile%20page/profile%20widgets/profile_field.profile.dart';
import 'package:recipe_app/utilities/exports.utilities.dart';
import 'package:recipe_app/widgets/custom_profile_photo.widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    Provider.of<UserRegisterProvider>(context, listen: false).initSignUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          title: "Profile",
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const ProfilePhoto(),
            const SizedBox(
              height: 10,
            ),
            const NameField(),
            ProfileField(
                title: FirebaseAuth.instance.currentUser?.email ?? "",
                buttontitle: null,
                onPressed: () {},
                icon: Icons.email_outlined),
            const PasswordField(),
            ProfileField(
                buttontitle: "Delete",
                title: "Delete Account",
                onPressed: () {},
                icon: Icons.delete_forever_outlined)
          ],
        ),
      ),
    );
  }
}
