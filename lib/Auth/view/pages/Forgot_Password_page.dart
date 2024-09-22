// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/pages/Verification_page.dart';
import 'package:travenor_app/Auth/view/widget/buildCheckEmailDialog.dart';
import 'package:travenor_app/Auth/view/widget/button.dart';
import 'package:travenor_app/Auth/view/widget/text_input_field.dart'; // زر تسجيل الدخول المخصص

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(247, 247, 249, 1),
                maxRadius: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 19,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),

            const Center(
              child: Text(
                'Forgot password',
                style: TextStyle(
                  fontFamily: 'SF UI Display',
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),

            const Center(
              child: Text(
                'Enter your email account to reset\n             your password',
                style: TextStyle(
                  fontFamily: 'SF UI Display',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 40),


            const TextInputField(
              hintText: 'Email',
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 20),


            Center(
              child: CustomButton(
                text: 'Reset Password',
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return buildCheckEmailDialog(context);
                      },
                    );

                    Future.delayed(const Duration(seconds: 5), () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const OtpVerification(),
                        ),
                      );
                    });
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
