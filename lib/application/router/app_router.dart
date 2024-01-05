import 'package:e_commerce_store/presentation/screens/product_screen/product_screen.dart';
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
    ]);
  }
}
