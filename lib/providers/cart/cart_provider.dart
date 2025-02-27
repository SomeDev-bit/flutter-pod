import 'package:fluttermangsir/main.dart';
import 'package:fluttermangsir/models/cart_item.dart';
import 'package:fluttermangsir/models/product.dart';


import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';


@riverpod
class CartList extends _$CartList {
  @override
  List<CartItem> build() {
    return ref.watch(cartsProvider);
  }


  void setCart (Product product){

  }


}
