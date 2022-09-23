import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Petamin/services/fcm/firebase_notification_handler.dart';
import 'package:Petamin/data/models/user_model.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/shared/network/cache_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:Petamin/data/api/call_api.dart';

import '../../data/models/call_model.dart';
import '../../data/models/fcm_payload_model.dart';
import '../../shared/dio_helper.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final firebaseNotifications = FirebaseNotifications();
  void onMenuItemTapped(int index) {
    emit(state.copyWith(index: index));
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  void initFcm(context) {
    firebaseNotifications.setUpFcm(
        context: context,
        onForegroundClickCallNotify: (String payload) {
          debugPrint('Foreground Click Call Notify: $payload');
        });
  }

  void updateFcmToken({required String uId}) {
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

  final _callApi = CallApi();
  bool fireCallLoading = false;
  Future<void> fireVideoCall({required CallModel callModel}) async { 
    fireCallLoading = true;
    emit(LoadingFireVideoCallState());
    //1-generate call token
    Map<String, dynamic> queryMap = {
      'channelName': 'channel_${UniqueKey().hashCode.toString()}',
      'uid': callModel.callerId,
    };
    _callApi.generateCallToken(queryMap: queryMap).then((value) {
      callModel.token = value['token'];
      callModel.channelName = value['channel_name'];
      //2-post call in Firebase
      postCallToFirestore(callModel: callModel);
    }).catchError((onError) {
      fireCallLoading = false;
      //For test
      callModel.token = agoraTestToken;
      callModel.channelName = agoraTestChannelName;
      postCallToFirestore(callModel: callModel);
      emit(ErrorFireVideoCallState(onError.toString()));
    });
  }

  void postCallToFirestore({required CallModel callModel}) {
    _callApi.postCallToFirestore(callModel: callModel).then((value) {
      //3-update user busy status in Firebase
      _callApi
          .updateUserBusyStatusFirestore(callModel: callModel, busy: true)
          .then((value) {
        fireCallLoading = false;
        //4-send notification to receiver
        sendNotificationForIncomingCall(callModel: callModel);
      }).catchError((onError) {
        fireCallLoading = false;
        emit(ErrorUpdateUserBusyStatus(onError.toString()));
      });
    }).catchError((onError) {
      fireCallLoading = false;
      emit(ErrorPostCallToFirestoreState(onError.toString()));
    });
  }

  void sendNotificationForIncomingCall({required CallModel callModel}) {
    FirebaseFirestore.instance
        .collection(tokensCollection)
        .doc(callModel.receiverId)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic> bodyMap = {
          'type': 'call',
          'title': 'New call',
          'body': jsonEncode(callModel.toMap())
        };
        FcmPayloadModel fcmSendData =
            FcmPayloadModel(to: value.data()!['token'], data: bodyMap);

        DioHelper.postData(
          data: fcmSendData.toMap(),
          baseUrl: 'https://fcm.googleapis.com/',
          endPoint: 'fcm/send',
        ).then((value) {
          debugPrint('SendNotifySuccess ${value.data.toString()}');
          emit(SuccessFireVideoCallState(callModel: callModel));
        }).catchError((onError) {
          debugPrint('Error when send Notify: $onError');
          fireCallLoading = false;
          emit(ErrorSendNotification(onError.toString()));
        });
      }
    }).catchError((onError) {
      debugPrint('Error when get user token: $onError');
      fireCallLoading = false;
      emit(ErrorSendNotification(onError.toString()));
    });
  }
  // CallModel inComingCall;

  CallStatus? currentCallStatus;
  void listenToInComingCalls() {
    debugPrint('listenToInComingCalls');
    _callApi.listenToInComingCall().onData((data) {
      debugPrint('data: ${data.size.toString()}');
      if (data.size != 0) {
        for (var element in data.docs) {
          if (element.data()['current'] == true) {
            String status = element.data()['status'];
            if (status == CallStatus.ringing.name) {
              currentCallStatus = CallStatus.ringing;
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
