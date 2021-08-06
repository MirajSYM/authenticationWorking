import 'package:auth/get/FirebaseController.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'WelcomePage.dart';
import 'InstanceBinding.dart';
import './isSignedIn.dart';
import 'package:get/get.dart';
import './Screen/Dashboard.dart';
import './Screen/LoginPage.dart';
import './Screen/RegistrationPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// class MyProviderApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginPage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InstanceBinding(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/reg': (context) => RegistrationPage(),
        '/dashboard': (context) => Dashboard(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
