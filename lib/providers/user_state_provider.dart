import 'dart:convert';

import 'package:fluttermangsir/main.dart';
import 'package:fluttermangsir/models/user_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_state_provider.g.dart';

@riverpod
class UserState extends _$UserState {
  @override
  UserData build() {
    final user = ref.read(boxProvider).get('user');
    return  user == null ?   UserData.empty(): UserData.fromJson(jsonDecode(user));
  }

  void addUser (Map<String, dynamic> map){

    ref.read(boxProvider).put('user', jsonEncode(map));
    state = UserData.fromJson(map);
  }

  void logOutUser (){
    ref.read(boxProvider).delete('user');
    state = UserData.empty();
  }
}
