import 'package:e_commerce_store/presentation/screens/product_screen/product_screen.dart';
import 'package:e_commerce_store/presentation/screens/vpn_not_allowed.dart';
import 'package:go_router/go_router.dart';

final appRouter = AppRouter();

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductScreen(),
      ),
      GoRoute(
        path: '/vpn_not_allowed',
        builder: (context, state) => const VpnNotAllowed(),
      ),
    ]);
  }
}
