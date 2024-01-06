import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:invoportapp/Constance/mycolor.dart';

import 'login.dart';


class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2,vertical: MediaQuery.of(context).size.height * 0.15),
                  child: Image.asset(
                    "assets/images/startlog.png",
                    height: MediaQuery.of(context).size.width * 0.7,
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2,
                    vertical: MediaQuery.of(context).size.height * 0.39,
                  ),

                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                    child: Image.asset(
                      "assets/images/Logo with no background.png",
                      width: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.12,
                    vertical: MediaQuery.of(context).size.height * 0.57,
                  ),

                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/aroww.png",
                        height: MediaQuery.of(context).size.width * 0.05,
                        width: MediaQuery.of(context).size.width * 0.05,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Investor Services as Never Before!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Rubik",
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
    Padding(
    padding: EdgeInsets.symmetric(
    horizontal: MediaQuery.of(context).size.width * 0.12,
    vertical: MediaQuery.of(context).size.height * 0.6,
    ),

    child:
                Text(

    "Invoport  enables investment fund managers and administrators perform digitally the funds administrative tasks.",
                  style: TextStyle(
                    color: MyColor.greydark,


                    fontSize: MediaQuery.of(context).size.width * 0.03,
                  ),
                  textAlign: TextAlign.center,
                ),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.9),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.75,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(LogIn());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff03A8EA),
                      minimumSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

              ],
            ),
        
        
        
        
          ],
        ),
      ),
    );
  }
}

Center linearProgress(BuildContext context) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
