import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/common_widgets/toast_show.dart';
import 'package:fluttermangsir/providers/product/product_provider.dart';
import 'package:fluttermangsir/routes/route_enum.dart';
import 'package:go_router/go_router.dart';


class AdminProducts extends ConsumerWidget {
  const AdminProducts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final productState = ref.watch(getProductsProvider);
    final remState = ref.watch(productsStateProvider);

    ref.listen(productsStateProvider, (prev, next){
      next.maybeWhen(
          data: (d) {
            ref.invalidate(getProductsProvider);
            context.pop();
            showToast(context, 'successfully product remove');
          },
          error: (err,st) {
            context.pop();
            showToast(context, '$err');
          },
          orElse: () => null
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Products List'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(onPressed: (){
                  context.pushNamed(AppRoute.productAdd.name);
                }, child: Text('Create Product'))),
            const SizedBox(height: 10,),
            Expanded(
                child: productState.when(
                    data: (data){
                      return ListView.separated(
                          itemBuilder: (context, index){
                            final product = data[index];
                            return ListTile(
                              contentPadding: EdgeInsets.only(left: 10),
                              title: Text(product.title),
                              subtitle: Text('Rs. ${product.price}'),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                                    IconButton(onPressed: (){
                                      showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Text('Are you sure ?', style: TextStyle(fontSize: 18),),
                                          content: Text('You want to remove this product'),
                                          actions: [
                                            TextButton(
                                                onPressed: (){

                                              context.pop();
                                            }, child: Text('Cancel')),
                                            TextButton(
                                                onPressed: (){
                                                ref.read(productsStateProvider.notifier).removeProduct(id: product.id);
                                            },
                                                child:   Text('Confirm')
                                            ),
                                          ],
                                        );
                                      });
                                    }, icon: Icon(Icons.delete)),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (c, i) => Divider(),
                          itemCount: data.length
                      );
                    },
                    error: (err, st) => Center(child: Text('$err')),
                    loading: ()=> Center(child: CircularProgressIndicator())
                )
            )
          ],
        ),
      ),
    );
  }
}