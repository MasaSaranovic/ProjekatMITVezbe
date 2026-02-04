import 'package:flutter/material.dart';
import 'package:skriptarnica/models/product_model.dart';
import 'package:uuid/uuid.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> get getProducts {
    return products;
  }

  ProductModel? findByProductId(String productId) {
    if (products.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    return products.firstWhere((element) => element.productId == productId);
  }

  List<ProductModel> findByCategory({required String categoryName}) {
    List<ProductModel> categoryList = products
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return categoryList;
  }

  List<ProductModel> searchQuery(
      {required String searchText, required List<ProductModel> passedList}) {
    List<ProductModel> searchList = passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  List<ProductModel> products = [
// Books
    ProductModel(
//1
      productId: 'UUP',
      productTitle: "Uvod u programiranje",
      productPrice: "1200.00",
      productCategory: "Books",
      productDescription: "Description",
      productImage:
          "https://media.istockphoto.com/id/157482029/photo/stack-of-books.jpg?s=612x612&w=0&k=20&c=ZxSsWKNcVpEzrJ3_kxAUuhBCT3P_dfnmJ81JegPD8eE=",
      productQuantity: "10",
    ),
    ProductModel(
//2
      productId: 'UMPS',
      productTitle: "Uvod u mikroprocesorske sisteme",
      productPrice: "1200.00",
      productCategory: "Books",
      productDescription: "Description",
      productImage:
          "https://media.istockphoto.com/id/162833243/photo/blank-book.jpg?s=612x612&w=0&k=20&c=7xDB49s-hV2U87Wx6Kk9NhHbW6H-f0eb3wWSR5sqlEk=",
      productQuantity: "15",
    ),
// Stationery
    ProductModel(
//3
      productId: const Uuid().v4(),
      productTitle: "Marker",
      productPrice: "20.00",
      productCategory: "Stationery",
      productDescription: "Description",
      productImage:
          "https://media.istockphoto.com/id/183136428/photo/pink-highlighter-with-the-cap-off-on-white-background.jpg?s=612x612&w=0&k=20&c=u75MvVSdfu1EKlCOdAqFNRIUWck98jY6FMJlr42bVpg=",
      productQuantity: "200",
    ),
    ProductModel(
//4
      productId: const Uuid().v4(),
      productTitle: "Gumica",
      productPrice: "50.00",
      productCategory: "Stationery",
      productDescription: "Description",
      productImage:
          "https://media.istockphoto.com/id/96955913/photo/erased-line.jpg?s=612x612&w=0&k=20&c=IxC4-X1jLlXt_jPP_FRMuqw5qqgYuZVVZLV3pN__3VU=",
      productQuantity: "300",
    ),
// Merch
    ProductModel(
//5
      productId: const Uuid().v4(),
      productTitle: "Majica",
      productPrice: "1000.00",
      productCategory: "Merch",
      productDescription: "Description",
      productImage:
          "https://media.istockphoto.com/id/465485415/photo/blue-t-shirt-clipping-path.jpg?s=612x612&w=0&k=20&c=VzE9RWytBIg6wb47plb5kl08brIuzAnlN1B6W1Pd6tg=",
      productQuantity: "100",
    ),
    ProductModel(
//6
      productId: const Uuid().v4(),
      productTitle: "Ceger",
      productPrice: "1200.00",
      productCategory: "Merch",
      productDescription: "Description",
      productImage:
          "https://media.istockphoto.com/id/2219139040/photo/cotton-canvas-burlap-bag-with-drawstring-mock-up-isolated-zero-waste-concept-eco-sack-made.jpg?s=612x612&w=0&k=20&c=M_wKIgzEEOuagok_l8Fv9lJ2Fc-CwtofLxQshTfjUMQ=",
      productQuantity: "100",
    ),
  ];
}
