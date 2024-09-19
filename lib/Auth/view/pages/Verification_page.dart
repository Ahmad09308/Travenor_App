// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/widget/buildOtpBox.dart';
import 'package:travenor_app/Auth/view/widget/button.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => OtpVerificationState();
}

class OtpVerificationState extends State<OtpVerification> {
  int start = 60;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (start > 0) {
          start--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                'OTP Verification',
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
                'Please check your email www.uihut@gmail.com to see the verification code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SF UI Display',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'OTP Code',
              style: TextStyle(
                fontFamily: 'SF UI Display',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildOtpBox(),
                buildOtpBox(),
                buildOtpBox(),
                buildOtpBox(),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: CustomButton(
                text: 'Verify',
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Resend code to ',
                  style: TextStyle(
                    fontFamily: 'SF UI Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '00:${start.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontFamily: 'SF UI Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
