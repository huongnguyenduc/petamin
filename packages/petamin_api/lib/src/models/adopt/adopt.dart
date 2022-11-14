import 'package:json_annotation/json_annotation.dart';
import 'package:petamin_api/src/models/petRes.dart';
part 'adopt.g.dart';

@JsonSerializable()
class Adopt {
  const Adopt({
    required this.id,
    required this.price,
    required this.description,
    required this.status,
    required this.petId,
    required this.userId,
    this.pet,
  });
  final String? id;
  final double? price;
  final String? description;
  final String? status;
  final String? petId;
  final String? userId;
  final PetRes? pet;
  @override
  List<Object?> get props =>
      [id, price, description, status, pet?.props.toString()];
  factory Adopt.fromJson(Map<String, dynamic> json) => _$AdoptFromJson(json);

  Map<String, dynamic> toJson() => _$AdoptToJson(this);
}
