import 'package:flutter/material.dart';

const _avatarSize = 100.0;

class PetAvatar extends StatelessWidget {
  const PetAvatar({super.key, this.photo});

  final String? photo;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: photo != null
            ? DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover)
            : null,
      ),
      width: _avatarSize,
      height: _avatarSize,
      child: photo == null
          ? const Icon(Icons.pets_rounded, size: _avatarSize)
          : null,
    );
  }
}
