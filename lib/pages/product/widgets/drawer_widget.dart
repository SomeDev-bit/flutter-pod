import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/providers/user_state_provider.dart';
import 'package:fluttermangsir/routes/route_enum.dart';
import 'package:go_router/go_router.dart';


class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateProvider);
    return Drawer(
      child: ListView(
        children: [
          if(userState.role == 'admin')  ListTile(
            leading: Icon(Icons.list),
            onTap: (){
              //context.pop();
              context.pushNamed(AppRoute.adminPro.name);
            },
            title: Text('Products List'),),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            onTap: (){
              ref.read(userStateProvider.notifier).logOutUser();
            },
            title: Text('Sign Out'),)

        ],
      ),
    );
  }
}