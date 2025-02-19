import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/models/product.dart';
import 'package:fluttermangsir/services/product_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
Future<List<Product>> getProducts (Ref ref) async {
  return ref.read(productServiceProvider).getProducts();
}
