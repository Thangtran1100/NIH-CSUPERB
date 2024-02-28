import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:senior_appv1/pages/home_page.dart';
import 'package:senior_appv1/utilities/color.dart';

// void main() {
//   runApp(const MyApp());
// }

class PhysicianSignUp extends StatefulWidget {
  const PhysicianSignUp({Key? key}) : super(key: key);
  @override
  State<PhysicianSignUp> createState() => _PhysicianSignUp();
}

class _PhysicianSignUp extends State<PhysicianSignUp> {
  String? email;

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            // Here we add the button to wherever this is going.
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ),),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePageNew()));
            },
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
                    Icons.medical_information_outlined,
                    size: 100,
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
                        decorationColor: Color.fromARGB(255, 26, 43, 78),
                        //decoration: TextDecoration.underline,
                        decorationThickness: 1),
                  ),
                  const Text(
                    'Physician Portal',
                  ),
                  const SizedBox(
                    height: 25,
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
                      controller: _password,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'EMAIL',
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
                  // const SizedBox(
                  //   height: 1,
                  // ),
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
                        backgroundColor: Color.fromARGB(255, 26, 43, 78),
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
            // mainAxisAlignment: MainAxisAlignment.center,
            // children: [
            //   Icon(
            //     Icons.medical_information_outlined,
            //     size: 100,
            //   ),
            //   const Text(
            //     'Sign Up',
            //     style: TextStyle(
            //         //fontWeight: FontWeight.bold,
            //         fontSize: 40,
            //         color: Colors.transparent, // Step 2 SEE HERE
            //         shadows: [
            //           Shadow(offset: Offset(0, -5), color: Colors.black)
            //         ], // Step 3 SEE HERE
            //         decoration: TextDecoration.underline,
            //         //decorationStyle: TextDecorationStyle.dashed,
            //         decorationColor: Color.fromARGB(255, 26, 43, 78),
            //         //decoration: TextDecoration.underline,
            //         decorationThickness: 1),
            //   ),
            //   const Text(
            //     'Physician Portal',
            //   ),
            //   const SizedBox(
            //     height: 50,
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 40.0),
            //     child: TextFormField(
            //       decoration: const InputDecoration(
            //         hintText: 'FIRST NAME',
            //       ),
            //     ),
            //   ),
            //   const SizedBox(
            //     height: 20,
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 40.0),
            //     child: TextFormField(
            //       decoration: const InputDecoration(
            //         hintText: 'LAST NAME',
            //       ),
            //     ),
            //   ),
            //   const SizedBox(
            //     height: 20,
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 40.0),
            //     child: TextFormField(
            //       decoration: const InputDecoration(
            //         hintText: 'EMAIL',
            //       ),
            //     ),
            //   ),
            //   const SizedBox(
            //     height: 20,
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 40.0),
            //     child: TextFormField(
            //       obscureText: true,
            //       decoration: const InputDecoration(
            //         hintText: 'PASSWORD',
            //       ),
            //     ),
            //   ),
            //   const SizedBox(
            //     height: 20,
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 40.0),
            //     child: TextFormField(
            //       obscureText: true,
            //       decoration: const InputDecoration(
            //         hintText: 'CONFIRM PASSWORD',
            //       ),
            //     ),
            //   ),
            //   const SizedBox(height: 5),
            //   FlutterPwValidator(
            //       width: 300,
            //       height: 100,
            //       minLength: 9,
            //       uppercaseCharCount: 1,
            //       specialCharCount: 1,
            //       numericCharCount: 2,
            //       onSuccess: () {},
            //       controller: _controller),
            //   // const SizedBox(
            //   //   height: 1,
            //   // ),
            //   SizedBox(
            //     width: 350,
            //     child: FilledButton(
            //       onPressed: () {},
            //       style: FilledButton.styleFrom(
            //         backgroundColor: Color.fromARGB(255, 26, 43, 78),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10)),
            //       ),
            //       child: const Text(
            //         'CREATE ACCOUNT',
            //         style: TextStyle(fontSize: 15, color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ],
          ),
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     theme: ThemeData(
  //         scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
  //     home: Scaffold(
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(
  //               Icons.medical_information_outlined,
  //               size: 100,

  //             ),
  //             // Container(
  //             //   width: 150,
  //             //   height: 150,
  //             //   decoration: const BoxDecoration(
  //             //     shape: BoxShape.circle,
  //             //     color: Color.fromARGB(255, 255, 255, 255),
  //             //   ),
  //             //   child: Center(
  //             //     child: Image.asset(
  //             //       'assets/doctor.jpg',
  //             //       height: 100,
  //             //     ),
  //             //   ),
  //             // ),
  //             //const SizedBox(height: 5,),
  //             const Text(
  //               'Sign Up',
  //               style: TextStyle(
  //                   //fontWeight: FontWeight.bold,
  //                   fontSize: 40,
  //                   color: Colors.transparent, // Step 2 SEE HERE
  //                   shadows: [
  //                     Shadow(offset: Offset(0, -5), color: Colors.black)
  //                   ], // Step 3 SEE HERE
  //                   decoration: TextDecoration.underline,
  //                   //decorationStyle: TextDecorationStyle.dashed,
  //                   decorationColor: Color.fromARGB(255, 26, 43, 78),
  //                   //decoration: TextDecoration.underline,
  //                   decorationThickness: 1),
  //             ),
  //             const Text(
  //               'Physician Portal',
  //             ),
  //             const SizedBox(
  //               height: 50,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 40.0),
  //               child: TextFormField(
  //                 decoration: const InputDecoration(
  //                   hintText: 'FIRST NAME',
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 40.0),
  //               child: TextFormField(
  //                 decoration: const InputDecoration(
  //                   hintText: 'LAST NAME',
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 40.0),
  //               child: TextFormField(
  //                 decoration: const InputDecoration(
  //                   hintText: 'EMAIL',
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 40.0),
  //               child: TextFormField(
  //                 obscureText: true,
  //                 decoration: const InputDecoration(
  //                   hintText: 'PASSWORD',
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 40.0),
  //               child: TextFormField(
  //                 obscureText: true,
  //                 decoration: const InputDecoration(
  //                   hintText: 'CONFIRM PASSWORD',
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 40,
  //             ),
  //             SizedBox(
  //               width: 350,
  //               child: FilledButton(
  //                 onPressed: () {},
  //                 style: FilledButton.styleFrom(
  //                   backgroundColor: Color.fromARGB(255, 26, 43, 78),
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(10)),
  //                 ),
  //                 child: const Text(
  //                   'CREATE ACCOUNT',
  //                   style: TextStyle(fontSize: 15, color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
//}