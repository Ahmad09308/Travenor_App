import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/Auth/view/pages/home_page.dart';
import 'package:travenor_app/Auth/view/pages/sing_in_page.dart';
import 'package:travenor_app/Auth/view/widget/button.dart';
import 'package:travenor_app/Auth/view/widget/text_input_field.dart';
import 'package:travenor_app/Auth/view/widget/social_media_icons.dart';
import 'package:travenor_app/core/bloc/auth_bloc/auth_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUpButtonPressed() {
    FocusScope.of(context).unfocus(); // Dismiss keyboard
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      if (_passwordController.text.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password must be at least 8 characters long.')),
        );
        return;
      }
      context.read<AuthBloc>().add(SignUpRequested(
            name: _nameController.text,
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 20),
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
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Sign up now',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Please fill the details and create account',
                  style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 30),
              TextInputField(
                controller: _nameController,
                hintText: 'Name',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
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
                onSubmitted: (_) => _onSignUpButtonPressed(),
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
              Padding( // Changed Row to Padding for simpler text display
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Password must be 8 characters or more',
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return CustomButton(
                      text: 'Sign Up',
                      onPressed: _onSignUpButtonPressed,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement( // Use pushReplacement to avoid stacking auth pages
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                        ),
                        TextSpan(
                          text: 'Sign in',
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
              const SizedBox(height: 20), // Adjusted spacing
              Center(
                child: Text(
                  'Or connect',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 16), // Adjusted spacing
              const SocialMediaIcons(),
              const SizedBox(height: 20), // Padding at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
