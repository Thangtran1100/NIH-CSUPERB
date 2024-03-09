import 'package:flutter/material.dart';
import 'package:sdk_demo/screens/authenticate/roleSelectionScreen.dart';
import 'package:sdk_demo/utilities/colors.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 320),
              child: Column(
                children: [
                  Text(
                    'Welcome to AppName!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please login or sign up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 505, left: 76),
            child: SizedBox(
              height: 70,
              width: 250,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoleSelectionScreen(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: kLightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kBabyBlue,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 610, left: 76),
            child: SizedBox(
              height: 70,
              width: 250,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoleSelectionScreen(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: kLightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: kBabyBlue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
