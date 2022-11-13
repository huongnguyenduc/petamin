import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Adopt extends Equatable {
  const Adopt({
    required this.petId,
    required this.userId,
    required this.id,
    required this.price,
    required this.description,
    required this.status,
  });
  final String? id;
  final String? petId;
  final String? userId;
  final double? price;
  final String? description;
  final String? status;
  @override
  List<Object?> get props => [
        id,
        price,
        description,
        status,
      ];
}