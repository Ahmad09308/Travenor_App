import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/pages/Forgot_Password_page.dart';
import 'package:travenor_app/Auth/view/pages/home_page.dart';
import 'package:travenor_app/Auth/view/pages/sing_up.dart';
import 'package:travenor_app/Auth/view/widget/button.dart'; 
import 'package:travenor_app/Auth/view/widget/text_input_field.dart'; 
import 'package:travenor_app/Auth/view/widget/social_media_icons.dart'; 
class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
                'Sign in now',
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
                'Please sign in to continue our app',
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
            const TextInputField(
              hintText: 'Password',
              obscureText: true,
              suffixIcon: Icon(Icons.visibility_off),
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
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: 'SF UI Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(13, 110, 253, 1),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomButton(
                text: 'Sign In',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          fontFamily: 'SF UI Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          fontFamily: 'SF UI Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(13, 110, 253, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Or connect',
                style: TextStyle(
                  fontFamily: 'SF UI Display',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SocialMediaIcons(),
          ],
        ),
      ),
    );
  }
}
