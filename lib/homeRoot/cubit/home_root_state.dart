import 'package:Petamin/data/models/call_model.dart';

abstract class HomeRootState {}

class HomeRootInitial extends HomeRootState {
}
//Incoming Call
class SuccessInComingCallState extends HomeRootState {
  final CallModel callModel;

  SuccessInComingCallState({required this.callModel});
}