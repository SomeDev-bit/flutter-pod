import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/constants/apis.dart';
import 'package:fluttermangsir/providers/user_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';


@riverpod
Dio client (Ref ref) {
  final user = ref.watch(userStateProvider);
  return Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {
      HttpHeaders.authorizationHeader: user.token
    }
  ));
}
