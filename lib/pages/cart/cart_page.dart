import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/providers/cart/cart_provider.dart';


class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carts = ref.watch(cartListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: carts.isEmpty ? Center(child: Text('Cart is Empty'),) : Stack(
          children: [
            ListView.builder(
              itemCount: carts.length,
              itemBuilder: (c, index) => ListTile(
                title: Text(carts[index].title),
                subtitle: Text('Price: ${carts[index].price}'),
                trailing: SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){

                      }, icon: Icon(Icons.remove)),
                      Text('${carts[index].qty}', style: TextStyle(fontSize: 16),),
                      IconButton(onPressed: (){

                      }, icon: Icon(Icons.add)),
                    ],
                  ) ,
                ),
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

                       // Text('$totalAmount'),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(360, 40)
                        ),
                        onPressed: (){}, child: Text('Check Out')),
                  ],
                ) )
          ],
        ),
      ),
    );
  }
}