
import 'package:flutter/material.dart';

Widget buildCheckEmailDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    content: const SizedBox(
      height: 250, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            Icons.email,
            size: 50,
            color: Color(0xFF007BFF),
          ),
          SizedBox(height: 20),


          Text(
            'Check your email',
            style: TextStyle(
              fontFamily: 'SF UI Display',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),


          Text(
            'We have sent password recovery\ninstructions to your email',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SF UI Display',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
  );
}
