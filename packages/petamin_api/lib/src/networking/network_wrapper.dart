import 'package:flutter/cupertino.dart';
import 'package:petamin_api/petamin_api.dart';

import '../static/static_values.dart';
import 'network_enums.dart';
import 'network_helper.dart';
import 'network_service.dart';

class NetworkWrapper {
  const NetworkWrapper._();
  static const _baseUrl = StaticValues.baseUrl;

  static Future<R> post<R>(
      {required String endPoint, required Map<String, dynamic> body}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.post,
        baseUrl: _baseUrl,
        endPoint: endPoint,
        body: body);
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => Auth.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  static Future<R> get<R>({required String endPoint, required String accessToken}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        baseUrl: _baseUrl,
        endPoint: endPoint,
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => Auth.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  static Future<R> patch<R>(
      {required String endPoint, required Map<String, dynamic> body}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.patch,
        baseUrl: _baseUrl,
        endPoint: endPoint,
        accessToken: 'token');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => Auth.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  static Future<R> put<R>(
      {required String endPoint, required Map<String, dynamic> body}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.put,
        baseUrl: _baseUrl,
        endPoint: endPoint,
        accessToken: 'token');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => Auth.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }
}
