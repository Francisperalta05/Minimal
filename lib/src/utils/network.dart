import 'package:dio/dio.dart';

import '../config/enviroments.dart';
import '../preferences/preferences.dart';

class MyDioClient {
  static Dio get getClient {
    final Dio dio = _dioClient();
    dio.options.validateStatus = (status) => status! < 500;
    dio.interceptors.add(_Interceptor(dio));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }

  static Dio _dioClient() {
    String apiName = EnvConfig.configs[EnvEnum.baseUrl]!;
    Dio dio = Dio();
    dio.options.baseUrl = apiName;
    dio.options.connectTimeout = const Duration(minutes: 1);
    dio.options.receiveTimeout = const Duration(minutes: 1);
    dio.options.followRedirects = false;
    return dio;
  }
}

class _Interceptor extends InterceptorsWrapper {
  final Dio dio;

  _Interceptor(this.dio);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Authorization"] = "Bearer ${preferences.uToken}";

    super.onRequest(options, handler);
  }
}
