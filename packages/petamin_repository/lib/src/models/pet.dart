import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet.g.dart';

@JsonSerializable()
class Pet extends Equatable {
  const Pet({
    required this.id,
    required this.name,
    required this.month,
    required this.year,
    required this.gender,
    required this.breed,
    required this.isNeuter,
    required this.avatarUrl,
    required this.weight,
    required this.description,
    required this.photos,
    required this.species,
    required this.isAdopting,
  });

  final String? id;
  final String? name;
  final int? month;
  final int? year;
  final String? gender;
  final String? breed;
  final bool? isNeuter;
  final String? avatarUrl;
  final double? weight;
  final String? description;
  final String? species;
  final List<Images>? photos;
  final isAdopting;
  static const empty = Pet(
      id: '',
      name: '',
      month: 0,
      year: 0,
      gender: '',
      breed: '',
      isNeuter: false,
      avatarUrl: '',
      weight: 0,
      description: '',
      photos: [],
      species: '',
      isAdopting: false);

  @override
  List<Object?> get props => [
        id,
        name,
        month,
        year,
        gender,
        breed,
        isNeuter,
        avatarUrl,
        weight,
        description
      ];

  Pet copyWith({
    String? id,
    String? name,
    int? month,
    int? year,
    String? gender,
    String? breed,
    bool? isNeuter,
    String? avatarUrl,
    double? weight,
    String? description,
    String? species,
    List<Images>? photos,
    bool? isAdopting,
  }) =>
      Pet(
          id: name ?? this.name,
          name: name ?? this.name,
          month: month ?? this.month,
          year: year ?? this.year,
          gender: gender ?? this.gender,
          breed: breed ?? this.breed,
          isNeuter: isNeuter ?? this.isNeuter,
          avatarUrl: avatarUrl ?? this.avatarUrl,
          weight: weight ?? this.weight,
          description: description ?? this.description,
          species: species ?? this.species,
          photos: photos ?? this.photos,
          isAdopting: isAdopting ?? this.isAdopting);
  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

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

