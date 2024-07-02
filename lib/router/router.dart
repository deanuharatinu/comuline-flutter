import 'package:auto_route/auto_route.dart';
import 'package:comuline/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        // Entry Routes
        AutoRoute(path: '/main', page: HomeRoute.page, initial: true)
      ];
}
