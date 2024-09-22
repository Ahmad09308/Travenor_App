import 'package:flutter/material.dart';

class OnboardPage1 extends StatelessWidget {
  const OnboardPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Image.asset(
            'assets/images/onboard1.png',
            width: 375,
            height: 350,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Life is short and the world is ',
                style: TextStyle(
                  fontFamily: 'Geometr415',
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'wide',
                style: TextStyle(
                  fontFamily: 'Geometr415',
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  color: Color.fromRGBO(255, 112, 41, 1),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 195),
            Image.asset(
              'assets/images/a.png',
              cacheWidth: 400,
            ),
            const SizedBox(width: 50),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'At Friends tours and travel, we customize reliable and trustworthy educational tours to destinations all over the world.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Gill Sans MT',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
