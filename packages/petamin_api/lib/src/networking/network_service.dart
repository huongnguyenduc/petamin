import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'network_helper.dart';

enum RequestType { get, put, post, delete, patch }

class NetworkService {
  const NetworkService._();

  static Map<String, String> _getHeaders(String accessToken) => {
        'Content-Type': 'application/json',
        accessToken.isNotEmpty ? 'Authorization' : '': 'Bearer $accessToken',
      };

  static Future<http.Response>? _createRequest({
    required RequestType requestType,
    required Uri uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    switch (requestType) {
      case RequestType.get:
        return http.get(
          uri,
          headers: headers,
        );
      case RequestType.put:
        return http.put(uri, headers: headers, body: jsonEncode(body));
      case RequestType.post:
        return http.post(uri, headers: headers, body: jsonEncode(body));
      case RequestType.delete:
        return http.delete(uri, headers: headers);
      case RequestType.patch:
        return http.patch(uri, headers: headers, body: jsonEncode(body));
      default:
        return null;
    }
  }

  static Future<http.Response?>? sendRequest({
    required RequestType requestType,
    required String baseUrl,
    String endPoint = '',
    String accessToken = '',
    Map<String, dynamic>? body,
    Map<String, String>? queryParam,
    Map<String, File?>? files,
  }) async {
    /// Remove null values from body
    if (body != null) {
      body.removeWhere((key, value) => value == null);
    }
    // Remove null values from files
    if (files != null) {
      files.removeWhere((key, value) => value == null);
    }
    try {
      final header = _getHeaders(accessToken);
      final url = NetworkHelper.appendUrlParams(baseUrl, endPoint, queryParam);

      if (files != null && files.isNotEmpty) {
        final request = http.MultipartRequest(
          requestType.toString().split('.').last,
          Uri.parse(url),
        );
        request.headers.addAll(header);
        request.fields.addAll(body as Map<String, String>? ?? {});
        request.files.addAll(
          files.entries.map(
            (e) => http.MultipartFile.fromBytes(
              e.key,
              e.value!.readAsBytesSync(),
              filename: e.value!.path.split('/').last,
            ),
          ),
        );
        return await request
            .send()
            .then((response) => http.Response.fromStream(response));
      } else {
        return await _createRequest(
          requestType: requestType,
          uri: Uri.parse(url),
          headers: header,
          body: body,
        );
      }
    } catch (e) {
      print('Error - $e');
      return null;
    }
  }
}
