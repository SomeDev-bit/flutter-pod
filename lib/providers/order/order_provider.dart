import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/models/cart_item.dart';
import 'package:fluttermangsir/models/order_item.dart';
import 'package:fluttermangsir/services/order/order_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_provider.g.dart';


@riverpod
class OrderMutation extends _$OrderMutation {
  @override
  FutureOr<void> build(){

  }

  Future<void> createOrder(List<CartItem> carts, int totalAmount) async{
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(orderServiceProvider).createOrder(carts, totalAmount));
  }

}


@riverpod
Future<List<OrderItem>> orderItems (Ref ref, {required String userId}) async {
  return ref.read(orderServiceProvider).getUserOrders(userId);
}