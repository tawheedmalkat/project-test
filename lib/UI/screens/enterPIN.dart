//import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:invoportapp/UI/screens/Interface.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class EnterPIN extends StatefulWidget {
//   @override
//   State<EnterPIN> createState() => _EnterPINState();
// }
//
// class _EnterPINState extends State<EnterPIN> {
//   List<TextEditingController> _pinControllers =
//   List.generate(4, (index) => TextEditingController());
//
//   int _attempts = 0;
//   final int _maxAttempts = 3; // Maximum allowed attempts
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 50,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Icon(
//                     Icons.lock_clock_rounded,
//                     color: Colors.lightBlue,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     "Enter your PIN",
//                     style: TextStyle(
//                         color: Colors.lightBlue,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 30, top: 10),
//                 child: Text(
//                   "Now enter PIN that you confirmed previously\nenter your PIN ****",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 height: 70,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 13.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(4, (index) => buildPinTextField(index)),
//                 ),
//               ),
//               Padding(
//                 padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
//                 child: Image.asset(
//                   "assets/images/security.png",
//                   height: MediaQuery.of(context).size.width * 0.3,
//                   width: MediaQuery.of(context).size.width * 0.7,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.13, left: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () async {
//                         String enteredPin =
//                         _pinControllers.map((controller) => controller.text).join();
//
//                         if (enteredPin.length == 4) {
//                           // Retrieve the saved PIN from SharedPreferences
//                           SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                           String savedPin = prefs.getString('pin') ?? "";
//
//                           if (enteredPin == savedPin) {
//                             // PIN is correct, show success dialog
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("Success"),
//                                   content: Text("You have successfully entered the PIN."),
//                                   actions: [
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         // Navigate to the next screen or perform any other action
//                                         Get.off(() => Interface());
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         primary: Colors.blue,
//                                       ),
//                                       child: Text("OK", style: TextStyle(color: Colors.white)),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           } else {
//                             // Incorrect PIN, show error message
//                             _attempts++;
//                             if (_attempts < _maxAttempts) {
//                               // Show error dialog
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: Text("Error"),
//                                     content: Text("Incorrect PIN. Please try again."),
//                                     actions: [
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           // Close the dialog
//                                           Navigator.pop(context);
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           primary: Colors.red,
//                                         ),
//                                         child: Text("OK", style: TextStyle(color: Colors.white)),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             } else {
//                               // Exceeded maximum attempts, navigate back to the login screen
//                               Navigator.pop(context);
//                             }
//                           }
//                         } else {
//                           // Show an error message or handle invalid PIN
//                           print("Invalid PIN. Please try again.");
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.green,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         elevation: 3.0,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Text(
//                           'Enter your PIN',
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPinTextField(int index) {
//     return SizedBox(
//       height: 68,
//       width: 64,
//       child: TextFormField(
//         obscureText: true,
//         controller: _pinControllers[index],
//         onChanged: (value) {
//           if (value.length == 1) {
//             // Move focus to the next TextFormField
//             if (index < 3) {
//               FocusScope.of(context).nextFocus();
//             }
//           }
//         },
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue),
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//         ),
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Interface.dart';

class EnterPIN extends StatefulWidget {
  @override
  State<EnterPIN> createState() => _EnterPINState();
}

class _EnterPINState extends State<EnterPIN> {
  List<TextEditingController> _pinControllers =
      List.generate(4, (index) => TextEditingController());

  int _attempts = 0;
  int _maxAttempts = 3; // Maximum allowed attempts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.lock_clock_rounded,
                    color: Colors.lightBlue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Enter your PIN",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 30, top: 10),
                child: Text(
                  "To maintain the privacy of your information\nenter your PIN ****",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      List.generate(4, (index) => buildPinTextField(index)),

                ),

              ),




              Image.asset(
                "assets/images/security.png",
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        String enteredPin = _pinControllers
                            .map((controller) => controller.text)
                            .join();

                        if (enteredPin.length == 4) {
                          // Retrieve the saved PIN from SharedPreferences
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String savedPin = prefs.getString('pin') ?? "";

                          if (enteredPin == savedPin) {
                            Get.to(Interface());
                            // PIN is correct, show success dialog

                          } else {
                            // Incorrect PIN, show error message
                            _attempts++;

                            if (_attempts < _maxAttempts) {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Incorrect PIN. Please try again. Attempts: $_attempts",style: TextStyle(color:Colors.red,),),
                                  backgroundColor: Colors.white,
                                ),
                              );
                              // Show error dialog
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                        "Incorrect PIN. Please try again."),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Close the dialog
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                        ),
                                        child: Text("OK",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        } else {
                          // Show an error message or handle invalid PIN
                          print("Invalid PIN. Please try again.");
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Invalid PIN",style: TextStyle(color: Colors.red),),
                                content: Text("Invalid PIN. Please try again."),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    child: Text("OK", style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 3.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Enter your PIN',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPinTextField(int index) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        obscureText: true,
        controller: _pinControllers[index],
        autofocus: index == 0,  // Autofocus on the first field
        onChanged: (value) {
          if (value.length == 1) {
            // Move focus to the next TextFormField
            if (index < 3) {
              FocusScope.of(context).nextFocus();
            }
          }
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }



}
