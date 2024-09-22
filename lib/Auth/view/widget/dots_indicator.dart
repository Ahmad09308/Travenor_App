import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final PageController controller;
  final int itemCount;
  final int currentPage;

  const DotsIndicator({super.key, 
    required this.controller,
    required this.itemCount,
    required this.currentPage,
  });

  Widget _buildDot(int index) {
    double width = index == currentPage
        ? 35
        : index == (currentPage + 1) % itemCount
            ? 13
            : 6;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: width,
      height: 7,
      decoration: BoxDecoration(
        color: index == currentPage ? Colors.blue : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) => _buildDot(index)),
    );
  }
}
