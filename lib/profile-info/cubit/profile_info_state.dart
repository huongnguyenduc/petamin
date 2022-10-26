part of 'profile_info_cubit.dart';

enum ProfileStatus { initial, loading, success, failure }

extension ProfileStatusX on ProfileStatus {
  bool get isInitial => this == ProfileStatus.initial;
  bool get isLoading => this == ProfileStatus.loading;
  bool get isSuccess => this == ProfileStatus.success;
  bool get isFailure => this == ProfileStatus.failure;
}

class ProfileInfoState extends Equatable {
  const ProfileInfoState(
      {this.name = "John Doe",
      this.phoneNumber = "0123456789",
      this.status = ProfileStatus.initial,
      this.submitStatus = ProfileStatus.initial,
      this.address = "Ho CHi Minh, Viet Nam",
      this.email = "name@example.com",
      this.dayOfBirth = '2022-10-20 20:18:04Z',
      this.id = "",
      this.avatarUrl = "",
      this.avatar,
      this.bio = "I am a developer"});

  final String name;
  final String bio;
  final String email;
  final String dayOfBirth;
  final String address;
  final String phoneNumber;
  final ProfileStatus status;
  final ProfileStatus submitStatus;
  final String id;
  final String avatarUrl;
  final File? avatar;

  @override
  List<Object?> get props => [
        name,
        phoneNumber,
        address,
        email,
        dayOfBirth,
        bio,
        status,
        id,
        avatarUrl,
        avatar
      ];

  ProfileInfoState copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    String? email,
    String? dayOfBirth,
    String? bio,
    ProfileStatus? status,
    String? id,
    String? userId,
    ProfileStatus? submitStatus,
    String? avatarUrl,
    File? avatar,
  }) {
    return ProfileInfoState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      email: email ?? this.email,
      dayOfBirth: dayOfBirth ?? this.dayOfBirth,
      bio: bio ?? this.bio,
      status: status ?? this.status,
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      submitStatus: submitStatus ?? this.submitStatus,
    );
  }
}
