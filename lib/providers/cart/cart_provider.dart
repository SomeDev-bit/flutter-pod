import 'package:fluttermangsir/main.dart';
import 'package:fluttermangsir/models/cart_item.dart';
import 'package:fluttermangsir/models/product.dart';
import 'package:fluttermangsir/services/order/order_service.dart';
import 'package:hive/hive.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
class CartList extends _$CartList {
  @override
  List<CartItem> build() {
    return ref.watch(cartsProvider);
  }

  void setCart(Product product) {
    final newCart = CartItem(
      qty: 1,
      title: product.title,
      image: product.image,
      price: product.price,
      id: product.id,
        description: product.description
    );
    if (state.isEmpty) {
      state.add(newCart);
      Hive.box<CartItem>('carts').add(newCart);
    } else {
      final isExist = state.firstWhere(
        (cart) => cart.id == product.id,
        orElse: () => CartItem(qty: 0, title: '', image: '', price: 0, id: '', description: ''),
      );
      if (isExist.id.isEmpty) {
        state.add(newCart);
        Hive.box<CartItem>('carts').add(newCart);
      } else {
        if(isExist.isInBox){
           singleAdd(isExist);
        }

      }
    }
  }

  void singleAdd(CartItem cartItem) {
    cartItem.qty = cartItem.qty + 1;
    cartItem.save();
    state = [
      for(final cart in state) cart.id == cartItem.id ? cartItem : cart
    ];

  }

  void singleRemove(CartItem cartItem) {
    if(cartItem.qty == 1) return;
    cartItem.qty = cartItem.qty - 1;
    cartItem.save();
    state = [
      for(final cart in state) cart.id == cartItem.id ? cartItem : cart
    ];
  }


  void removeCart(CartItem cartItem) {
    cartItem.delete();
    state.removeAt(state.indexOf(cartItem));
    state = [...state];
  }


  void clearCart() {
    Hive.box<CartItem>('carts').clear();
    state = [];
  }


  int get totalAmount => state.fold(0, (a, b) => a + b.qty * b.price);

}


@riverpod
class CartMutation extends _$CartMutation {
  @override
  FutureOr<void> build() {

  }

  Future<void> createOrder(List<CartItem> carts, int totalAmount) async{
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async{
      await ref.read(orderServiceProvider).createOrder(carts, totalAmount);
      ref.read(cartListProvider.notifier).clearCart();
    });
  }
}