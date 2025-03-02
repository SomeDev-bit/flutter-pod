import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/sample_dispose/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_provider.g.dart';

@riverpod
Future<List<Todo>> getTodos (Ref ref) async {
  ref.keepAlive();
  ref.onDispose((){
    print('dispose');
  });
    try{
      final dio = Dio();
      final response = await dio.get('https://67831c8c8b6c7a1316f382b3.mockapi.io/todos');
      return (response.data as List).map((e) => Todo.fromJson(e)).toList();
    }catch(e){
      throw '$e';
    }
}
