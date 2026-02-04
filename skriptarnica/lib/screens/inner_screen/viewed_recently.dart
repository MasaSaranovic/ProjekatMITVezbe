import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/providers/viewed_recently_provider.dart';
import 'package:skriptarnica/services/assets_manager.dart';
import 'package:skriptarnica/widgets/empty_bag.dart';
import 'package:skriptarnica/widgets/products/product_widget.dart';
import 'package:skriptarnica/widgets/title_text.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routName = "/ViewedRecentlyScreen";
  const ViewedRecentlyScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return viewedProdProvider.getViewedProds.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: "${AssetsManager.imagePath}/bag/checkout.png",
              title: "No viewed products yet",
              subtitle: "Looks like your history is empty.",
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "${AssetsManager.imagePath}/bag/checkout.png",
                ),
              ),
              title: TitelesTextWidget(
                  label:
                      "Viewed recently (${viewedProdProvider.getViewedProds.length})"),
              // actions: [
              //   IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.delete_forever_rounded,
              //     ),
              //   ),
              // ],
            ),
            body: DynamicHeightGridView(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productId: viewedProdProvider.getViewedProds.values
                        .toList()[index]
                        .productId,
                  ),
                );
              },
              itemCount: viewedProdProvider.getViewedProds.length,
              crossAxisCount: 2,
            ),
          );
  }
}
