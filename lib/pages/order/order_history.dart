import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/providers/order/order_provider.dart';
import 'package:fluttermangsir/providers/user_state_provider.dart';

class OrderHistory extends ConsumerWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    final userOrderState = ref.watch(orderItemsProvider(userId: user.userId));
    return Scaffold(
      appBar: AppBar(),
      body: userOrderState.when(
          data: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(data[index].id.toString()),
            ),
          ),
          error: (err, st) => Text('$err'),
          loading: () => const Center(child: CircularProgressIndicator(),),
      ) ,
    );
  }
}