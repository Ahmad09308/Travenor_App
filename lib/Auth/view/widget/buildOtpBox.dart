// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget buildOtpBox() {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(247, 247, 249, 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: InputDecoration(
        border: InputBorder.none,
        counterText: '',
      ),
    ),
  );
}
