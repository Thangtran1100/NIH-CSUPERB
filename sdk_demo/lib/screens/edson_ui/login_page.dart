import 'package:flutter/material.dart';
import 'package:sdk_demo/utilities/color_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // This belongs to the border.
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 15, right: 10, left: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kDarkBlue,
                    width: 5,
                  ),
                ),
              ),
            ),
          ),
          // This is that invisible rectangle at the top left.
          Positioned(
            top: 28,
            left: -100,
            child: Container(
              height: 175,
              width: 175,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          // This is that invisible rectangle at the bottom right.
          Positioned(
            bottom: -45,
            right: -13,
            child: Container(
              height: 175,
              width: 175,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          // This is for the blue ball-top left.
          Positioned(
            top: 30.0,
            left: -40.0,
            child: Container(
              height: 125,
              width: 125,
              decoration: BoxDecoration(
                color: kDarkBlue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
            ),
          ),
          // This is for the beige ball-top left.
          Positioned(
            top: 100.0,
            left: -40.0,
            child: Container(
              height: 95,
              width: 95,
              decoration: BoxDecoration(
                color: kBeige,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
            ),
          ),
          // This is for the blue ball-bottom right.
          Positioned(
            bottom: -80.0,
            right: -80.0,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: kDarkBlue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
            ),
          ),
          // This is for the beige ball-bottom right.
          Positioned(
            bottom: -50.0,
            right: 50.0,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: kBeige,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
            ),
          ),
          // This belongs to the car logo.
          Positioned(
            top: 50.0,
            right: 67,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color.fromARGB(255, 103, 139, 183),
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/images/car-road-logo.png',
                        height: 280,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Login Text
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 320),
              child: Column(
                children: [
                  Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          // Email Text
          Padding(
            padding: const EdgeInsets.only(top: 400, left: 76),
            child: SizedBox(
              height: 70,
              width: 250,
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'EMAIL',
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // Password Text
          Padding(
            padding: const EdgeInsets.only(top: 490, left: 76),
            child: SizedBox(
              height: 70,
              width: 250,
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'PASSWORD',
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // Forgot Password?
          Padding(
            padding: const EdgeInsets.only(
              top: 555,
              left: 190,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // Login Button
          Padding(
            padding: const EdgeInsets.only(top: 600, left: 76),
            child: SizedBox(
              height: 60,
              width: 250,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: kLightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: kBabyBlue,
                  ),
                ),
              ),
            ),
          ),
          // Sign Up Action
          Padding(
            padding: const EdgeInsets.only(top: 675, left: 93),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
