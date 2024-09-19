// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/pages/onboard_page1.dart';
import 'package:travenor_app/Auth/view/pages/onboard_page2.dart';
import 'package:travenor_app/Auth/view/pages/onboard_page3.dart';
import 'package:travenor_app/Auth/view/pages/sing_in_page.dart';
import 'package:travenor_app/Auth/view/widget/button.dart';
import 'package:travenor_app/Auth/view/widget/dots_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int currentPage = 0;

  final List<Widget> pages = [
    OnboardPage1(),
    OnboardPage2(),
    OnboardPage3(),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),

          DotsIndicator(
            controller: pageController,
            itemCount: pages.length,
            currentPage: currentPage,
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomButton(
              text: currentPage == 0 ? 'Get Started' : 'Next',
              onPressed: () {
                if (currentPage < pages.length - 1) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
