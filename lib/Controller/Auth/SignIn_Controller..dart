//import 'dart:convert';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../Model/UserInfoModel.dart';
// import '../../UI/screens/Home.dart';
// import '../../UI/screens/Interface.dart';
// import '../../UI/screens/pass-code.dart';
// import '../../constance/api.dart';
// import '../../main.dart';
//
// abstract class SignInController extends GetxController {
//   signIn(BuildContext context);
// }
//
// class SignInControllerImp extends SignInController {
//   late TextEditingController emailController;
//   late TextEditingController passwordController;
//   late TextEditingController accountController;
//   GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
//   late BuildContext context;
//   RxBool isLoading = false.obs;
//   RxBool obscureText = true.obs;
//
//   void updateObscure() {
//     obscureText.value = !obscureText.value;
//     update();
//   }
//
//   bool validateFields() {
//     return accountController.text.isNotEmpty &&
//         emailController.text.isNotEmpty &&
//         passwordController.text.isNotEmpty;
//   }
//
//   @override
//   Future<void> signIn(BuildContext context) async {
//     if (scaffoldKey.currentState!.validate()) {
//       isLoading.value = true;
//       update();
//
//       await Future.delayed(Duration(seconds: 5));
//
//       isLoading.value = false;
//       update();
//
//       var client = http.Client();
//       var url = Uri.parse(ApiLink.Login);
//
//       try {
//         var response = await client.post(
//           url,
//           body: {
//             'password': passwordController.text,
//             'email': emailController.text,
//             'account': accountController.text,
//           },
//         );
//
//         var responseData = json.decode(response.body);
//
//         if (response.statusCode == 200) {
//           if (responseData['message'] == 'login successfully') {
//             UserInfoModel user = UserInfoModel.fromResponse(responseData);
//             isLoading.value = false;
//             update();
//
//             await AwesomeDialog(
//               context: context,
//               dialogType: DialogType.infoReverse,
//               animType: AnimType.bottomSlide,
//               body: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Do you want to save your \n information ?",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: "Rubik",
//                         fontSize: MediaQuery.of(context).size.width * 0.04,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () async {
//                             final String token = responseData['token'];
//                             final DateTime now = DateTime.now();
//                             final int expirationDays = 30;
//                             final DateTime expirationDate = now.add(Duration(days: expirationDays));
//                             sharedPref?.setString('token', token);
//                             sharedPref?.setInt('tokenTimestamp', now.millisecondsSinceEpoch);
//                             Get.to(PasswordScreen());
//
//                           },
//
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.blue,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           child: Text(
//                             'OK',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         SizedBox(width: 20),
//                         TextButton(
//                           onPressed: () async {
//                             Get.to(Home());
//                           },
//                           style: TextButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           child: Text(
//                             'Cancel',
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ).show();
//           } else {
//             // Wait for 10 seconds if the response is not successful.
//             // await Future.delayed(Duration(seconds: 10));
//
//             isLoading.value = false;
//             update();
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Invalid data'),
//                 duration: const Duration(seconds: 2),
//               ),
//             );
//           }
//         } else {
//           // Wait for 10 seconds if there is no response
//           // await Future.delayed(Duration(seconds: 10));
//
//           isLoading.value = false;
//           update();
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Failed to log in. Please try again.'),
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         }
//       } finally {
//         client.close();
//       }
//     }
//   }
//
//
//   @override
//   void onInit() {
//     emailController = TextEditingController();
//     passwordController = TextEditingController();
//     accountController = TextEditingController();
//     super.onInit();
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     accountController.dispose();
//     super.dispose();
//   }
// }
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:invoportapp/UI/screens/enterPIN.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/UserInfoModel.dart';
import '../../UI/screens/Home.dart';
import '../../UI/screens/Interface.dart';
import '../../UI/screens/pass-code.dart';
import '../../constance/api.dart';
import '../../main.dart';

abstract class SignInController extends GetxController {
  signIn(BuildContext context);
}

