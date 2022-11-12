part of 'create_post_cubit.dart';

class CreatePostState extends Equatable {
  final Price price;
  final String description;
  final String? errorMessage;
  final PostAdoptStatus status;
  const CreatePostState({
    this.price = const Price.pure(),
    this.description = '',
    this.status = PostAdoptStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object> get props => [price, description, status];

  CreatePostState copyWith({
    Price? price,
    String? description,
    PostAdoptStatus? status,
    String? errorMessage,
  }) {
    return CreatePostState(
      price: price ?? this.price,
      description: description ?? this.description,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum PostAdoptStatus { initial, loading, success, failure, isPosted }

extension PostAdoptStatusX on PostAdoptStatus {
  bool get isInitial => this == PostAdoptStatus.initial;
  bool get isLoading => this == PostAdoptStatus.loading;
  bool get isSuccess => this == PostAdoptStatus.success;
  bool get isFailure => this == PostAdoptStatus.failure;
  bool get isPosted => this == PostAdoptStatus.isPosted;
}
