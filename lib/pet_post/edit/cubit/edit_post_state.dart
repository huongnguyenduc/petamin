part of 'edit_post_cubit.dart';

@immutable
class EditPostState extends Equatable {
  final String id;
  final String petId;
  final String userId;
  final String adoptStatus;
  final EditAdoptStatus status;
  final String? errorMessage;
  final String initPrice;
  final String initDescription;

  const EditPostState({
    this.petId = '',
    this.status = EditAdoptStatus.initial,
    this.errorMessage,
    this.initPrice = '',
    this.initDescription = '',
    this.adoptStatus = 'HIDE',
    this.id = '',
    this.userId = '',
  });

  @override
  List<Object> get props => [status, initDescription, initPrice];

  EditPostState copyWith({
    String? petId,
    String? errorMessage,
    String? initPrice,
    String? initDescription,
    String? adoptStatus,
    String? id,
    String? userId,
    EditAdoptStatus? status,
  }) {
    return EditPostState(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      initPrice: initPrice ?? this.initPrice,
      initDescription: initDescription ?? this.initDescription,
      adoptStatus: adoptStatus ?? this.adoptStatus,
    );
  }
}

enum EditAdoptStatus { initial, loading, success, failure, }

extension EditAdopteStatusX on EditAdoptStatus {
  bool get isInitial => this == EditAdoptStatus.initial;
  bool get isLoading => this == EditAdoptStatus.loading;
  bool get isSuccess => this == EditAdoptStatus.success;
  bool get isFailure => this == EditAdoptStatus.failure;
}