// social_media_icons.dart
import 'package:flutter/material.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/images/facebook.png'),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/images/instagram.png'),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/images/twitter.png'),
        ),
      ],
    );
  }
}
