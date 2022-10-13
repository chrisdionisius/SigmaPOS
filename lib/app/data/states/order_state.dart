import 'package:get/get.dart';
import 'package:sigma_pos/app/data/models/product.dart';

class OrderState {
  static RxList<Product> order = <Product>[].obs;
  static RxInt total = 0.obs;
  static RxInt change = 0.obs;

  static void addProduct(Product product) {
    if (order.contains(product)) {
      Product existingProduct = order[order.indexOf(product)];
      existingProduct.amount = existingProduct.amount! + 1;
      order[order.indexOf(product)] = existingProduct;
    } else {
      product.amount = 1;
      order.add(product);
    }
    addTotal(product);
  }

  static void removeProduct(Product product) {
    if (order.contains(product)) {
      Product existingProduct = order[order.indexOf(product)];
      if (existingProduct.amount! > 1) {
        existingProduct.amount = existingProduct.amount! - 1;
        order[order.indexOf(product)] = existingProduct;
      } else {
        order.remove(product);
      }
      removeTotal(product);
    }
  }

  static void clearOrder() {
    order.clear();
  }

  static addTotal(Product product) {
    total.value += product.price!;
  }

  static removeTotal(Product product) {
    total.value -= product.price!;
  }

  static void calculateChange(int amount) {
    change.value = amount - total.value;
  }
}
