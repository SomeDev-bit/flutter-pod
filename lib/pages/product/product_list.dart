import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/providers/user_state_provider.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.exit_to_app),
              onTap: (){
                ref.read(userStateProvider.notifier).logOutUser();
              },
              title: Text('Sign Out'),)

          ],
        ),
      ),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}