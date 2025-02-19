import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/constants/apis.dart';
import 'package:fluttermangsir/exception/api_error.dart';
import 'package:fluttermangsir/models/product.dart';
import 'package:fluttermangsir/shared/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_service.g.dart';



class ProductService{
  final Dio dio;
  ProductService(this.dio);

  Future<List<Product>> getProducts() async{
    try{
      final response = await dio.get(products);
      return (response.data as List).map((e) => Product.fromJson(e)).toList();
    }on DioException catch(err){
      throw ApiError.errorCheck(err).errMessage;
    }
  }


}


@riverpod
ProductService productService(Ref ref) {
  return ProductService(ref.watch(clientProvider));
}