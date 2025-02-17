import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/routes/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';


@riverpod
Box box (Ref ref) {
  throw UnimplementedError();
}

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final bx = await Hive.openBox('box');

  runApp( ProviderScope(
      overrides: [
        boxProvider.overrideWithValue(bx),
      ],
      child: const  Home()));
}

//provider, notifier provider, future provider, async notifier provider, stream provider

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
