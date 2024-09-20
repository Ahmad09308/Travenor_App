import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/widget/custom_bottom_navigation_bar.dart';
import 'package:travenor_app/Auth/view/widget/destination_card.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavigationBar(), // استدعاء المكون الجديد
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/user.jpg'), // صورة المستخدم
                        radius: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Leonardo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                  ),
                ],
              ),
              SizedBox(height: 30),

              RichText(
                text: TextSpan(
                  text: 'Explore the ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Beautiful ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'world!',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Destination',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('View all'),
                  ),
                ],
              ),
              SizedBox(height: 20),


              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DestinationCard(
                      imageUrl: 'assets/destination1.jpg',
                      title: 'Niladri Reservoir',
                      location: 'Tekergat, Sunamgonj',
                      rating: 4.7,
                    ),
                    DestinationCard(
                      imageUrl: 'assets/destination2.jpg',
                      title: 'Darmaghar Lake',
                      location: 'Darmaghar, India',
                      rating: 4.8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
