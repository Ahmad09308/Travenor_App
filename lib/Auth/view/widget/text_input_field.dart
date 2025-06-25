// text_input_field.dart
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  const TextInputField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.inputDecorationTheme.hintStyle,
        filled: true,
        // fillColor: theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surfaceVariant,
        // Using a slightly different approach for fill color to ensure it adapts well
        fillColor: theme.brightness == Brightness.light
                   ? const Color.fromRGBO(247, 247, 249, 1) // Original light mode color
                   : theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surfaceVariant, // Dark mode color from theme or a variant
        border: theme.inputDecorationTheme.border ?? const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide.none, // Default to none if not specified by theme
        ),
        enabledBorder: theme.inputDecorationTheme.enabledBorder ?? const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: theme.inputDecorationTheme.focusedBorder,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
