import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/models/cart.dart';
import 'package:fluttermangsir/routes/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

//provider, notifier provider, future provider, async notifier provider, stream provider

@riverpod
Box box (Ref ref) {
  throw UnimplementedError();
}

@riverpod
List<Cart> carts(Ref ref) {
  return  [];
}

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartAdapter());
  final bx = await Hive.openBox('box');
  final cartBx = await Hive.openBox<Cart>('carts');

  runApp( ProviderScope(
      overrides: [
        boxProvider.overrideWithValue(bx),
       cartsProvider.overrideWithValue(cartBx.values.toList())
      ],
      child: const  Home()));
}



class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final goRouter = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
