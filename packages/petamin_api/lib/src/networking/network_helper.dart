import 'dart:convert';
import 'package:http/http.dart' as http;
import 'network_enums.dart';
import 'network_typedef.dart';

class NetworkHelper {
  const NetworkHelper._();

  static String appendUrlParams(
      String baseUrl, String endPoint, Map<String, String>? queryParameters) {
    if (baseUrl.isEmpty) return baseUrl;
    if (queryParameters == null || queryParameters.isEmpty) {
      if (endPoint == null || endPoint.isEmpty) {
        return baseUrl;
      } else {
        return "$baseUrl$endPoint";
      }
    }
    final StringBuffer stringBuffer = StringBuffer("$baseUrl$endPoint?");
    queryParameters.forEach((key, value) {
      if (value.trim() == '') return;
      if (value.contains(' ')) throw Exception('Invalid Input Exception');
      stringBuffer.write('$key=$value&');
    });
    final result = stringBuffer.toString();
    return result.substring(0, result.length - 1);
  }

  static bool _isValidResponse(json) {
    return json != null;
    //&&
    //     json['status'] != null &&
    //     json['status'] == 'ok' &&
    //     json['articles'] != null;
  }

  static R filterResponse<R>(
      {required NetworkCallBack callBack,
      required http.Response? response,
      required NetworkOnFailureCallBackWithMessage onFailureCallBackWithMessage,
      CallBackParameterName parameterName = CallBackParameterName.all}) {
    try {
      if (response == null || response.body.isEmpty) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.responseEmpty, 'empty response');
      }

      var json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (_isValidResponse(json)) {
          return callBack(parameterName.getJson(json));
        }
      } else if (response.statusCode == 1708) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.socket, 'socket');
      }
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.didNotSucceed, 'unknown');
    } catch (e) {
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.exception, 'Exception $e');
    }
  }
}
