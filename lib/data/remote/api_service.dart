import 'package:chopper/chopper.dart';

part "api_service.chopper.dart";

@ChopperApi(baseUrl: "https://www.api.comuline.com")
abstract class ApiService extends ChopperService {
  static ApiService create(ChopperClient? client) {
    return _$ApiService(client);
  }

  @Get(path: "v1/station/")
  Future<Response> getStations();

  @Get(path: "v1/schedule/{stationId}")
  Future<Response> getStationDetailById(@Path() String stationId);
}
