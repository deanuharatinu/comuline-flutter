import 'package:chopper/chopper.dart';
import 'package:comuline/data/remote/api_service.dart';

class ApiServiceFactory {
  ApiServiceFactory._();

  static ApiService create({
    required ChopperClient client,
  }) {
    return ApiService.create(client);
  }
}