class SignInControllerImp extends SignInController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController accountController;
  GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
  late BuildContext context;
  RxBool isLoading = false.obs;
  RxBool obscureText = true.obs;

  void updateObscure() {
    obscureText.value = !obscureText.value;
    update();
  }

  bool validateFields() {
    return accountController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  Future<void> signIn(BuildContext context) async {
    if (scaffoldKey.currentState!.validate()) {
      isLoading.value = true;
      update();

     // await Future.delayed(Duration(seconds: 5));

      // isLoading.value = false;
      // update();

      var client = http.Client();
      var url = Uri.parse(ApiLink.Login);


        // Add your code to display the password reset message here


        var response = await client.post(
          url,
          body: {
            'password': passwordController.text,
            'email': emailController.text,
            'account': accountController.text,
          },
        );

        var responseData = json.decode(response.body);
        print(responseData);

        if (response.statusCode == 200) {
          if (responseData['massage'] == 'Your password is expired, we have sent your an email to reset your password!') {
            print('Your password is expired, we have sent your an email to reset your password!');
            isLoading.value = false;
            update();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Access Setup"),
                  content: Text("Your password is expired,We sent you an email to finalize your mobile device registeration"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Text("OK",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                );
              },
            );


          }
         else if (responseData['message'] == 'login successfully') {
            print('login successfully');

            UserInfoModel user = UserInfoModel.fromResponse(responseData);
            isLoading.value = false;
            update();

            await AwesomeDialog(
              context: context,
              dialogType: DialogType.infoReverse,
              animType: AnimType.bottomSlide,
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Text(
                      "Do you want to save your \n information ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Rubik",
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final String token = responseData['user']['token'];
                            final DateTime now = DateTime.now();
                            final int expirationDays = 30;
                            final DateTime expirationDate = now.add(Duration(days: expirationDays));
                            sharedPref?.setString('token', token);
                            sharedPref?.setInt('tokenTimestamp', now.millisecondsSinceEpoch);
                            print(sharedPref?.getString('token'));
                            Get.to(PasswordScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () async {

                             final String token = responseData['user']['token'];
                             await saveTokenAndNavigate(token, 6);
                             SharedPreferences.getInstance().then((prefs) {

                               prefs.remove('token');
                             });

                             Get.offAll( Interface());

                             Get.back();// Save token for 6 hours

                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).show();
          }else if (responseData['massage'] == 'Invalid credentials!') {
            print('Invalid credentials!');
            isLoading.value = false;
            update();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Invalid credentials!"),
                      content: Text("Please enter correct email and password"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: Text("OK",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    );
                  },
                );

                }else if (responseData['massage'] == 'Invalid account!') {
            print('Invalid account!');
            isLoading.value = false;
            update();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Invalid account!"),
                  content: Text("Please enter correct account"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Text("OK",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                );
              },
            );

          }
         else {

            isLoading.value = false;
            update();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Access setup"),
                  content: Text("We sent you an email to finalize your mobile device registeration"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Text("OK",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                );
              },
            );

          }
        } else {

          isLoading.value = false;
          update();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Login Failed"),
                content: Text("Failed to log in. Please try again."),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Text("OK",style: TextStyle(color: Colors.white),),
                  ),
                ],
              );
            },
          );
        }

    }
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    accountController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    accountController.dispose();
    super.dispose();
  }
  Future<void> saveTokenAndNavigate(String token, int expirationHours) async {
    final DateTime now = DateTime.now();
    final DateTime expirationTime = now.add(Duration(hours: expirationHours));

    sharedPref?.setString('token', token);
    sharedPref?.setInt('tokenExpiration', expirationTime.millisecondsSinceEpoch);

    Get.to(PasswordScreen());
  }
  bool isTokenValid() {
    final int? expirationTimestamp = sharedPref?.getInt('tokenExpiration');
    if (expirationTimestamp != null) {
      final DateTime expirationTime = DateTime.fromMillisecondsSinceEpoch(expirationTimestamp);
      return DateTime.now().isBefore(expirationTime);
    }
    return false;
  }
}

