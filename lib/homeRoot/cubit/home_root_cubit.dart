import 'package:Petamin/data/api/call_api.dart';
import 'package:Petamin/data/models/call_model.dart';
import 'package:Petamin/data/models/user_model.dart';
import 'package:Petamin/homeRoot/cubit/home_root_state.dart';
import 'package:Petamin/services/fcm/firebase_notification_handler.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/shared/network/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

class HomeRootCubit extends Cubit<HomeRootState> {
  HomeRootCubit(this._petaminRepository) : super(HomeRootInitial());
  PetaminRepository _petaminRepository;

  Future<void> checkSession() async {
    await _petaminRepository.checkToken();
    return;
  }

  static HomeRootCubit get(context) => BlocProvider.of(context);

  final firebaseNotifications = FirebaseNotifications();

  final _callApi = CallApi();

  void initFcm(context) {
    debugPrint('qqqqqqqqqqqqqqqqqqq');
    firebaseNotifications.setUpFcm(
        context: context,
        onForegroundClickCallNotify: (String payload) {
          debugPrint('Foreground Click Call Notify: $payload');
        });
  }

  void updateFcmToken({required String uId}) {
    debugPrint('ccccccccsssssssss');
    FirebaseMessaging.instance.getToken().then((token) {
      UserFcmTokenModel tokenModel = UserFcmTokenModel(token: token!, uId: uId);
      FirebaseFirestore.instance
          .collection(tokensCollection)
          .doc(uId)
          .set(tokenModel.toMap())
          .then((value) {
        debugPrint('User Fcm Token Updated $token');
      }).catchError((onError) {
        debugPrint(onError.toString());
      });
    });
  }

  CallStatus? currentCallStatus;
  void listenToInComingCalls({required String uId}) {
    _callApi.listenToInComingCall(uId: uId).onData((data) {
      if (data.size != 0) {
        for (var element in data.docs) {
          if (element.data()['current'] == true) {
            String status = element.data()['status'];
            if (status == CallStatus.ringing.name) {
              currentCallStatus = CallStatus.ringing;
              debugPrint('Imm Commingggggggggggg');
              debugPrint('ringingStatus');
              emit(SuccessInComingCallState(
                  callModel: CallModel.fromJson(element.data())));
            }
          }
        }
      }
    });
  }
}
