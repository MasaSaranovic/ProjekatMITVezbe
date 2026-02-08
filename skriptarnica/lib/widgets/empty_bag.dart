import 'package:flutter/material.dart';
import 'package:skriptarnica/consts/app_colors.dart';
import 'package:skriptarnica/widgets/subtitle_text.dart';
import 'package:skriptarnica/widgets/title_text.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget(
      {super.key, this.imagePath, this.title, this.subtitle, this.buttonText});

  // ignore: prefer_typing_uninitialized_variables
  final imagePath, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 230,
        ),
        Image.asset(
          imagePath,
          width: double.infinity,
          height: size.height * 0.20,
        ),
        const SizedBox(
          height: 20,
        ),
        TitelesTextWidget(
          label: title,
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SubtitleTextWidget(
              label: subtitle,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: AppColors.darkPrimary),
          onPressed: () {},
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
