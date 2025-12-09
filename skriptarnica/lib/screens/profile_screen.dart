import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/consts/app_colors.dart';
import 'package:skriptarnica/providers/theme_provider.dart';
import 'package:skriptarnica/services/assets_manager.dart';
import 'package:skriptarnica/widgets/subtitle_text.dart';
import 'package:skriptarnica/widgets/title_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Visibility(
            visible: false,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: TitelesTextWidget(
                  label: "Please login to have unlimited access"),
            ),
          ),
          Visibility(
            visible: true,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
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
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527_1280.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitelesTextWidget(label: "Masa Saranovic"),
                      SubtitleTextWidget(label: "masa.saranovic@uns.ac.rs")
                    ],
                  )
                ],
              ),
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
                CustomListTile(
                  imagePath: "${AssetsManager.imagePath}/bag/checkout.png",
                  text: "All Orders",
                  function: () {},
                ),
                CustomListTile(
                  imagePath: "${AssetsManager.imagePath}/bag/wishlist.png",
                  text: "Wishlist",
                  function: () {},
                ),
                CustomListTile(
                  imagePath: "${AssetsManager.imagePath}/profile/repeat.png",
                  text: "Viewed Recently",
                  function: () {},
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
              onPressed: () {},
              icon: const Icon(Icons.login, color: Colors.white),
              label: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
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
