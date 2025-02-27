import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/constants/apis.dart';
import 'package:fluttermangsir/exception/api_error.dart';
import 'package:fluttermangsir/models/cart_item.dart';
import 'package:fluttermangsir/shared/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';



part 'order_service.g.dart';


class OrderService{
  final Dio dio;
  OrderService(this.dio);

  Future<void> createOrder(List<CartItem> carts, int totalAmount) async{
    try{

      await dio.post(orders, data: {
        'totalAmount': totalAmount,
        'products': carts.map((element) => element.toMap()).toList()
      });

    }on DioException catch(err){
      throw ApiError.errorCheck(err).errMessage;
    }
  }


  Future getUserOrders() async{
    try{

    }on DioException catch(err){
      throw ApiError.errorCheck(err).errMessage;
    }
  }


  Future getOrders() async{
    try{

    }on DioException catch(err){
      throw ApiError.errorCheck(err).errMessage;
    }
  }



}



@riverpod
OrderService orderService(Ref ref) {
  return OrderService(ref.watch(clientProvider));
}