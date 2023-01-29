import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cache/cache.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb, visibleForTesting;
import 'package:petamin_api/petamin_api.dart';
import 'package:petamin_api/src/models/models.dart' as apiModels;
import 'package:petamin_repository/petamin_repository.dart';
import 'package:petamin_repository/src/models/adopt_pagination.dart';
import 'package:petamin_repository/src/models/user_pagination.dart';

import './models/models.dart' as models;

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
  PetaminRepository._create(this._petaminApiClient, this._cache, this._sessionController, this._session);

  static Future<PetaminRepository> create(
      {PetaminApiClient? apiClient,
      CacheClient? cacheClient,
      StreamController<Session>? sessionController,
      Session? initSession}) async {
    var component = PetaminRepository._create(apiClient ?? PetaminApiClient(), cacheClient ?? CacheClient(),
        sessionController ?? StreamController<Session>(), initSession ?? Session.empty);
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
        _cache.write(key: sessionCacheKey, value: jsonEncode(convertedSession.toJson()));
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
        _session = sessionMap.isNotEmpty ? Session.fromJson(sessionMap) : Session.empty;
      }
      return _session;
    } catch (e) {
      return Session.empty;
    }
  }

  Future<Session> login({required String email, required String password}) async {
    try {
      final loginResponse = await _petaminApiClient.login(email: email, password: password);
      final user = await _petaminApiClient.getUserProfile(accessToken: loginResponse.accessToken);
      // final yourPet = await getPet(accessToken: loginResponse.accessToken);
      // debugPrint('Pettttt ${yourPet.toString()}');
      final session = Session(
        accessToken: loginResponse.accessToken,
        userId: user.userId ?? 'empty',
      );
      await _cache.write(key: sessionCacheKey, value: jsonEncode(session.toJson()));
      _sessionController.add(session.accessToken.isNotEmpty ? session : Session.empty);
      return session;
    } catch (_) {
      throw const LoginFailure();
    }
  }

  Future<Session> signUp({required String email, required String password, required String name}) async {
    try {
      final signUpResponse = await _petaminApiClient.register(email: email, password: password, name: name);
      final user = await _petaminApiClient.getUserProfile(accessToken: signUpResponse.accessToken);

      final session = Session(
        accessToken: signUpResponse.accessToken,
        userId: user.email ?? 'empty',
      );
      _cache.write(key: sessionCacheKey, value: jsonEncode(session.toJson()));
      _sessionController.add(session.accessToken.isNotEmpty ? session : Session.empty);
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

  Future<void> checkToken() async {
    try {
      final session = await currentSession;
      final checkToken = await _petaminApiClient.checkToken(accessToken: session.accessToken);
      if (checkToken) {
        return;
      } else {
        _sessionController.add(Session.empty);
      }
    } catch (_) {
      throw const LogOutFailure();
    }
  }

  Future<String> getAgoraToken(String channelName) async {
    try {
      final session = await currentSession;
      final agoraToken =
          await _petaminApiClient.getAgoraToken(accessToken: session.accessToken, channelName: channelName);
      return agoraToken;
    } catch (_) {
      throw const LogOutFailure();
    }
  }

  /// Get user profile
  Future<Profile> getUserProfile() async {
    try {
      final session = await currentSession;
      final profile = await _petaminApiClient.getUserProfile(accessToken: session.accessToken);
      return Profile(
        userId: profile.userId,
        name: profile.name,
        avatar: profile.avatar,
        address: profile.address,
        phone: profile.phone,
        description: profile.bio,
        birthday: profile.birthday,
        gender: profile.gender,
        email: profile.email,
        followers: profile.totalFollowers,
        followings: profile.totalFollowings,
        pets: profile.pets
            ?.map((e) => Pet(
                  id: e.id,
                  avatarUrl: e.avatarUrl,
                  name: e.name,
                  year: e.year,
                  month: e.month,
                  gender: e.gender,
                  breed: e.breed,
                  isNeuter: e.isNeuter,
                  weight: e.weight,
                  description: e.description,
                  species: e.species,
                  isAdopting: e.isAdopting,
                ))
            .toList(),
        adoptions: profile.adoptions
            ?.map((e) => models.Adopt(
                petId: e.petId,
                userId: e.userId,
                id: e.id,
                price: e.price,
                description: e.description,
                status: e.status,
                pet: models.Pet(
                  id: e.pet?.id,
                  avatarUrl: e.pet?.avatarUrl,
                  name: e.pet?.name,
                  year: e.pet?.year,
                  month: e.pet?.month,
                  gender: e.pet?.gender,
                  breed: e.pet?.breed,
                  isNeuter: e.pet?.isNeuter,
                  weight: e.pet?.weight,
                  description: e.pet?.description,
                  species: e.pet?.species,
                  isAdopting: e.pet?.isAdopting,
                )))
            .toList(),
      );
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<bool> followUser(String userId) async {
    try {
      final session = await currentSession;
      final result = await _petaminApiClient.followUser(userId: userId, accessToken: session.accessToken);
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<bool> unFollowUser(String userId) async {
    try {
      final session = await currentSession;
      final result = await _petaminApiClient.unFollowUser(userId: userId, accessToken: session.accessToken);
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<bool> toggleAdoptPost(String adoptId, String status) async {
    try {
      final session = await currentSession;
      final result =
          await _petaminApiClient.toggleAdoptStatus(adoptId: adoptId, status: status, accessToken: session.accessToken);
      return result;
    } catch (_) {
      return false;
    }
  }

  // Get User Profile With UserId
  Future<Profile> getUserProfileWithId(String userId) async {
    try {
      final session = await currentSession;
      final profile = await _petaminApiClient.getUserProfileWithId(userId: userId, accessToken: session.accessToken);
      return Profile(
        userId: profile.userId,
        name: profile.name,
        avatar: profile.avatar,
        address: profile.address,
        phone: profile.phone,
        description: profile.bio,
        birthday: profile.birthday,
        gender: profile.gender,
        email: profile.email,
        followers: profile.totalFollowers,
        followings: profile.totalFollowings,
        isFollow: profile.isFollow,
        pets: profile.pets
            ?.map((e) => Pet(
                  id: e.id,
                  avatarUrl: e.avatarUrl,
                  name: e.name,
                  year: e.year,
                  month: e.month,
                  gender: e.gender,
                  breed: e.breed,
                  isNeuter: e.isNeuter,
                  weight: e.weight,
                  description: e.description,
                  species: e.species,
                  isAdopting: e.isAdopting,
                ))
            .toList(),
        adoptions: profile.adoptions
            ?.map((e) => models.Adopt(
                petId: e.petId,
                userId: e.userId,
                id: e.id,
                price: e.price,
                description: e.description,
                status: e.status,
                pet: models.Pet(
                  id: e.pet?.id,
                  avatarUrl: e.pet?.avatarUrl,
                  name: e.pet?.name,
                  year: e.pet?.year,
                  month: e.pet?.month,
                  gender: e.pet?.gender,
                  breed: e.pet?.breed,
                  isNeuter: e.pet?.isNeuter,
                  weight: e.pet?.weight,
                  description: e.pet?.description,
                  species: e.pet?.species,
                  isAdopting: e.pet?.isAdopting,
                )))
            .toList(),
      );
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

  Future<List<Conversation>> getChatConversations() async {
    try {
      final session = await currentSession;
      final conversations = await _petaminApiClient.getConversations(accessToken: session.accessToken);
      debugPrint('conversationsssssssss: ${conversations[0].lastMessage.toString()}');
      debugPrint('userId ne ${session.userId}');
      return conversations.map((conversation) {
        ChatUser partner = conversation.users!.firstWhere((user) => user.id != session.userId);
        debugPrint('conversationsssssssss: ${partner.profile!.avatar}');
        return Conversation(
          id: conversation.id ?? '',
          partner: Profile(
            name: partner.profile!.name,
            avatar: partner.profile!.avatar ?? "",
            userId: partner.id,
          ),
          lastMessage: conversation.lastMessage != null
              ? LastMessage(
                  isMe: partner.id != conversation.lastMessage!.userId,
                  message: conversation.lastMessage!.message ?? "",
                  time: conversation.lastMessage!.createdAt ?? DateTime.now(),
                  id: conversation.lastMessage!.id ?? "",
                  type: conversation.lastMessage!.type ?? "",
                )
              : LastMessage.empty(),
        );
      }).toList();
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<List<Profile>> getFollowers({required String userId}) async {
    try {
      debugPrint("call get follwer");
      final session = await currentSession;
      final result = await _petaminApiClient.getFollowers(accessToken: session.accessToken, userId: userId);
      return result
          .map((user) => Profile(
              userId: user.userId,
              avatar: user.avatar,
              description: user.bio,
              name: user.name,
              email: user.email,
              isFollow: user.isFollow))
          .toList();
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<List<Profile>> getFollowing({required String userId}) async {
    try {
      debugPrint("call get follwing");
      final session = await currentSession;
      final result = await _petaminApiClient.getFollowing(accessToken: session.accessToken, userId: userId);
      return result
          .map((user) => Profile(
              userId: user.userId, avatar: user.avatar, name: user.name, email: user.email, isFollow: user.isFollow))
          .toList();
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  // Get user pagination
  Future<UserPagination> getUserPagination({required int page, required int limit, required String query}) async {
    try {
      debugPrint("call repo");
      final session = await currentSession;
      final userPaginationData =
          await _petaminApiClient.getUsers(accessToken: session.accessToken, page: page, limit: limit, search: query);
      final users = userPaginationData.data;
      final pagination = userPaginationData.meta;
      return UserPagination(
          users: users
              .map((user) => Profile(
                    userId: user.id,
                    name: user.profile!.name ?? "",
                    profileId: user.profile!.id ?? "",
                    email: user.email,
                    avatar: user.profile!.avatar ?? "",
                  ))
              .toList(),
          pagination: PaginationData(
            pagination.currentPage,
            pagination.itemsPerPage,
            pagination.totalItems,
            pagination.totalPages,
          ));
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  // Get adopt pagination
  Future<AdoptPagination> getAdoptPagination({
    required int page,
    required int limit,
    required String query,
    List<String>? species,
    List<String>? prices,
  }) async {
    try {
      debugPrint("call Repo getAdoptPagination");
      final session = await currentSession;
      final userPaginationData = await Function.apply(_petaminApiClient.getAdopts, [], {
        #accessToken: session.accessToken,
        #page: page,
        #limit: limit,
        #search: query,
        if (species != null) #species: convertArrayToString(species),
        if (prices != null) #prices: convertArrayToString(prices),
      });

      final List pets = userPaginationData.data;
      final pagination = userPaginationData.meta;
      return AdoptPagination(
          pets: pets
              .map((adopt) => models.Adopt(
                  petId: adopt.petId,
                  userId: adopt.userId,
                  id: adopt.id,
                  price: adopt.price,
                  description: adopt.description,
                  status: adopt.status,
                  pet: models.Pet(
                    id: adopt.pet?.id,
                    name: adopt.pet?.name,
                    month: adopt.pet?.month,
                    year: adopt.pet?.year,
                    gender: adopt.pet?.gender,
                    breed: adopt.pet?.breed,
                    isNeuter: adopt.pet?.isNeuter,
                    avatarUrl: adopt.pet?.avatarUrl,
                    weight: adopt.pet?.weight,
                    description: adopt.pet?.description,
                    species: adopt.pet?.species,
                    photos: const [],
                    isAdopting: adopt.pet?.isAdopting,
                  )))
              .toList(),
          pagination: PaginationData(
            pagination.currentPage,
            pagination.itemsPerPage,
            pagination.totalItems,
            pagination.totalPages,
          ));
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  String convertArrayToString(List<String> array) {
    String result = "";
    for (int i = 0; i < array.length; i++) {
      result += array[i];
      if (i != array.length - 1) {
        result += "%2C";
      }
    }
    return result;
  }

  // Get detail user conversation
  Future<UserConversationDetail> getUserDetailConversation({required String conversationId}) async {
    try {
      final session = await currentSession;
      final detailConversation =
          await _petaminApiClient.getConversationById(accessToken: session.accessToken, id: conversationId);
      final partner = detailConversation.users!.firstWhere((user) => user.id != session.userId);
      return UserConversationDetail(
        conversationId: detailConversation.id ?? "",
        partner: Profile(
          userId: partner.id,
          name: partner.profile!.name,
          avatar: partner.profile!.avatar ?? "",
          profileId: partner.profile!.id ?? "",
        ),
      );
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  // Post detail user conversation
  Future<UserConversationDetail> postUserDetailConversation({required String userId}) async {
    try {
      final session = await currentSession;
      final detailConversation =
          await _petaminApiClient.postConversationById(accessToken: session.accessToken, userId: userId);
      final partner = detailConversation.users!.firstWhere((user) => user.id != session.userId);
      return UserConversationDetail(
        conversationId: detailConversation.id ?? "",
        partner: Profile(
          userId: partner.id,
          name: partner.profile!.name,
          avatar: partner.profile!.avatar ?? "",
          profileId: partner.profile!.id ?? "",
        ),
      );
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  // Get Chat Message
  Future<List<Message>> getChatMessages(String conversationId) async {
    try {
      final session = await currentSession;
      final messages =
          await _petaminApiClient.getMessages(accessToken: session.accessToken, conversationId: conversationId);
      return messages.map((message) {
        return Message(
          isMe: message.userId == session.userId,
          message: message.message ?? '',
          time: message.createdAt ?? DateTime.now(),
          type: message.type ?? 'TEXT',
          id: message.id ?? '',
        );
      }).toList();
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
      final petList = await _petaminApiClient.getPets(accessToken: session.accessToken);
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
            description: element.description,
            isAdopting: element.isAdopting,
            photos: element.photos?.map((e) => models.Images(id: e.id, imgUrl: e.imgUrl)).toList(),
            species: element.species));
      }
      final AdoptPagination adoptList = await getAdoptPagination(
        page: 1,
        limit: 10,
        query: 'm',
        species: ['DOG'],
      );
      debugPrint("adoptList: ${adoptList.pets.length}");
      for (var element in adoptList.pets) {
        debugPrint("adoptInfor: ${element.pet?.props.toString()}");
      }
      return list;
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<models.Adopt> getAdoptDetail(String petId) async {
    try {
      final session = await currentSession;
      final adopt = await _petaminApiClient.getAdoptDetail(petId: petId, accessToken: session.accessToken);
      return models.Adopt(
        id: adopt.id,
        price: adopt.price,
        description: adopt.description,
        status: adopt.status,
        petId: adopt.petId,
        userId: adopt.userId,
      );
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<bool> createAdopt(models.Adopt adopt) async {
    try {
      final session = await currentSession;
      return await _petaminApiClient.createAdopt(
          adopt: apiModels.Adopt(
            id: '',
            price: adopt.price,
            description: adopt.description,
            status: adopt.status,
            userId: adopt.userId,
            petId: adopt.petId,
          ),
          accessToken: session.accessToken);
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<bool> updateAdopt(models.Adopt adopt) async {
    try {
      final session = await currentSession;
      return await _petaminApiClient.updateAdopt(
          adopt: apiModels.Adopt(
              description: adopt.description,
              id: adopt.id,
              price: adopt.price,
              status: adopt.status,
              petId: adopt.petId,
              userId: adopt.userId),
          accessToken: session.accessToken);
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<Pet> getPetDetail({required String id}) async {
    try {
      final session = await currentSession;
      final petDetail = await _petaminApiClient.getPetDetail(id: id, accessToken: session.accessToken);
      return Pet(
          id: petDetail.id,
          userId: petDetail.userId,
          name: petDetail.name,
          avatarUrl: petDetail.avatarUrl,
          month: petDetail.month,
          year: petDetail.year,
          breed: petDetail.breed,
          isNeuter: petDetail.isNeuter,
          gender: petDetail.gender,
          description: petDetail.description,
          weight: petDetail.weight,
          isAdopting: petDetail.isAdopting,
          photos: petDetail.photos?.map((e) => models.Images(id: e.id, imgUrl: e.imgUrl)).toList(),
          species: petDetail.species);
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<bool> deletePhotos({required String photoId, required String petId}) async {
    try {
      final session = await currentSession;
      return await _petaminApiClient.deletePhotos(photoId: photoId, petId: petId, accessToken: session.accessToken);
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<bool> addPhotos({required List<File> files, required String petId}) async {
    try {
      final session = await currentSession;
      return await _petaminApiClient.addPhotos(files: files, petId: petId, accessToken: session.accessToken);
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<bool> deleteAdoptPost({required String adoptId}) async {
    try {
      final session = await currentSession;
      return await _petaminApiClient.deleteAdoptPost(adoptId: adoptId, accessToken: session.accessToken);
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<bool> createPet({required Pet pet, required File? avatar}) async {
    try {
      debugPrint("Create Pet");
      final session = await currentSession;
      String? avatarUrl = "";

      if (avatar != null) {
        avatarUrl = await _petaminApiClient.uploadFile(accessToken: session.accessToken, file: avatar);
        return await _petaminApiClient.createPet(
            pet: PetRes(
              id: pet.id,
              name: pet.name,
              month: pet.month,
              year: pet.year,
              gender: pet.gender,
              breed: pet.breed,
              isNeuter: pet.isNeuter,
              avatarUrl: avatarUrl,
              description: pet.description,
              weight: pet.weight,
              species: pet.species,
            ),
            accessToken: session.accessToken);
      } else {
        return false;
      }
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<bool> updatePet({required Pet pet}) async {
    try {
      debugPrint("Update Pet Repo");
      final session = await currentSession;
      return await _petaminApiClient.updatePet(
        pet: PetRes(
          id: pet.id,
          name: pet.name,
          month: pet.month,
          year: pet.year,
          gender: pet.gender,
          breed: pet.breed,
          isNeuter: pet.isNeuter,
          avatarUrl: pet.avatarUrl,
          description: pet.description,
          weight: pet.weight,
          species: pet.species,
        ),
        accessToken: session.accessToken,
        avatar: pet.avatar,
      );
    } catch (_) {
      throw const CallApiFailure();
    }
  }

  Future<String> uploadMultipleFiles({required List<File> files}) async {
    try {
      debugPrint("Upload files");
      return await _petaminApiClient.uploadMultipleFile(
        files: files,
      );
    } catch (_) {
      throw const CallApiFailure();
    }
  }
}
