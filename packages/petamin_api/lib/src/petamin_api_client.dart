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
    debugPrint('Response ${response?.statusCode} ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => User.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  Future<bool> checkToken({required String accessToken}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        baseUrl: _baseUrl,
        endPoint: '/profile',
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    if (response?.statusCode == 401) return false;
    return true;
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
    String? avatarUrl;

    if (avatar != null) {
      avatarUrl = await uploadFile(accessToken: accessToken, file: avatar);
    }
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
          'avatar': avatarUrl,
        },
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
    // return await httpPost(
    //     endPoint: '/auth/login',
    //     body: {'email': email, 'password': password});
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

  static Future<R> httpPost<R>(
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

  /// Register `/auth/register`.
  Future<Auth> register(
      {required String name,
      required String email,
      required String password}) async {
    return await httpPost(
        endPoint: '/auth/register',
        body: {'name': name, 'email': email, 'password': password});
    // final response = await NetworkService.sendRequest(
    //     requestType: RequestType.post,
    //     baseUrl: _baseUrl,
    //     endPoint: '/auth/register',
    //     body: {'name': name, 'email': email, 'password': password});
    // debugPrint('Response ${response?.body}');
    // return await NetworkHelper.filterResponse(
    //     response: response,
    //     parameterName: CallBackParameterName.all,
    //     callBack: (json) => Auth.fromJson(json),
    //     onFailureCallBackWithMessage: (errorType, msg) {
    //       debugPrint('Error type-$errorType - Message $msg');
    //       return null;
    //     });
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

  Future<List<PetRes>> getPets({required String accessToken}) async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      baseUrl: _baseUrl,
      endPoint: '/pets',
      accessToken: accessToken,
    );
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) =>
            (json as List<dynamic>).map((pet) => PetRes.fromJson(pet)).toList(),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  Future<PetRes> getPetDetail(
      {required String id, required String accessToken}) async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      baseUrl: _baseUrl,
      endPoint: '/pets/$id',
      accessToken: accessToken,
    );
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => PetRes.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  Future<bool> updatePet(
      {required PetRes pet, required String accessToken}) async {
    debugPrint("Update Pet API");
    final response = await NetworkService.sendRequest(
      requestType: RequestType.patch,
      baseUrl: _baseUrl,
      endPoint: '/pets/${pet.id}',
      body: pet.toJson(),
      accessToken: accessToken,
    );
    debugPrint('Response ${response?.body}');
    if (response!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> uploadFile({
    required String accessToken,
    File? file,
  }) async {
    debugPrint('Avatar UPloadFIle $file');
    final response = await NetworkService.sendRequest(
        requestType: RequestType.post,
        baseUrl: _baseUrl,
        endPoint: '/files/upload',
        files: {'file': file},
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => json['url'] as String,
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  // Get [Conversation] list `/users/conversations`.
  Future<List<ChatConversation>> getConversations(
      {required String accessToken}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        baseUrl: _baseUrl,
        endPoint: '/users/conversations',
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => chatConversationFromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  // Get [Conversation] by id `/conversations/:id`.
  Future<ChatConversation> getConversationById(
      {required String id, required String accessToken}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        baseUrl: _baseUrl,
        endPoint: '/conversations/$id',
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => ChatConversation.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  // Post [Conversation] by id `/conversations/:id`.
  Future<ChatConversation> postConversationById(
      {required String userId, required String accessToken}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.post,
        baseUrl: _baseUrl,
        endPoint: '/conversations',
        body: {'userIds': [userId]},
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => ChatConversation.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  // Get [ChatMessage] list `/messages/conversation/{conversationId}`.
  Future<List<ChatMessage>> getMessages(
      {required String accessToken, required String conversationId}) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        baseUrl: _baseUrl,
        endPoint: '/messages/conversation/$conversationId',
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.data,
        callBack: (json) => chatMessageFromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }

  // Get [ChatUser] list pagination `/users?{page}&{limit}&{search}`.
  Future<ChatSearchPagination> getUsers(
      {required String accessToken,
      required int page,
      required int limit,
      String? search}) async {
    debugPrint("Call APi Get user");
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        baseUrl: _baseUrl,
        endPoint: '/users?page=$page&limit=$limit&search=$search',
        accessToken: accessToken);
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => ChatSearchPagination.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }
}
