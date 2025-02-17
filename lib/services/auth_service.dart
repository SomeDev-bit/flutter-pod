
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/constants/apis.dart';
import 'package:fluttermangsir/exception/api_error.dart';
import 'package:fluttermangsir/shared/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';


class AuthService{
final Dio dio;
AuthService(this.dio);

Future<Map<String, dynamic>> loginUser (Map<String, dynamic> map) async{
  try{
   final response = await dio.post(login, data: map);
   return response.data['data'];
  }on DioException catch(err){
    throw ApiError.errorCheck(err).errMessage;
  }
}

}


@riverpod
AuthService authService(Ref ref) {
  return AuthService(ref.watch(clientProvider));
}