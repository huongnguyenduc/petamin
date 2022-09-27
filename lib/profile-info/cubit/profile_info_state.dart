part of 'profile_info_cubit.dart';

class ProfileInfoState extends Equatable {
  const ProfileInfoState(
      {this.name = "Cristiano Ronaldo",
      this.phoneNumber = "058989898989",
      this.address = "My Tho, Viet Nam",
      this.email = "buiminhhuyqnam@gmail.com",
      this.dayOfBirth = "20/10/2001",
      this.bio = "A football player"});

  final String name;
  final String bio;
  final String email;
  final String dayOfBirth;
  final String address;
  final String phoneNumber;

  @override
  List<Object> get props => [
        name,
        phoneNumber,
        address,
        email,
        dayOfBirth,
        bio,
      ];

  ProfileInfoState copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    String? email,
    String? dayOfBirth,
    String? bio,
  }) {
    return ProfileInfoState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      email: email ?? this.email,
      dayOfBirth: dayOfBirth ?? this.dayOfBirth,
      bio: bio ?? this.bio,
    );
  }
}
