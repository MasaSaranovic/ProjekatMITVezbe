import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/consts/app_colors.dart';
import 'package:skriptarnica/models/user_model.dart';
import 'package:skriptarnica/providers/theme_provider.dart';
import 'package:skriptarnica/providers/user_provider.dart';
import 'package:skriptarnica/screens/auth/login.dart';
import 'package:skriptarnica/screens/inner_screen/orders/orders_screen.dart';
import 'package:skriptarnica/screens/inner_screen/viewed_recently.dart';
import 'package:skriptarnica/screens/inner_screen/wishlist.dart';
import 'package:skriptarnica/services/assets_manager.dart';
import 'package:skriptarnica/services/my_app_functions.dart';
import 'package:skriptarnica/widgets/subtitle_text.dart';
import 'package:skriptarnica/widgets/title_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;

  UserModel? userModel;
  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {});
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppFunctions.showErrorOrWarningDialog(
        // ignore: use_build_context_synchronously
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.logo),
        ),
        title: const Text(
          "Profile Screen",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: user == null ? true : false,
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: TitelesTextWidget(
                    label: "Please login to have unlimited access"),
              ),
            ),
            userModel == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).cardColor,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.surface,
                                width: 3),
                            image: DecorationImage(
                              image: NetworkImage(
                                userModel!.userImage,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitelesTextWidget(label: userModel!.userName),
                            SubtitleTextWidget(label: userModel!.userEmail)
                          ],
                        )
                      ],
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitelesTextWidget(label: "General"),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: userModel == null ? false : true,
                    child: CustomListTile(
                      imagePath: "${AssetsManager.imagePath}/bag/checkout.png",
                      text: "All Orders",
                      function: () {
                        Navigator.pushNamed(context, OrdersScreen.routeName);
                      },
                    ),
                  ),
                  Visibility(
                    visible: userModel == null ? false : true,
                    child: CustomListTile(
                      imagePath: "${AssetsManager.imagePath}/bag/wishlist.png",
                      text: "Wishlist",
                      function: () {
                        Navigator.pushNamed(context, WishlistScreen.routName);
                      },
                    ),
                  ),
                  CustomListTile(
                    imagePath: "${AssetsManager.imagePath}/profile/repeat.png",
                    text: "Viewed Recently",
                    function: () {
                      Navigator.pushNamed(
                          context, ViewedRecentlyScreen.routName);
                    },
                  ),
                  CustomListTile(
                    imagePath: "${AssetsManager.imagePath}/address.png",
                    text: "Address",
                    function: () {},
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitelesTextWidget(
                    label: "Settings",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SwitchListTile(
                    secondary: Image.asset(
                        "${AssetsManager.imagePath}/profile/night-mode.png",
                        height: 34),
                    title: Text(themeProvider.getIsDarkTheme
                        ? "Dark Theme"
                        : "Light Theme"),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  )
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                icon: Icon(user == null ? Icons.login : Icons.logout,
                    color: Colors.white),
                label: Text(
                  user == null ? "Login" : "Logout",
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (user == null) {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  } else {
                    await MyAppFunctions.showErrorOrWarningDialog(
                      context: context,
                      subtitle: "Are you sure you want to signout?",
                      isError: false,
                      fct: () async {
                        await FirebaseAuth.instance.signOut();
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(
                            // ignore: use_build_context_synchronously
                            context,
                            LoginScreen.routeName);
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubtitleTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
