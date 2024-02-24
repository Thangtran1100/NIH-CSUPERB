import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.medical_information_outlined,
                size: 100,

              ),
              // Container(
              //   width: 150,
              //   height: 150,
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Color.fromARGB(255, 255, 255, 255),
              //   ),
              //   child: Center(
              //     child: Image.asset(
              //       'assets/doctor.jpg',
              //       height: 100,
              //     ),
              //   ),
              // ),
              //const SizedBox(height: 5,),
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
                    decorationColor: Color.fromARGB(255, 2, 80, 168),
                    //decoration: TextDecoration.underline,
                    decorationThickness: 1),
              ),
              const Text(
                'Physician Portal',
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'FIRST NAME',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'LAST NAME',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'EMAIL',
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
                height: 40,
              ),
              SizedBox(
                width: 350,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 1, 41, 87),
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
