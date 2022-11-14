import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:petamin_repository/petamin_repository.dart';

@JsonSerializable()
class Adopt extends Equatable {
  const Adopt(
      {required this.petId,
      required this.userId,
      required this.id,
      required this.price,
      required this.description,
      required this.status,
      this.pet});
  final String? id;
  final String? petId;
  final String? userId;
  final double? price;
  final String? description;
  final String? status;
  final Pet? pet;
  @override
  List<Object?> get props =>
      [id, price, description, status, pet?.props.toString()];
}
