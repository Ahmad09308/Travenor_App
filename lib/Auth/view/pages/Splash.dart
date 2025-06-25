// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Using Theme.of(context) to make the splash screen theme-aware.
    // For a splash screen, you might want specific colors regardless of theme,
    // or adapt it like this. The primaryColor is used for background,
    // and a contrasting color (like white or a light shade from the theme) for text.

    final theme = Theme.of(context);
    Color backgroundColor;
    Color textColor;

    if (theme.brightness == Brightness.dark) {
      // Dark theme splash: maybe a dark primary or specific dark color
      backgroundColor = theme.primaryColorDark; // Or a custom dark splash color
      textColor = Colors.white; // Ensure text is visible
    } else {
      // Light theme splash
      backgroundColor = theme.primaryColor; // As it was originally
      textColor = Colors.white; // Original text color
    }

    // If the splash screen should always be the brand's primary color:
    // backgroundColor = const Color.fromRGBO(13, 110, 253, 1);
    // textColor = Colors.white;
    // In this case, the theme changes below are not strictly necessary for colors,
    // but it's good practice to use Theme.of(context) for text styles if possible.

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Travenor',
              style: TextStyle(
                fontFamily: 'Geometr415',
                fontSize: 34,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
