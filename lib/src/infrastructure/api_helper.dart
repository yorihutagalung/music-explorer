import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'dio_log_interceptor.dart';

class ApiHelper {
  static Future<void> checkConnectionAvailability(
      Connectivity connectivity) async {
    final currentStatus = await connectivity.checkConnectivity();
    if (currentStatus == ConnectivityResult.none) {
      throw Exception('No internet connection');
    }
  }

  static DioLogInterceptor logInterceptor = DioLogInterceptor(
    requestBody: true,
    request: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
  );

  static BaseOptions baseOption = BaseOptions(
    connectTimeout: 120000,
    receiveTimeout: 60000,
    sendTimeout: 60000,
    headers: null,
  );

  late Connectivity _connectivity;
  late Dio _dio;

  ApiHelper() {
    _dio = Dio(baseOption)..interceptors.add(logInterceptor);
    _connectivity = Connectivity();
  }

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    bool needAuthorization = true,
    String parameter = '',
  }) =>
      _defaultMethodCall(
        () async => _dio.get(
          path + parameter,
          queryParameters: queryParameters,
        ),
      );

  Future<dynamic> post({
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool needAuthorization = true,
    String? contentType,
    String parameter = '',
  }) =>
      _defaultMethodCall(
        () async => _dio.post(
          path + parameter,
          data: body,
          queryParameters: queryParameters,
        ),
      );

  Future<dynamic> delete({
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool needAuthorization = true,
    String? contentType,
    String parameter = '',
  }) =>
      _defaultMethodCall(
        () async => _dio.delete(
          path + parameter,
          data: body,
          queryParameters: queryParameters,
        ),
      );

  Future<dynamic> put({
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool needAuthorization = true,
    String? contentType,
    String parameter = '',
  }) =>
      _defaultMethodCall(
        () async => _dio.put(
          path + parameter,
          data: body,
          queryParameters: queryParameters,
        ),
      );

  Future<dynamic> patch({
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool needAuthorization = true,
    String? contentType,
    String parameter = '',
  }) =>
      _defaultMethodCall(
        () async => _dio.patch(
          path + parameter,
          data: body,
          queryParameters: queryParameters,
        ),
      );

  Future<dynamic> _defaultMethodCall(
      Future<Response> Function() methodCall) async {
    try {
      await checkConnectionAvailability(_connectivity);
      final Response response = await methodCall();
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
