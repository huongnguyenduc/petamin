import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session extends Equatable {
  const Session({
    required this.accessToken,
  });

  final String accessToken;

  /// Empty user which represents an unauthenticated user.
  static const empty = Session(accessToken: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Session.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Session.empty;

  @override
  List<Object> get props => [accessToken];

  Session copyWith({
    String? accessToken,
  }) =>
      Session(
        accessToken: accessToken ?? this.accessToken,
      );

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
