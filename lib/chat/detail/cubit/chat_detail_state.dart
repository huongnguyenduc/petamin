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
      this.partner = Profile.empty,
      this.isPartnerOnline = false,
      this.isTyping = false,
      this.isSendingTyping = false,
      this.callModel});

  final List<Message> messages;
  final String chatMessage;
  final ChatDetailStatus status;
  final CallVideoStatus callVideoStatus;
  final String errorMessage;
  final CallModel? callModel;
  final Profile? partner;
  final bool isPartnerOnline;
  final bool isTyping;
  final bool isSendingTyping;

  @override
  List<Object?> get props => [
        messages,
        chatMessage,
        status,
        partner,
        callModel,
        callVideoStatus,
        errorMessage,
        isPartnerOnline,
        isTyping,
        isSendingTyping
      ];

  ChatDetailState copyWith({
    List<Message>? messages,
    String? chatMessage,
    ChatDetailStatus? status,
    Profile? partner,
    CallModel? callModel,
    String? errorMessage,
    CallVideoStatus? callVideoStatus,
    bool? isPartnerOnline,
    bool? isTyping,
    bool? isSendingTyping,
  }) {
    return ChatDetailState(
      messages: messages ?? this.messages,
      chatMessage: chatMessage ?? this.chatMessage,
      status: status ?? this.status,
      partner: partner ?? this.partner,
      callModel: callModel ?? this.callModel,
      errorMessage: errorMessage ?? this.errorMessage,
      callVideoStatus: callVideoStatus ?? this.callVideoStatus,
      isPartnerOnline: isPartnerOnline ?? this.isPartnerOnline,
      isTyping: isTyping ?? this.isTyping,
      isSendingTyping: isSendingTyping ?? this.isSendingTyping,
    );
  }
}
