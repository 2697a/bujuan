import 'package:dio/dio.dart';

class Https {
  Https._inner();

  static Dio? _dio;
  static DioProxy? _dioProxy;

  static Map<String, String> optHeader = {};

  static Dio get dio =>
      _dio ??= Dio(BaseOptions(connectTimeout: 5000, headers: optHeader));

  static DioProxy get dioProxy => _dioProxy ??= DioProxy();
}

class DioMetaData {
  late Uri uri;
  dynamic data;
  Options? options;

  Error? error;

  DioMetaData(this.uri, {this.data, this.options});

  DioMetaData.error(this.error);
}

class DioProxy {
  Future<Response<T>> postUri<T>(
    DioMetaData metaData, {
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    var error = metaData.error;
    if (error != null) {
      return Future.error(error);
    }
    return Https.dio
        .postUri(metaData.uri, data: metaData.data, options: metaData.options);
  }

  Future<Response<T>> getUri<T>(
    DioMetaData metaData, {
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    var error = metaData.error;
    if (error != null) {
      return Future.error(error);
    }
    return Https.dio.getUri(metaData.uri, options: metaData.options);
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return Https.dio.get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }
}
