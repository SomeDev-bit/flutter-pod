import 'package:fluttermangsir/models/product.dart';
import 'package:fluttermangsir/pages/admin/admin_products.dart';
import 'package:fluttermangsir/pages/admin/product_add_form.dart';
import 'package:fluttermangsir/pages/admin/product_edit_form.dart';
import 'package:fluttermangsir/pages/auth/login.dart';
import 'package:fluttermangsir/pages/auth/register.dart';
import 'package:fluttermangsir/pages/cart/cart_page.dart';
import 'package:fluttermangsir/pages/product/product_detail.dart';
import 'package:fluttermangsir/pages/product/product_list.dart';
import 'package:fluttermangsir/providers/user_state_provider.dart';
import 'package:fluttermangsir/routes/route_enum.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/order/order_history.dart';

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
            },
          routes: [
            GoRoute(
                path: 'adminPro',
                name: AppRoute.adminPro.name,
                pageBuilder: (context, state){
                  return NoTransitionPage(child: const AdminProducts());
                },
                routes: [
                  GoRoute(
                    path: 'productAdd',
                    name: AppRoute.productAdd.name,
                    pageBuilder: (context, state){
                      return NoTransitionPage(child: const ProductAddForm());
                    },
                  ),
                  GoRoute(
                    path: 'productEdit',
                    name: AppRoute.productEdit.name,
                    pageBuilder: (context, state){
                      final product = state.extra as Product;
                      return NoTransitionPage(child: ProductEditForm(product: product));
                    },
                  )
                ]
            ),
            GoRoute(
              path: 'cart',
              name: AppRoute.cart.name,
              pageBuilder: (context, state){
                return NoTransitionPage(child: const CartPage());
              },
            ),
            GoRoute(
                path: 'productDetail',
              name: AppRoute.productDetail.name,
              pageBuilder: (context, state){
                final productId = state.extra as String;
                return NoTransitionPage(child: ProductDetail(id: productId));
              }, 
              
            ),
            GoRoute(
                path: 'history',
              name: AppRoute.history.name,
              pageBuilder: (context, state){
                return NoTransitionPage(child: const OrderHistory());
              },
            )
          ]
        ),
        GoRoute(
            path: '/register',
            name: AppRoute.register.name,
            pageBuilder: (context, state){
              return NoTransitionPage(child: const Register());
            }
        ),

      ]
  );
}
