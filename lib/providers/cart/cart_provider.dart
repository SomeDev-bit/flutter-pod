import 'package:fluttermangsir/main.dart';
import 'package:fluttermangsir/models/cart.dart';
import 'package:fluttermangsir/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';


@riverpod
class CartList extends _$CartList {
  @override
  List<Cart> build() {
    return ref.watch(cartsProvider);
  }

  void setCart(Product product){
     final isExist = state.firstWhere((cart) => cart.id == product.id, orElse: () => Cart.empty());
     if(isExist.id == 'no-id'){
       final newCart = Cart(qty: 1,
           title: product.title, image: product.image, price: product.price, id: product.id);
       state = [...state, newCart];
       Hive.box<Cart>('carts').add(newCart);
     }else{

       state = [
         for(final cart in state) cart.id == isExist.id ? isExist.copyWith(isExist.qty + 1): cart
       ];

       isExist.qty = isExist.qty + 1;
       isExist.save();
     }
  }





}
