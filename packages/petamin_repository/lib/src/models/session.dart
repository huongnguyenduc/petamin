import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session extends Equatable {
  const Session({
    required this.accessToken,
    required this.userId,
  });

  final String accessToken;
  final String userId;

  /// Empty user which represents an unauthenticated user.
  static const empty = Session(accessToken: '', userId: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Session.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Session.empty;

  @override
  List<Object> get props => [accessToken, userId];

  Session copyWith({
    String? accessToken,
    String? userId,
  }) =>
      Session(
        accessToken: accessToken ?? this.accessToken,
        userId: userId ?? this.userId,
      );

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
