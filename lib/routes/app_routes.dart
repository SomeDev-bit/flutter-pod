import 'package:fluttermangsir/pages/admin/admin_products.dart';
import 'package:fluttermangsir/pages/admin/product_add_form.dart';
import 'package:fluttermangsir/pages/auth/login.dart';
import 'package:fluttermangsir/pages/auth/register.dart';
import 'package:fluttermangsir/pages/product/product_list.dart';
import 'package:fluttermangsir/providers/user_state_provider.dart';
import 'package:fluttermangsir/routes/route_enum.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_routes.g.dart';


@riverpod
GoRouter router(Ref ref) {
  final userState = ref.watch(userStateProvider);
  return GoRouter(
    initialLocation: '/',
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state){
              return userState.token == 'no-token' ? Login(): const ProductList();
            }
        ),
        GoRoute(
            path: '/register',
            name: AppRoute.register.name,
            pageBuilder: (context, state){
              return NoTransitionPage(child: const Register());
            }
        ),
        GoRoute(
            path: '/adminPro',
            name: AppRoute.adminPro.name,
            pageBuilder: (context, state){
              return NoTransitionPage(child: const AdminProducts());
            },
          routes: [
            GoRoute(
                path: '/productAdd',
              name: AppRoute.productAdd.name,
              pageBuilder: (context, state){
                return NoTransitionPage(child: const ProductAddForm());
              },
            )
          ]
        )
      ]
  );
}
