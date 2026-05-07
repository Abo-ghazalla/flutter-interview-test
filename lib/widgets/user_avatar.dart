import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.avatarUrl,
  }) : super(key: key);

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      avatarUrl,
      width: 32,
      height: 32,
      errorBuilder: (context, error, stackTrace) => FaIcon(FontAwesomeIcons.image,size: 32,),
    );
  }
}
