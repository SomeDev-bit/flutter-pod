import 'package:fluttermangsir/services/auth/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_provider.g.dart';


@riverpod
class SignUp extends _$SignUp {
  @override
  FutureOr<void> build()  {

  }

  Future<void> registerUser (Map<String, dynamic> map) async{
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(authServiceProvider).registerUser(map));
  }

}
