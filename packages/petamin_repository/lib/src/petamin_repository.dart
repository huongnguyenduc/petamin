import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:petamin_repository/petamin_repository.dart';
import 'package:cache/cache.dart';
import 'package:petamin_api/petamin_api.dart';
import 'package:flutter/foundation.dart'
    show debugPrint, kIsWeb, visibleForTesting;
import './models/models.dart';

class CallApiFailure implements Exception {
  const CallApiFailure([
    this.message = 'An unknown exception occurred when calling api.',
  ]);
  final String message;
}

class LoginFailure implements Exception {
  const LoginFailure([
    this.message = 'An unknown exception occurred when log in.',
  ]);
  final String message;
}

class SignUpFailure implements Exception {
  const SignUpFailure([
    this.message = 'An unknown exception occurred when sign up.',
  ]);
  final String message;
}

class LogOutFailure implements Exception {
  const LogOutFailure([
    this.message = 'An unknown exception occurred when log out.',
  ]);
  final String message;
}

class PetaminRepository {
  PetaminRepository._create(this._petaminApiClient, this._cache,
      this._sessionController, this._session);

  static Future<PetaminRepository> create(
      {PetaminApiClient? apiClient,
      CacheClient? cacheClient,
      StreamController<Session>? sessionController,
      Session? initSession}) async {
    var component = PetaminRepository._create(
        apiClient ?? PetaminApiClient(),
        cacheClient ?? CacheClient(),
        sessionController ?? StreamController<Session>(),
        initSession ?? Session.empty);
    await component._asyncInit();
    return component;
  }

  Future<void> _asyncInit() async {
    final session = await currentSession;
    _sessionController.add(session);
  }

  final PetaminApiClient _petaminApiClient;
  final CacheClient _cache;
  final StreamController<Session> _sessionController;
  Session _session;

  Session get availableSession => _session;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const sessionCacheKey = '__session_cache_key__';

  /// Stream of [Session] which will emit the current session when
  /// the authentication state changes.
  ///
  /// Emits [Session.empty] if the user is not authenticated.
  Stream<Session> get session {
    try {
      return _sessionController.stream.map((session) {
        final convertedSession = session ?? Session.empty;
        _cache.write(
            key: sessionCacheKey, value: jsonEncode(convertedSession.toJson()));
        return session;
      });
    } catch (e) {
      debugPrint(e.toString());
      return _sessionController.stream;
    }
  }

  /// Returns the current cached session.
  /// Defaults to [Session.empty] if there is no cached user.
  /// Future<User> get currentUser async {

  Future<Session> get currentSession async {
    try {
      final cachedSession = await _cache.read(key: sessionCacheKey);
      if (cachedSession.isEmpty) {
        _session = Session.empty;
      } else {
        final sessionMap = jsonDecode(cachedSession) as Map<String, dynamic>;
        _session = sessionMap.isNotEmpty
            ? Session.fromJson(sessionMap)
            : Session.empty;
      }
      return _session;
    } catch (e) {
      return Session.empty;
    }
  }

  Future<Session> login(
      {required String email, required String password}) async {
    try {
      final loginResponse =
          await _petaminApiClient.login(email: email, password: password);
      final user = await _petaminApiClient.getUserProfile(
          accessToken: loginResponse.accessToken);
      // final yourPet = await getPet(accessToken: loginResponse.accessToken);
      // debugPrint('Pettttt ${yourPet.toString()}');
      final session = Session(
        accessToken: loginResponse.accessToken,
        userId: user.email ?? 'empty',
      );
      await _cache.write(
          key: sessionCacheKey, value: jsonEncode(session.toJson()));
      _sessionController
          .add(session.accessToken.isNotEmpty ? session : Session.empty);
      return session;
    } catch (_) {
      throw const LoginFailure();
    }
  }

  Future<Session> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final signUpResponse = await _petaminApiClient.register(
          email: email, password: password, name: name);
      final user = await _petaminApiClient.getUserProfile(
          accessToken: signUpResponse.accessToken);

      final session = Session(
        accessToken: signUpResponse.accessToken,
        userId: user.email ?? 'empty',
      );
      _cache.write(key: sessionCacheKey, value: jsonEncode(session.toJson()));
      _sessionController
          .add(session.accessToken.isNotEmpty ? session : Session.empty);
      return session;
    } catch (_) {
      throw const SignUpFailure();
    }
  }

  Future<void> logOut() async {
    try {
      final session = await currentSession;
      await _petaminApiClient.logout(accessToken: session.accessToken);
      _sessionController.add(Session.empty);
    } catch (_) {
      throw const LogOutFailure();
    }
  }

  /// Get user profile
  Future<Profile> getUserProfile() async {
    try {
      final session = await currentSession;
      final profile = await _petaminApiClient.getUserProfile(
          accessToken: session.accessToken);
      return Profile(
          name: profile.name,
          avatar: profile.avatar,
          address: profile.address,
          phone: profile.phone,
          description: profile.bio,
          birthday: profile.birthday,
          gender: profile.gender,
          email: profile.email);
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  /// Update user profile
  Future<Profile> updateUserProfile({
    String? address,
    String? phone,
    String? description,
    String? birthday,
    String? name,
    File? avatar,
  }) async {
    try {
      final session = await currentSession;
      final profile = await _petaminApiClient.updateUserProfile(
          accessToken: session.accessToken,
          address: address,
          phone: phone,
          bio: description,
          name: name,
          avatar: avatar,
          birthday: birthday);
      return Profile(
        name: profile.name,
        avatar: profile.avatar,
        address: profile.address,
        phone: profile.phone,
        description: profile.bio,
        birthday: profile.birthday,
      );
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<void> dispose() async {
    await _sessionController.close();
  }

  Future<List<Pet>> getPets() async {
    try {
      final session = await currentSession;
      final petList =
          await _petaminApiClient.getPets(accessToken: session.accessToken);
      var list = List<Pet>.empty(growable: true);
      for (var element in petList) {
        list.add(Pet(
            id: element.id,
            name: element.name,
            year: element.year,
            month: element.month,
            breed: element.breed,
            gender: element.gender,
            isNeuter: element.isNeuter,
            avatarUrl: element.avatarUrl,
            weight: element.weight,
            description: element.description));
      }
      return list;
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<Pet> getPetDetail({required String id}) async {
    try {
      final session = await currentSession;
      final petDetail = await _petaminApiClient.getPetDetail(
          id: id, accessToken: session.accessToken);
      return Pet(
        id: petDetail.id,
        name: petDetail.name,
        avatarUrl: petDetail.avatarUrl,
        month: petDetail.month,
        year: petDetail.year,
        breed: petDetail.breed,
        isNeuter: petDetail.isNeuter,
        gender: petDetail.gender,
        description: petDetail.description,
        weight: petDetail.weight,
      );
    } catch (_) {
      throw const CallApiFailure();
    }
  }
}
