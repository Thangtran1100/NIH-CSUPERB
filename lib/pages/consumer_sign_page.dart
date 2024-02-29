import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'home_page.dart';

class ConsumerSignUpPage extends StatefulWidget {
  const ConsumerSignUpPage({Key? key}) : super(key: key);

  @override
  State<ConsumerSignUpPage> createState() => _ConsumerSignUpPage();
}

class _ConsumerSignUpPage extends State<ConsumerSignUpPage> {
  String? email;

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            // Here we add the button to wherever this is going.
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ),),
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 130,
                  ),
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
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        // Check for a valid email format using a regular expression
                        if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null; // Return null for valid input
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      controller: _password,
                      obscureText: false,
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
                      controller: _confirmpassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'CONFIRM PASSWORD',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please re-enter password';
                        }
                        if (_password.text != _confirmpassword.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  FlutterPwValidator(
                      width: 300,
                      height: 100,
                      minLength: 9,
                      uppercaseCharCount: 1,
                      specialCharCount: 1,
                      numericCharCount: 2,
                      onSuccess: () {},
                      controller: _password),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          print("Yes");
                        } else {
                          print("No");
                        }
                      },
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
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_pw_validator/flutter_pw_validator.dart';

// import 'home_page.dart';

// class ConsumerSignUpPage extends StatefulWidget {
//   const ConsumerSignUpPage({Key? key}) : super(key: key);

//   @override
//   State<ConsumerSignUpPage> createState() => _ConsumerSignUpPage();
// }

// class _ConsumerSignUpPage extends State<ConsumerSignUpPage> {
//   final TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             // Here we add the button to wherever this is going.
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) => ),),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageNew()));
//             },
//             icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           ),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.person,
//                 size: 130,
//               ),
//               const Text(
//                 'Sign Up',
//                 style: TextStyle(
//                     //fontWeight: FontWeight.bold,
//                     fontSize: 40,
//                     color: Colors.transparent, // Step 2 SEE HERE
//                     shadows: [
//                       Shadow(offset: Offset(0, -5), color: Colors.black)
//                     ], // Step 3 SEE HERE
//                     decoration: TextDecoration.underline,
//                     //decorationStyle: TextDecorationStyle.dashed,
//                     decorationColor: Color.fromARGB(255, 34, 114, 218),
//                     //decoration: TextDecoration.underline,
//                     decorationThickness: 1),
//               ),
//               const Text(
//                 'Consumer Portal',
//               ),
//               const SizedBox(
//                 height: 100,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'EMAIL ADDRESS',
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: TextFormField(
//                   controller: _controller,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     hintText: 'PASSWORD',
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: TextFormField(
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     hintText: 'CONFIRM PASSWORD',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               FlutterPwValidator(
//                   width: 300,
//                   height: 100,
//                   minLength: 9,
//                   uppercaseCharCount: 1,
//                   specialCharCount: 1,
//                   numericCharCount: 2,
//                   onSuccess: () {},
//                   controller: _controller),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: 350,
//                 child: FilledButton(
//                   onPressed: () {},
//                   style: FilledButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 25, 91, 177),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                   child: const Text(
//                     'CREATE ACCOUNT',
//                     style: TextStyle(fontSize: 15, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ConsumerSignUp extends StatefulWidget {
//   const ConsumerSignUp({super.key});
//   @override
//   State<ConsumerSignUp> createState() => _ConsumerSignUpState();
// }

// class _ConsumerSignUpState extends State<ConsumerSignUp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.person,
//                 size: 130,
//               ),
//               const Text(
//                 'Sign Up',
//                 style: TextStyle(
//                     //fontWeight: FontWeight.bold,
//                     fontSize: 40,
//                     color: Colors.transparent, // Step 2 SEE HERE
//                     shadows: [
//                       Shadow(offset: Offset(0, -5), color: Colors.black)
//                     ], // Step 3 SEE HERE
//                     decoration: TextDecoration.underline,
//                     //decorationStyle: TextDecorationStyle.dashed,
//                     decorationColor: Color.fromARGB(255, 92, 117, 166),
//                     //decoration: TextDecoration.underline,
//                     decorationThickness: 1),
//               ),
//               const Text(
//                 'Consumer Portal',
//               ),
//               const SizedBox(
//                 height: 100,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'EMAIL ADDRESS',
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: TextFormField(
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     hintText: 'PASSWORD',
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: TextFormField(
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     hintText: 'CONFIRM PASSWORD',
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 100,
//               ),
//               SizedBox(
//                 width: 350,
//                 child: FilledButton(
//                   onPressed: () {},
//                   style: FilledButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 92, 117, 166),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                   child: const Text(
//                     'CREATE ACCOUNT',
//                     style: TextStyle(fontSize: 15, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
