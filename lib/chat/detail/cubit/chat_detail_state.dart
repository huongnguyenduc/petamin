part of 'chat_detail_cubit.dart';

// Chat Detail Status
enum ChatDetailStatus { initial, loading, loaded, error }

enum CallVideoStatus {
  Initial,
  ErrorSendNotification,
  LoadingSendNotification,
  SuccessFireVideoCallState,
  ErrorFireVideoCallState,
  ErrorPostCallToFirestoreState
}

class ChatDetailState extends Equatable {
  ChatDetailState(
      {this.messages = const [],
      this.chatMessage = '',
      this.status = ChatDetailStatus.initial,
      this.callVideoStatus = CallVideoStatus.Initial,
      this.errorMessage = '',
      this.partner,
      this.callModel});

  final List<Message> messages;
  final String chatMessage;
  final ChatDetailStatus status;
  final CallVideoStatus callVideoStatus;
  final String errorMessage;
  CallModel? callModel;
  Profile? partner = Profile.empty();
  @override
  List<Object?> get props => [
        messages,
        chatMessage,
        status,
        partner,
        callModel,
        callVideoStatus,
        errorMessage
      ];

  ChatDetailState copyWith({
    List<Message>? messages,
    String? chatMessage,
    ChatDetailStatus? status,
    Profile? partner,
    CallModel? callModel,
    String? errorMessage,
    CallVideoStatus? callVideoStatus,
  }) {
    return ChatDetailState(
      messages: messages ?? this.messages,
      chatMessage: chatMessage ?? this.chatMessage,
      status: status ?? this.status,
      partner: partner ?? this.partner,
      callModel: callModel ?? this.callModel,
      errorMessage: errorMessage ?? this.errorMessage,
      callVideoStatus: callVideoStatus ?? this.callVideoStatus,
    );
  }
}
