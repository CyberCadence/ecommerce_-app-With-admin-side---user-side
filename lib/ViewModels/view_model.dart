import 'package:ecomm/models/ProductModel.dart';
import 'package:flutter/foundation.dart';

class BagViewModel extends ChangeNotifier {
  final List<Product> productsBag;

  BagViewModel() : productsBag = [];

  void addPRoduct(Product product) {
    productsBag.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    productsBag.remove(product);
    notifyListeners();
  }

  void removeallProducts() {
    productsBag.clear();
    notifyListeners();
  }

  int get totalProducts {
    return productsBag.length;
  }

  double get gettotalprice => productsBag.fold(0, (total, product) {
        return total + product.price;
      });

  bool get isEmptyBag {
    return productsBag.isNotEmpty;
  }
}
