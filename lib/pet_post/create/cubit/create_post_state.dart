part of 'create_post_cubit.dart';

@immutable
class CreatePostState extends Equatable {
  final Price price;
  final String description;
  final FormzStatus status;
  final String? errorMessage;

  const CreatePostState({
    this.price = const Price.pure(),
    this.description = '',
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object> get props => [price, description, status];

  CreatePostState copyWith({
    Price? price,
    String? description,
    FormzStatus? status,
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
