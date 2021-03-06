import 'package:flutter/material.dart';
import '../get/FirebaseController.dart';
import 'package:get/get.dart';

class Dashboard extends GetWidget<FirebaseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                //logout
                controller.signout();
              },
              child: Text("Sign Out ${controller.user}"),
            ),
            RaisedButton(
              onPressed: () {
                //logout
              },
              child: Text("Sign out Google Sign in"),
            ),
          ],
        ),
      ),
    );
  }
}
