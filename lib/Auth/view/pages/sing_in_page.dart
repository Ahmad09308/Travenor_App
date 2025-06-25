import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/Auth/view/pages/Forgot_Password_page.dart';
import 'package:travenor_app/Auth/view/pages/home_page.dart';
import 'package:travenor_app/Auth/view/pages/sing_up.dart';
import 'package:travenor_app/Auth/view/widget/button.dart';
import 'package:travenor_app/Auth/view/widget/text_input_field.dart';
import 'package:travenor_app/Auth/view/widget/social_media_icons.dart';
import 'package:travenor_app/core/bloc/auth_bloc/auth_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInButtonPressed() {
    FocusScope.of(context).unfocus(); // Dismiss keyboard
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      context.read<AuthBloc>().add(SignInRequested(
            email: _emailController.text,
            password: _passwordController.text,
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: theme.scaffoldBackgroundColor, // Handled by theme
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // Increased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 20), // Respect safe area
              CircleAvatar(
                backgroundColor: theme.cardColor,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: theme.iconTheme.color,
                    size: 19,
                  ),
                  onPressed: () {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 30), // Adjusted spacing
              Center(
                child: Text(
                  'Sign in now',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Please sign in to continue our app',
                  style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 30), // Adjusted spacing
              TextInputField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextInputField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _onSignInButtonPressed(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: theme.iconTheme.color?.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'SF UI Display', // Consider using theme text style
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return CustomButton(
                      text: 'Sign In',
                      onPressed: _onSignInButtonPressed,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement( // Use pushReplacement if SignIn is on top of SignUp
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don’t have an account? ',
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Or connect',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 20),
              const SocialMediaIcons(), // Assuming this widget is theme-aware or uses neutral colors
              const SizedBox(height: 20), // Padding at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
