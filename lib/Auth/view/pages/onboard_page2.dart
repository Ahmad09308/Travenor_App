import 'package:flutter/material.dart';

class OnboardPage2 extends StatelessWidget {
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
            'assets/images/onboard2.png',
            width: 375,
            height: 350,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'It’s a big world out there go ',
                  style: TextStyle(
                    fontFamily: 'Geometr415',
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'explore',
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
        ),
        Row(
          children: [
            const SizedBox(width: 180),
            Image.asset(
              'assets/images/a2.png',
              cacheWidth: 400,
            ),
            const SizedBox(width: 20),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
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
