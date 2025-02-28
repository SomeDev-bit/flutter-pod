import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/constants/apis.dart';
import 'package:fluttermangsir/pages/product/widgets/drawer_widget.dart';
import 'package:fluttermangsir/providers/product/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttermangsir/providers/user_state_provider.dart';
import 'package:fluttermangsir/routes/route_enum.dart';
import 'package:go_router/go_router.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(getProductsProvider);
    final user = ref.watch(userStateProvider);
    print(user.userId);
    print(user.token);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(onPressed: (){
            context.pushNamed(AppRoute.cart.name);
          }, icon: Icon(Icons.shopping_bag_outlined))
        ],
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: productState.when(
            skipLoadingOnRefresh: false,
            data: (data){
              return RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(Duration(seconds: 1));
                  ref.invalidate(getProductsProvider);
                },
                child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      crossAxisSpacing: 7,
                        mainAxisSpacing: 10
                    ),
                    itemBuilder: (c, index) {
                      final product = data[index];
                      return InkWell(
                        onTap: (){
                          context.pushNamed(AppRoute.productDetail.name, extra: product.id);
                        },
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.only(left: 10),
                              color: Colors.black.withOpacity(0.5),
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Text(product.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),)),
                                Expanded(child: Text('Price:- ${product.price}', style: TextStyle(color: Colors.white),))
                              ],
                            ),
                          ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              errorWidget: (c,s,d) => Image.asset('assets/images/chris-lawton-zvKx6ixUhWQ-unsplash.jpg'),
                            imageUrl:'$base/${product.image}',
                        ),
                        ),
                      );
                    }
                ),
              );
            },
            error: (err, st) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator())),
      )
    );
  }
}