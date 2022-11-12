import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:petamin_api/petamin_api.dart';
import 'package:petamin_api/src/models/adopt/adopt.dart';
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
  Future<bool> createPet({required PetRes pet, required String accessToken}) async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.post,
      baseUrl: _baseUrl,
      endPoint: '/pets',
      accessToken: accessToken,
      body: pet.toJson(),
    );
    debugPrint('Response ${response?.body}');
    if (response!.statusCode == 201) {
      return true;
    } else {
      return false;
    }
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
  Future<Adopt> getAdoptDetail(
      {required String petId, required String accessToken}) async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      baseUrl: _baseUrl,
      endPoint: '/adoptions/pet/$petId',
      accessToken: accessToken,
    );
    debugPrint('Response ${response?.body}');
    return await NetworkHelper.filterResponse(
        response: response,
        parameterName: CallBackParameterName.all,
        callBack: (json) => Adopt.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }
  Future<bool> createAdopt(
      {required Adopt adopt, required String accessToken}) async {
    debugPrint("Create Adopt API");
    final response = await NetworkService.sendRequest(
      requestType: RequestType.post,
      baseUrl: _baseUrl,
      endPoint: '/adoptions',
      body: adopt.toJson(),
      accessToken: accessToken,
    );
    debugPrint('Response ${response?.body}');
    if (response!.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> updateAdopt(
      {required Adopt adopt, required String accessToken}) async {
    debugPrint("Update Adopt API");
    final response = await NetworkService.sendRequest(
      requestType: RequestType.patch,
      baseUrl: _baseUrl,
      endPoint: '/adoptions/${adopt.id}',
      body: adopt.toJson(),
      accessToken: accessToken,
    );
    debugPrint('Response ${response?.body}');
    if (response!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> deletePhotos({required String photoId,required String petId, required String accessToken}) async {
    debugPrint("Delete Photos API");
    final response = await NetworkService.sendRequest(
      requestType: RequestType.post,
      baseUrl: _baseUrl,
      body: {'photoIds': [photoId]},
      endPoint: '/pets/$petId/photos/delete',
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
        parameterName: CallBackParameterName.data,
        callBack: (json) => ChatConversation.fromJson(json),
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });
  }
}
