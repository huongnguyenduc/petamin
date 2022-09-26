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
  HomeCubit() : super(HomeState());

  void onMenuItemTapped(int index) {
    emit(state.copyWith(index: index));
  }

  static HomeCubit get(context) => BlocProvider.of(context);
}
