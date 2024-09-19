import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/pages/sing_in_page.dart';
import 'package:travenor_app/Auth/view/widget/button.dart'; // زر تسجيل الدخول المخصص
import 'package:travenor_app/Auth/view/widget/text_input_field.dart'; // مكون الحقول
import 'package:travenor_app/Auth/view/widget/social_media_icons.dart'; // مكون الأيقونات

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
                'Sign up now',
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
                'Please fill the details and create account',
                style: TextStyle(
                  fontFamily: 'SF UI Display',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(125, 132, 141, 1),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const TextInputField(
              hintText: 'Name',
            ),
            const SizedBox(height: 16),
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
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Password must be 8 character',
                    style: TextStyle(
                      fontFamily: 'SF UI Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(125, 132, 141, 1),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Sign up',
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account ',
                        style: TextStyle(
                          fontFamily: 'SF UI Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign in',
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
