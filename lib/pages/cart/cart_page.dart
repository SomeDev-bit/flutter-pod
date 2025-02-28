import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/common_widgets/toast_show.dart';
import 'package:fluttermangsir/providers/cart/cart_provider.dart';


class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carts = ref.watch(cartListProvider);
    final totalAmount = ref.watch(cartListProvider.notifier).totalAmount;
    final cartState = ref.watch(cartMutationProvider);

    ref.listen(cartMutationProvider, (prev, next) {
      next.maybeWhen(
          data: (d) => showToast(context, 'successfully order placed'),
          error: (err,st) => showToast(context, '$err'),
          orElse: () => null
      );
    });


    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: carts.isEmpty ? Center(child: Text('Cart is Empty'),) : Stack(
          children: [
            ListView.separated(
              separatorBuilder: (c, i) => Divider(),
              itemCount: carts.length,
              itemBuilder: (c, index) => Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListTile(
                      title: Text(carts[index].title),
                      subtitle: Text('Price: ${carts[index].price}'),
                      trailing: SizedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: (){
                              ref.read(cartListProvider.notifier).singleRemove(carts[index]);
                            }, icon: Icon(Icons.remove)),
                            Text('${carts[index].qty}', style: TextStyle(fontSize: 16),),
                            IconButton(onPressed: (){
                              ref.read(cartListProvider.notifier).singleAdd(carts[index]);
                            }, icon: Icon(Icons.add)),
                          ],
                        ) ,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                      top: 0,
                      child: IconButton(onPressed: (){
                        ref.read(cartListProvider.notifier).removeCart(carts[index]);
                      }, icon: Icon(Icons.close)))
                ],
              ),
            ),
            Positioned(
              bottom: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Text('Total Amount: - '),

                        Text('$totalAmount'),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(360, 40)
                        ),
                        onPressed: (){
                          ref.read(cartMutationProvider.notifier).createOrder(carts, totalAmount);
                        }, child: cartState.isLoading ? Center(child: CircularProgressIndicator()) : Text('Check Out')),
                  ],
                ) )
          ],
        ),
      ),
    );
  }
}