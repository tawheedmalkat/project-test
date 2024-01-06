//import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';
// import 'interface.dart';
//
// class PasswordController extends GetxController {
//   TextEditingController textEditingController = TextEditingController();
//   TextEditingController pinController = TextEditingController();
//   TextEditingController verifyPinController = TextEditingController();
//
//   bool hasError = false;
//   int wrongAttempts = 0;
//   bool isPinSet = false;
//   late SharedPreferences prefs;
//
//   bool isSettingPin = false;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initSharedPreferences();
//   }
//
//   _initSharedPreferences() async {
//     prefs = await SharedPreferences.getInstance();
//     isPinSet = prefs.containsKey('pin');
//   }
//
//   void handlePinCodeEntered(String enteredPin) async {
//     String? savedPin = prefs.getString('pin');
//
//     if (isSettingPin) {
//       // If setting PIN, check if entered PIN matches the verification PIN
//       if (enteredPin == verifyPinController.text) {
//         await prefs.setString('pin', enteredPin);
//         isPinSet = true;
//         isSettingPin = false;
//         Get.back();
//         _showSuccessDialog();
//       } else {
//         Get.snackbar(
//           'Error',
//           'PINs do not match. Please try again.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } else {
//       // If verifying PIN, check if entered PIN matches the saved PIN
//       if (enteredPin == savedPin) {
//         _showSuccessDialog();
//       } else {
//         hasError = true;
//         wrongAttempts++;
//         if (wrongAttempts == 3) {
//           _showErrorDialog();
//         }
//         update();
//       }
//     }
//   }
//
//   void _showSuccessDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: Text("Success"),
//         content: Text("You've entered the correct PIN."),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.to(() => Interface());
//             },
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showErrorDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: Text("Error"),
//         content: Text("You've entered the wrong PIN 3 times. Exiting the app."),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//               Get.reset();
//             },
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void setPin() {
//     // Check if PIN is already set
//     if (isPinSet) {
//       // Move to verification step
//       verifyPin();
//     } else {
//       // Start setting PIN for the first time
//       isSettingPin = true;
//       pinController.text = '';
//       verifyPinController.text = '';
//
//       Get.snackbar(
//         'Set PIN',
//         'Please set your PIN',
//         snackPosition: SnackPosition.BOTTOM,
//         duration: Duration(seconds: 3),
//       );
//     }
//   }
//
//   void verifyPin() {
//     // Move to verification step
//     isSettingPin = false;
//     pinController.text = '';
//
//     Get.snackbar(
//       'Enter PIN',
//       'Please enter your PIN',
//       snackPosition: SnackPosition.BOTTOM,
//       duration: Duration(seconds: 3),
//     );
//   }
// }
//
// class PasswordScreen extends StatelessWidget {
//   final PasswordController controller = Get.put(PasswordController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//
//               ElevatedButton(
//                 onPressed: () {
//                   controller.setPin();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.lightBlueAccent, // background color
//                   onPrimary: Colors.white, // text color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   elevation: 3.0,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Text(
//                     'Set PIN',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ),
//               ),
//
//               ElevatedButton(
//                 onPressed: () {
//                   controller.verifyPin();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.lightBlueAccent, // background color
//                   onPrimary: Colors.white, // text color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   elevation: 3.0,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Text(
//                     'Verify PIN',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//               Text(
//                 "Set PIN",
//                 style: TextStyle(
//                     color: Colors.lightBlueAccent,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20),
//               ),
//               Text("Hello We Will Check IF YOU Are Or Not"),
//               SizedBox(height: 20),
//               PinCodeTextField(
//                 appContext: context,
//                 length: 4,
//                 obscureText: true,
//                 animationType: AnimationType.fade,
//                 pinTheme: PinTheme(
//                   inactiveColor: Colors.black.withBlue(50),
//                   shape: PinCodeFieldShape.underline,
//                   borderRadius: BorderRadius.circular(5),
//                   fieldHeight: 50,
//                   fieldWidth: 60,
//                   activeFillColor: Colors.white,
//                 ),
//                 animationDuration: Duration(milliseconds: 300),
//                 errorAnimationController:
//                 StreamController<ErrorAnimationType>(),
//                 controller: controller.textEditingController,
//                 onCompleted: (v) {
//                   controller.handlePinCodeEntered(v);
//                 },
//                 onChanged: (value) {
//                   controller.hasError = false;
//                 },
//               ),
//               SizedBox(height: 40),
//
//               SizedBox(height: 16),
//
//               if (controller.hasError)
//                 Text(
//                   "PIN code is incorrect. Attempts left: ${3 - controller.wrongAttempts}",
//                   style: TextStyle(color: Colors.red),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'enterPIN.dart';

class ConfirmPIN extends StatefulWidget {
  @override
  _ConfirmPINState createState() => _ConfirmPINState();
}

class _ConfirmPINState extends State<ConfirmPIN> {
  String enteredPin = Get.arguments ?? "";
  List<TextEditingController> _pinControllers =
  List.generate(4, (index) => TextEditingController());

  String savedPin = "";

  @override
  void initState() {
    super.initState();
    getSavedPin();
  }


  Future<void> getSavedPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedPin = prefs.getString('pin') ?? "";

  }

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
                    "Confirm your PIN",
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
                  "To maintain the privacy of your information\nConfirm your PIN ****",
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
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Confirm PIN and save to shared preferences
                        String confirmedPin = _pinControllers
                            .map((controller) => controller.text)
                            .join();

                        if (confirmedPin.isNotEmpty) {
                          // Check if entered PIN matches the previously passed PIN
                          if (confirmedPin == enteredPin) {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setString('pin', confirmedPin);
                            print("PIN saved to SharedPreferences: $confirmedPin");

                            // Navigate to EnterPIN and clear the previous routes
                            Get.offAll(() => EnterPIN());
                          } else {
                            // Incorrect PIN, show error message
                            print("Incorrect PIN. Please try again.");
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
                        } else {
                          // Show an error message or handle invalid PIN
                          print("Please confirm your PIN first.");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 3.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Confirm PIN',
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
