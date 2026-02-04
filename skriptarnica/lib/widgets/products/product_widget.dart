import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/consts/app_colors.dart';
import 'package:skriptarnica/providers/cart_provider.dart';
import 'package:skriptarnica/providers/products_provider.dart';
import 'package:skriptarnica/providers/viewed_recently_provider.dart';
import 'package:skriptarnica/screens/inner_screen/product_details.dart';
import 'package:skriptarnica/widgets/products/heart_btn.dart';
import 'package:skriptarnica/widgets/subtitle_text.dart';
import 'package:skriptarnica/widgets/title_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.productId});

  //final String? image, title, price;

  final String productId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    //final productModelProvider = Provider.of<ProductModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productsProvider.findByProductId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(0.0),
            child: GestureDetector(
              onTap: () async {
                viewedProdProvider.addOrRemoveFromViewedProd(
                  productId: getCurrProduct.productId,
                );
                Navigator.pushNamed(
                  context,
                  ProductDetailsScreen.routName,
                  arguments: widget.productId,
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FancyShimmerImage(
                      //imageUrl: widget.image ?? AppConstants.imageUrl,
                      imageUrl: getCurrProduct.productImage,
                      height: size.height * 0.22,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TitelesTextWidget(
                            //label: widget.title ?? "Title " * 10,
                            label: getCurrProduct.productTitle,
                            fontSize: 18,
                            maxLines: 2,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: HeartButtonWidget(
                            productId: getCurrProduct.productId,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: SubtitleTextWidget(
                            //label: "${widget.price} RSD" ?? "1200 RSD",
                            label: "${getCurrProduct.productPrice}  RSD",
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkPrimary,
                          ),
                        ),
                        Flexible(
                          child: Material(
                            borderRadius: BorderRadius.circular(12.0),
                            color: AppColors.lightPrimary,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                if (cartProvider.isProdinCart(
                                    productId: getCurrProduct.productId)) {
                                  return;
                                }
                                cartProvider.addProductToCart(
                                  productId: getCurrProduct.productId,
                                );
                              },
                              splashColor: Colors.blueGrey,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  cartProvider.isProdinCart(
                                          productId: getCurrProduct.productId)
                                      ? Icons.check
                                      : Icons.add_shopping_cart_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          );
  }
}
