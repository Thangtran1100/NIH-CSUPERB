import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 130,),
              //Container(
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: const Color.fromARGB(255, 255, 255, 255),
              //       border: Border.all(
              //         color: Colors.white,
              //         width: 5.0,
              //       )),
              //   child: Center(
              //     child: Image.asset(
              //       'assets/consumer.jpeg',
              //       height: 100,
              //     ),
              //   ),
              // ),
              //const SizedBox(height: 5,),
              //const SizedBox(height: 0,),
              const Text(
                'Sign Up',
                style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.transparent, // Step 2 SEE HERE
                    shadows: [
                      Shadow(offset: Offset(0, -5), color: Colors.black)
                    ], // Step 3 SEE HERE
                    decoration: TextDecoration.underline,
                    //decorationStyle: TextDecorationStyle.dashed,
                    decorationColor: Color.fromARGB(255, 34, 114, 218),
                    //decoration: TextDecoration.underline,
                    decorationThickness: 1),
              ),
              const Text(
                'Consumer Portal',
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'EMAIL ADDRESS',
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 40.0),
              //   child: TextFormField(
              //     decoration: const InputDecoration(
              //       hintText: 'USERNAME',
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 40.0),
              //   child: TextFormField(
              //     decoration: const InputDecoration(
              //       hintText: 'EMAIL',
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'PASSWORD',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'CONFIRM PASSWORD',
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 350,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 25, 91, 177),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
