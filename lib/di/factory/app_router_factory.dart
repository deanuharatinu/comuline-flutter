import 'package:comuline/router/router.dart';

class AppRouterFactory {
  static final AppRouterFactory _instance = AppRouterFactory._();
  factory AppRouterFactory() => _instance;

  AppRouterFactory._();

  static AppRouter? _appRouter;

  AppRouter get appRouter {
    if (_appRouter != null) return _appRouter!;
    _appRouter = AppRouter();
    return _appRouter!;
  }
}
