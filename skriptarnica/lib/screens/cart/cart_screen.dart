import 'package:flutter/material.dart';
import 'package:skriptarnica/screens/cart/bottom_checkout.dart';
import 'package:skriptarnica/screens/cart/cart_widget.dart';
import 'package:skriptarnica/services/assets_manager.dart';
import 'package:skriptarnica/widgets/empty_bag.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: "${AssetsManager.imagePath}/bag/checkout.png",
              title: "Your Cart is Empty",
              subtitle:
                  "Looks like you haven't added \n anything to your cart yet.",
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            bottomSheet: const CartBottomSheetWidget(),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("${AssetsManager.imagePath}/logo.png"),
              ),
              title: const Text("FTN Script Store"),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_forever_rounded),
                )
              ],
            ),
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const CartWidget();
                }),
          );
  }
}
