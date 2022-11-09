import 'package:json_annotation/json_annotation.dart';

part 'petRes.g.dart';

@JsonSerializable()
class PetRes {
  PetRes(
      {this.id,
      this.name,
      this.month,
      this.year,
      this.gender,
      this.breed,
      this.isNeuter,
      this.avatarUrl,
      this.weight,
      this.description,
      this.photos,
      this.species});

  String? id;
  String? name;
  int? month;
  int? year;
  String? gender;
  String? breed;
  bool? isNeuter;
  String? avatarUrl;
  double? weight;
  String? description;
  final String? species;
  final List<Images>? photos;

  @override
  List<Object?> get props => [id, name, month, year, gender, breed, isNeuter, avatarUrl, weight, description];

  factory PetRes.fromJson(Map<String, dynamic> json) => _$PetResFromJson(json);

  Map<String, dynamic> toJson() => _$PetResToJson(this);
}

class Images {
  Images({
    required this.id,
    required this.imgUrl,
  });

  final String id;
  final String imgUrl;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imgUrl": imgUrl,
      };
}
