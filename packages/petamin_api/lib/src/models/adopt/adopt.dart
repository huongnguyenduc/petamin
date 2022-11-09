
import 'package:json_annotation/json_annotation.dart';
part 'adopt.g.dart';
@JsonSerializable()
class Adopt  {
  const Adopt({
    required this.id,
    required this.price,
    required this.description,
    required this.status,
  });
  final String? id;
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
  factory Adopt.fromJson(Map<String, dynamic> json) => _$AdoptFromJson(json);

  Map<String, dynamic> toJson() => _$AdoptToJson(this);

}
