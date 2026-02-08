import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/consts/app_colors.dart';
import 'package:skriptarnica/consts/app_constants.dart';
import 'package:skriptarnica/providers/products_provider.dart';
import 'package:skriptarnica/services/assets_manager.dart';
import 'package:skriptarnica/widgets/products/ctg_rounded_widget.dart';
import 'package:skriptarnica/widgets/products/latest_arrival.dart';
import 'package:skriptarnica/widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("${AssetsManager.imagePath}/logo.png"),
          ),
          title: const Text("FTN Script Store")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: size.height * 0.25,
                child: ClipRRect(
// borderRadius: BorderRadius.circular(50),
                  child: Swiper(
                    autoplay: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        AppConstants.bannersImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
// alignment: Alignment.center,
                      builder: DotSwiperPaginationBuilder(
                          activeColor: AppColors.darkPrimary,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: const TitelesTextWidget(label: "Latest arrival"),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productProvider.getProducts.length < 10
                          ? productProvider.getProducts.length
                          : 10,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: productProvider.getProducts[index],
                            child: const LatestArrivalProductsWidget());
                      }),
                ),
              ),
              const TitelesTextWidget(label: "Categories"),
              const SizedBox(
                height: 15.0,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children:
                    List.generate(AppConstants.categoriesList.length, (index) {
                  return CategoryRoundedWidget(
                    image: AppConstants.categoriesList[index].image,
                    name: AppConstants.categoriesList[index].name,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
