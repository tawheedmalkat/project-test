import 'package:flutter/material.dart';

import '../../constance/imgaeasset.dart';

class CustomLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;

  const CustomLoginButton(
      {super.key,
      required this.onPressed,
      required this.isLoading,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01, vertical: 10),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ) // Show loading indicator
          : ElevatedButton.icon(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff03A8EA),
                minimumSize: Size(
                    double.infinity, MediaQuery.of(context).size.height * 0.07),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
              icon: Image.asset(
                MyImages.img_2,
                width: 20,
                height: 20,
              ),
              label: Text(label, style: TextStyle(color: Colors.white)),
            ),
    );
  }
}
