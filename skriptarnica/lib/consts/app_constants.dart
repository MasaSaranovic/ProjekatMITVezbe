import 'package:skriptarnica/models/categories_model.dart';
import 'package:skriptarnica/services/assets_manager.dart';

class AppConstants {
  static const String imageUrl =
      'https://m.media-amazon.com/images/I/71nj3JM-igL._AC_UF894,1000_QL80_.jpg';

  static List<String> bannersImages = [
    "${AssetsManager.imagePath}/banners/skriptarnica.jpg",
    "${AssetsManager.imagePath}/banners/skriptarnica2.jpg",
  ];

  static List<CategoriesModel> categoriesList = [
    CategoriesModel(
        id: "${AssetsManager.imagePath}/categories/book.png",
        name: "Books",
        image: "${AssetsManager.imagePath}/categories/book.png"),
    CategoriesModel(
        id: "${AssetsManager.imagePath}/categories/stationery.png",
        name: "Stationery",
        image: "${AssetsManager.imagePath}/categories/stationery.png"),
    CategoriesModel(
        id: "${AssetsManager.imagePath}/categories/t-shirt.png",
        name: "Merch",
        image: "${AssetsManager.imagePath}/categories/t-shirt.png"),
  ];
}
