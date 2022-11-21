part of 'profile_info_cubit.dart';

enum ProfileStatus { initial, loading, success, failure }

extension ProfileStatusX on ProfileStatus {
  bool get isInitial => this == ProfileStatus.initial;
  bool get isLoading => this == ProfileStatus.loading;
  bool get isSuccess => this == ProfileStatus.success;
  bool get isFailure => this == ProfileStatus.failure;
}

class ProfileInfoState extends Equatable {
  ProfileInfoState({
    this.userId = '',
    this.name = '',
    this.phoneNumber = '',
    this.status = ProfileStatus.initial,
    this.submitStatus = ProfileStatus.initial,
    this.address = '',
    this.email = '',
    this.dayOfBirth = '2022-10-20 20:18:04Z',
    this.id = '',
    this.avatarUrl = ANONYMOUS_AVATAR,
    this.avatar,
    this.bio = '',
    this.followers = 0,
    this.followings = 0,
    this.pets = const [],
  });

  final String name;
  final String bio;
  final String email;
  final String dayOfBirth;
  final String address;
  final String phoneNumber;
  final ProfileStatus status;
  final ProfileStatus submitStatus;
  final String id;
  final String userId;
  final String avatarUrl;
  final File? avatar;
  int? followers;
  int? followings;
  List<Pet>? pets;
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
        avatar,
        userId,
        followers,
        followings,
        pets,
      ];

  ProfileInfoState copyWith({
    String? name,
    String? editName,
    String? phoneNumber,
    String? editPhoneNumber,
    String? address,
    String? editAddress,
    String? email,
    String? editEmail,
    String? dayOfBirth,
    String? editDayOfBirth,
    String? bio,
    String? editBio,
    ProfileStatus? status,
    String? id,
    String? userId,
    ProfileStatus? submitStatus,
    String? avatarUrl,
    File? avatar,
    int? followers,
    int? followings,
    List<Pet>? pets,
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
      userId: userId ?? this.userId,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      pets: pets ?? this.pets,
    );
  }
}
