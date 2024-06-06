import 'package:chopper/chopper.dart';

class ChopperFactory {
  static final ChopperFactory _instance = ChopperFactory._();
  factory ChopperFactory({
    Converter? converter,
    ErrorConverter? errorConverter,
    required List<Interceptor> interceptors,
  }) {
    _instance._converter = converter;
    _instance._errorConverter = errorConverter;
    _instance._interceptors = interceptors;

    return _instance;
  }

  ChopperFactory._();

  static ChopperClient? _client;
  Converter? _converter;
  ErrorConverter? _errorConverter;
  List<Interceptor>? _interceptors;

  ChopperClient get client {
    if (_client != null) return _client!;
    _client = _initChopperClient();
    return _client!;
  }

  ChopperClient _initChopperClient() {
    final chopper = ChopperClient(
      converter: _converter,
      errorConverter: _errorConverter,
      interceptors: _interceptors ?? [],
    );

    return chopper;
  }
}
