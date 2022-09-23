import 'dart:convert';
import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:Petamin/call/view/call_screen.dart';
import 'package:Petamin/routes/navigator_routes.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Petamin/home/home.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../data/models/call_model.dart';
import '../../shared/constants.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/shared_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  void initState(context) {
    debugPrint('UserIdIs: ${CacheHelper.getString(key: 'uId')}');
    Future.delayed(const Duration(milliseconds: 1000), () {
      checkInComingTerminatedCall(context);
    });
  }

  checkInComingTerminatedCall(context) async {
    if (CacheHelper.getString(key: 'terminateIncomingCallData').isNotEmpty) {
      //if there is a terminated call
      Map<String, dynamic> callMap =
          jsonDecode(CacheHelper.getString(key: 'terminateIncomingCallData'));
      await CacheHelper.removeData(key: 'terminateIncomingCallData');
      Navigator.pushNamed(context, callScreen, arguments: [
        true,
        CallModel.fromJson(callMap),
      ]);
       }
        Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) =>  CallScreen(isReceiver: true,
        callModel: CallModel.clone(),)));
   
    //  Navigator.pushNamed(context, callScreen, arguments: [
    //     true,
    //     CallModel.clone(),
    //   ]);
  }

  @override
  build(BuildContext context) {
    initState(context);
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocProvider(
      create: (_) => HomeCubit()
        ..listenToInComingCalls()
        ..initFcm(context)
        ..updateFcmToken(uId: user.id),
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
          //GetUserData States
          if (state is ErrorGetUsersState) {
            showToast(msg: state.message);
          }
          if (state is ErrorGetCallHistoryState) {
            showToast(msg: state.message);
          }
          //FireCall States
          if (state is ErrorFireVideoCallState) {
            showToast(msg: state.message);
          }
          if (state is ErrorPostCallToFirestoreState) {
            showToast(msg: state.message);
          }
          if (state is ErrorUpdateUserBusyStatus) {
            showToast(msg: state.message);
          }
          if (state is SuccessFireVideoCallState) {
            Navigator.pushNamed(context, callScreen,
                arguments: [false, state.callModel]);
          }

          //Receiver Call States
          if (state is SuccessInComingCallState) {
            Navigator.pushNamed(context, callScreen,
                arguments: [true, state.callModel]);
          }
        }, builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return ModalProgressHUD(
            inAsyncCall: homeCubit.fireCallLoading,
            child: HomeView(),
          );
        }),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   actions: <Widget>[
      //     IconButton(
      //       key: const Key('homePage_logout_iconButton'),
      //       icon: const Icon(Icons.exit_to_app),
      //       onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
      //     )
      //   ],
      // ),
      body: FlowBuilder<HomeState>(
        state: context.select((HomeCubit cubit) => cubit.state),
        onGeneratePages: onGenerateAppViewWindows,
      ),
      bottomNavigationBar: CustomNavigator(),
    );
  }
}
