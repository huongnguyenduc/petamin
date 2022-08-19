import 'package:flutter/material.dart';

const _avatarSize = 102.0;

class SquaredAvatar extends StatelessWidget {
  const SquaredAvatar({super.key, this.photo});

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
          ? const Icon(Icons.person_outline, size: _avatarSize)
          : null,
    );
  }
}
