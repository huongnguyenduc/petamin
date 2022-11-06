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
      this.description});

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

  @override
  List<Object?> get props =>
      [id, name, month, year, gender, breed, isNeuter, avatarUrl, weight, description];

  factory PetRes.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  Map<String, dynamic> toJson() => _$PetToJson(this);
}
