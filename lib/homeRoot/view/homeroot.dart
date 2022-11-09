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
import 'package:petamin_repository/petamin_repository.dart';

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
    final user = context.select((AppSessionBloc bloc) => bloc.state.session);
    debugPrint('UserIdIs: ${user.userId}');
    return BlocProvider(
      create: (context) => HomeRootCubit(context.read<PetaminRepository>())
        ..checkSession()
        ..updateFcmToken(uId: user.userId)
        ..listenToInComingCalls(uId: user.userId),
      child: Scaffold(
          body: BlocConsumer<HomeRootCubit, HomeRootState>(
              listener: (context, state) {
        //Receiver Call States
        if (state is SuccessInComingCallState) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CallScreen(
                    isReceiver: true,
                    callModel: state.callModel,
                  )));
        }
      }, builder: (context, state) {
        //var homeRootCubit = HomeRootCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: false,
          child: HomePage(),
        );
      })),
    );
  }
}
