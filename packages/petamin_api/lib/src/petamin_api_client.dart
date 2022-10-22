import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:petamin_api/petamin_api.dart';
import 'package:petamin_api/src/networking/network_service.dart';
import 'package:petamin_api/src/static/static_values.dart';

import 'networking/network_enums.dart';
import 'networking/network_helper.dart';

class PetaminApiClient {
  static const _baseUrl = StaticValues.baseUrl;
  // static const _baseSocketIoUrl = StaticValues.baseSocketIoUrl;

  /// Get [User] profile `/profile`.
  Future<User> getUserProfile({required String accessToken}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        baseUrl: _baseUrl,
        endPoint: '/profile',
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => User.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  /// Update [User] profile `PATCH /profile`.
  Future<User> updateUserProfile({
    required String accessToken,
    String? address,
    String? phone,
    String? bio,
    String? birthday,
    File? avatar,
    String? name,
  }) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.patch,
        baseUrl: _baseUrl,
        endPoint: '/profile',
        body: {
          'address': address,
          'phone': phone,
          'bio': bio,
          'birthday': birthday,
          'name': name,
        },
        files: {'avatar': avatar},
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => User.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  /// Login `/auth/login`.
  Future<Auth> login({required String email, required String password}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.post,
        baseUrl: _baseUrl,
        endPoint: '/auth/login',
        body: {'email': email, 'password': password});
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

  /// Register `/auth/register`.
  Future<Auth> register(
      {required String name,
      required String email,
      required String password}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.post,
        baseUrl: _baseUrl,
        endPoint: '/auth/register',
        body: {'name': name, 'email': email, 'password': password});
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

  /// Register `/auth/logout`.
  Future<void> logout({required String accessToken}) async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.post,
      baseUrl: _baseUrl,
      endPoint: '/auth/logout',
      accessToken: accessToken,
    );
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => null,
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }
}