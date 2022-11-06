part of 'edit_post_cubit.dart';

@immutable
class EditPostState extends Equatable {
  final Price price;
  final String description;
  final FormzStatus status;
  final String? errorMessage;
  final String initPrice;
  final String initDescription;

  const EditPostState({
    this.price = const Price.pure(),
    this.description = '',
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.initPrice = '',
    this.initDescription = '',
  });

  @override
  List<Object> get props => [price, description, status, initDescription, initPrice];

  EditPostState copyWith({
    Price? price,
    String? description,
    FormzStatus? status,
    String? errorMessage,
    String? initPrice,
    String? initDescription,
  }) {
    return EditPostState(
      price: price ?? this.price,
      description: description ?? this.description,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      initPrice: initPrice ?? this.initPrice,
      initDescription: initDescription ?? this.initDescription,
    );
  }
}
