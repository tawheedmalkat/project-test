import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart'; // Import the Get package
import 'interface.dart';


class PasswordController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  bool hasError = false;
  int wrongAttempts = 0;
  bool isPinSet = false;
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    _initSharedPreferences();
  }

  _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    isPinSet = prefs.containsKey('pin'); // Check if PIN is set
  }

  void handlePinCodeEntered(String enteredPin) async {
    String? savedPin = prefs.getString('pin');

    if (!isPinSet) {
      await prefs.setString('pin', enteredPin);
      isPinSet = true;
    } else if (enteredPin == savedPin) {
      _showSuccessDialog();
    } else {
      hasError = true;
      wrongAttempts++;
      if (wrongAttempts == 3) {
        _showErrorDialog();
      }
      update(); // Notify listeners about the changes
    }
  }

  void _showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Success"),
        content: Text("You've entered the correct PIN."),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => Interface());
            },
            child: Text("OK"),
          ),
          TextButton(onPressed: (){
            resetPIN(); // استدعاء وظيفة إعادة تعيين الـ PIN
            Get.back();
          }, child: Text("rest PIN")),
        ],
      ),
    );
  }
  void resetPIN() async {
    await prefs.remove('pin'); // قم بحذف الـ PIN المحفوظ
    isPinSet = false; // قم بتحديث الحالة للإشارة إلى أن الـ PIN غير معين الآن
    update(); // قم بتحديث واجهة المستخدم لإظهار التغييرات
  }

  void _showErrorDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Error"),
        content: Text("You've entered the wrong PIN 3 times. Exiting the app."),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.reset();// Close the dialog
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}

class PasswordScreen extends StatelessWidget {
  final PasswordController controller = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              Text(
                "Enter Your PIN",
                style: TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text("Hello We Will Check IF YOU Are Or Not"),
              SizedBox(height: 20,),
              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: true,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                 
                  inactiveColor: Colors.black.withBlue(50),
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 60,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                errorAnimationController: StreamController<ErrorAnimationType>(),
                controller: controller.textEditingController,
                onCompleted: (v) {
                  controller.handlePinCodeEntered(v);
                },
                onChanged: (value) {
                  controller.hasError = false;
                },
              ),
              SizedBox(height: 16),
              if (controller.hasError)
                Text(
                  "PIN code is incorrect. Attempts left: ${3 - controller.wrongAttempts}",
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 50,),
              Image.asset( "assets/images/pass.png"),
            ],
          ),
        ),
      ),
    );
  }
}
