import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'validators.g.dart';


@riverpod
class PassShow extends _$PassShow {
  @override
  bool build({required int id}) {
    return  true;
  }

  void toggle(){
    state = !state;
  }
}


@riverpod
class ValidateMode extends _$ValidateMode {
  @override
  AutovalidateMode build({required int id}) {
    return AutovalidateMode.disabled;
  }

  void change(){
    state = AutovalidateMode.onUserInteraction;
  }
}
