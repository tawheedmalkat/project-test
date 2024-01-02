import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoportapp/UI/screens/login.dart';
import 'package:invoportapp/UI/screens/pass-code.dart';

import '../../main.dart';

class Start extends StatelessWidget {
  final String? storedToken = sharedPref?.getString('token');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          // Check if the user has logged in before
          bool hasLoggedIn = storedToken == null;


          if (hasLoggedIn) {
            Get.offAll(() => Start());
            Future.delayed(Duration(milliseconds:100 ), () {
              Get.to(LogIn());
            });

          } else {

            Get.offAll(() => Start());
            Future.delayed(Duration.millisecondsPerSecond.milliseconds, () {
              Get.to(PasswordScreen());
            });
          }
        },
        child: Text("Go to Login or Home"),
      ),
    );
  }
}
