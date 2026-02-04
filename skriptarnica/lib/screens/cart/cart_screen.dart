import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/providers/cart_provider.dart';
import 'package:skriptarnica/providers/products_provider.dart';
import 'package:skriptarnica/screens/cart/bottom_checkout.dart';
import 'package:skriptarnica/screens/cart/cart_widget.dart';
import 'package:skriptarnica/services/assets_manager.dart';
import 'package:skriptarnica/services/my_app_functions.dart';
import 'package:skriptarnica/widgets/empty_bag.dart';
import 'package:skriptarnica/widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    //final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartitems.isEmpty
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
              title: TitelesTextWidget(
                  label: "Cart (${cartProvider.getCartitems.length})"),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppFunctions.showErrorOrWarningDialog(
                      isError: false,
                      context: context,
                      subtitle: "Clear cart?",
                      fct: () {
                        cartProvider.clearLocalCart();
                      },
                    );
                  },
                  icon: const Icon(Icons.delete_forever_rounded),
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cartProvider.getCartitems.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartProvider.getCartitems.values
                                .toList()[index],
                            child: const CartWidget());
                      }),
                ),
                const SizedBox(
                  height: kBottomNavigationBarHeight + 10,
                ),
              ],
            ),
          );
  }
}
