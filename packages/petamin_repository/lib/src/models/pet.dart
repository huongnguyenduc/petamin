import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet.g.dart';

@JsonSerializable()
class Pet extends Equatable {
  const Pet({
    this.id,
    this.userId,
    this.name,
    this.month,
    this.year,
    this.gender,
    this.breed,
    this.isNeuter,
    this.avatarUrl,
    this.avatar,
    this.weight,
    this.description,
    this.photos,
    this.species,
    this.isAdopting,
  });

  final String? id;
  final String? userId;
  final String? name;
  final int? month;
  final int? year;
  final String? gender;
  final String? breed;
  final bool? isNeuter;
  final String? avatarUrl;

  final File? avatar;
  final double? weight;
  final String? description;
  final String? species;
  final List<Images>? photos;
  final bool? isAdopting;
  static const empty = Pet(
      id: '',
      userId: '',
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
  List<Object?> get props =>
      [id, userId, name, month, year, gender, avatar, breed, isNeuter, avatarUrl, weight, description];

  Pet copyWith({
    String? id,
    String? userId,
    String? name,
    int? month,
    int? year,
    String? gender,
    String? breed,
    bool? isNeuter,
    String? avatarUrl,
    File? avatar,
    double? weight,
    String? description,
    String? species,
    List<Images>? photos,
    bool? isAdopting,
  }) =>
      Pet(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          name: name ?? this.name,
          month: month ?? this.month,
          year: year ?? this.year,
          gender: gender ?? this.gender,
          breed: breed ?? this.breed,
          isNeuter: isNeuter ?? this.isNeuter,
          avatarUrl: avatarUrl ?? this.avatarUrl,
          avatar: avatar ?? this.avatar,
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
