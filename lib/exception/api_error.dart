


import 'package:dio/dio.dart';

class ApiError{

  late String errMessage;


   ApiError.errorCheck(DioException error){
     switch(error.type){
       case DioExceptionType.connectionTimeout:
         errMessage = 'connection timeout !';
       case DioExceptionType.sendTimeout:
         errMessage = 'connection sendTimeout !';
       case DioExceptionType.receiveTimeout:
         errMessage = 'connection receiveTimeout !';
       case DioExceptionType.badCertificate:
         errMessage = 'bad certificate';

       case DioExceptionType.badResponse:

         switch(error.response?.statusCode){

           case 404:
             errMessage = 'Page Not Found';

           case 413:
             errMessage = 'File Size is too large';

           case 400:
             errMessage = '${error.response?.data}';

           case 401:
             errMessage = 'you are not authorized';

           case 405:
             errMessage = 'method not allowed';

           case 500:
             errMessage = 'server error';


         }






       case DioExceptionType.cancel:
         errMessage = 'Server Canceled it!';
       case DioExceptionType.connectionError:
         errMessage = 'please check your connection !';
       case DioExceptionType.unknown:
         errMessage = 'please check your connection !';
     }
  }


}