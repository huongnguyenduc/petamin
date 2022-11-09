import 'dart:ffi';

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
      this.speciesId,
      this.species = Species.empty});

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
  String? speciesId;
  final Species species;
  final List<Images>? photos;
  @override
  List<Object?> get props =>
      [id, name, month, year, gender, breed, isNeuter, avatarUrl, weight, description];

  factory PetRes.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  Map<String, dynamic> toJson() => _$PetToJson(this);
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

class Species {
  const Species({
    required this.id,
    required this.name,
    required this.imgUrl,
  });
  final String id;
  final String name;
  final String imgUrl;

   static const empty =  Species(
      id: '', name: '', imgUrl: '');

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        id: json["id"],
        name: json["name"],
        imgUrl: json["imgUrl"],
      );
 

  Map<String, dynamic> toJson() => {
        "id": id,
        "petId": name,
        "imgUrl": imgUrl,
      };
}
