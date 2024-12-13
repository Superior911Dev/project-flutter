import 'package:appstore/common/values/constant.dart';
import 'package:appstore/global.dart';
import 'package:dio/dio.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() {
    return _instance;
  }

  late Dio dio;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: AppConstants.SERVER_API_URL,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {},
        contentType: "application/json: charset=urf-8",
        responseType: ResponseType.json);
    dio = Dio(options);
  }

  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authoriztion = getAuthorizationHeader();
    if (authoriztion != null) {
      requestOptions.headers!.addAll(authoriztion);
    }
    var response = await dio.post(path,
        data: data, queryParameters: queryParameters, options: requestOptions);
    // print("my pesponse is ${response.toString()}");
    // print("my status code is ${response.statusCode}");
    return response.data;
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }
}
