import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/constants/apis.dart';
import 'package:fluttermangsir/providers/cart/cart_provider.dart';
import 'package:fluttermangsir/providers/product/product_provider.dart';
import 'package:fluttermangsir/routes/route_enum.dart';
import 'package:go_router/go_router.dart';


class ProductDetail extends ConsumerWidget {
  final String id;
  const ProductDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getProductProvider( id: id));

    return Scaffold(
      appBar: AppBar(),
      body: state.when(
          data: (data){
            return Column(
              children: [
                CachedNetworkImage(
                  height: 200,
                  imageUrl: '$base/${data.image}',
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(data.title),
                Text(data.description),
                Text(data.price.toString()),
                Text(data.category),
                const SizedBox(height: 20,),

                ElevatedButton(onPressed: (){
                   ref.read(cartListProvider.notifier).setCart(data);
                   context.pushNamed(AppRoute.cart.name);
                }, child: Text('Add To Cart'))


              ],
            );
          }, error: (err, st) => Text('$err'),
          loading: () => const Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}