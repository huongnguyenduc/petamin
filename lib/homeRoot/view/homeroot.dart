import 'dart:convert';

import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:Petamin/call/view/call_screen.dart';
import 'package:Petamin/data/models/call_model.dart';
import 'package:Petamin/home/view/home_page.dart';
import 'package:Petamin/homeRoot/cubit/home_root_cubit.dart';
import 'package:Petamin/homeRoot/cubit/home_root_state.dart';
import 'package:Petamin/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeRootScreen extends StatefulWidget {
  const HomeRootScreen({Key? key}) : super(key: key);

  @override
  State<HomeRootScreen> createState() => _HomeRootScreenState();
  static Page<void> page() => const MaterialPage<void>(child: HomeRootScreen());
}

class _HomeRootScreenState extends State<HomeRootScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('UserIdIs: ${CacheHelper.getString(key: 'uId')}');
    Future.delayed(const Duration(milliseconds: 1000), () {
      checkInComingTerminatedCall();
    });
  }

  checkInComingTerminatedCall() async {
    if (CacheHelper.getString(key: 'terminateIncomingCallData').isNotEmpty) {
      //if there is a terminated call
      Map<String, dynamic> callMap =
          jsonDecode(CacheHelper.getString(key: 'terminateIncomingCallData'));
      await CacheHelper.removeData(key: 'terminateIncomingCallData');
      // Navigator.pushNamed(context, callScreen, arguments: [
      //   true,
      //   CallModel.fromJson(callMap),
      // ]);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CallScreen(
                isReceiver: true,
                callModel: CallModel.clone(),
              )));
    }
    debugPrint('checkInComingTerminadCall');
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocProvider( create: (_) => HomeRootCubit()..updateFcmToken(uId: user.id)..listenToInComingCalls(),
    child: Scaffold(
        body: BlocConsumer<HomeRootCubit, HomeRootState>(
            listener: (context, state) {
      //Receiver Call States
      if (state is SuccessInComingCallState) {
        // Navigator.pushNamed(context, callScreen,
        //     arguments: [true, state.callModel]);
        debugPrint('ccccccccccccc');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CallScreen(
                  isReceiver: true,
                  callModel: state.callModel,
                )));
      }
    }, builder: (context, state) {
      var homeRootCubit = HomeRootCubit.get(context);
      return ModalProgressHUD(
        inAsyncCall: false,
        child: HomePage(),
      );
    })),
    );
  }
}
