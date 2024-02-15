import 'package:recipe_app/utilities/exports.utilities.dart';
import 'package:recipe_app/view/profile%20page/profile%20widgets/delete_account.profile.dart';

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
          title: AppStrings.profile,
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            const ProfilePhoto(),
            const SizedBox(
              height: 10.0,
            ),
            const NameField(),
            ProfileField(
                title: AppStrings.email,
                subTitle: FirebaseAuth.instance.currentUser?.email ?? "",
                onPressed: () {},
                icon: Icons.email_outlined),
            const PasswordField(),
            const DeleteAccount()
          ],
        ),
      ),
    );
  }
}
