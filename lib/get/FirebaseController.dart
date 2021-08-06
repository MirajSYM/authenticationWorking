import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../Screen/Dashboard.dart';
import '../Screen/LoginPage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User> _firebaseUser = Rx<User>();

  String get user => _firebaseUser.value?.email;

  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());

    print(" Auth Change :   ${_auth.currentUser}");
  }

  // function to createuser, login and sign out user

  void createUser(String firstname, String lastname, String email,
      String password, String uid) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("Users");

    Map<String, String> userdata = {
      "First Name": firstname,
      "Last Name": lastname,
      "Email": email,
      "Token": uid
    };
    // await FirebaseController.updateFirebaseToken();

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      reference.add(userdata).then((value) => Get.offAll(LoginPage()));
    }).catchError(
      (onError) =>
          Get.snackbar("Error while creating account ", onError.message),
    );
  }

  void login(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Get.offAll(Dashboard()))
        .catchError(
            (onError) => Get.snackbar("Error while sign in ", onError.message));
    // await FirebaseController.updateFirebaseToken();
  }

  void signout() async {
    await _auth.signOut().then((value) => Get.offAll(LoginPage()));
  }

  void sendpasswordresetemail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.offAll(LoginPage());
      Get.snackbar("Password Reset email link is sent", "Successful!");
    }).catchError((onError) =>
        Get.snackbar("Error while trying to reset", onError.message));
  }

  void deleteuseraccount(String email, String pass) async {
    User user = _auth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);

    await user.reauthenticateWithCredential(credential).then((value) {
      value.user.delete().then((res) {
        Get.offAll(LoginPage());
        Get.snackbar("User Account Deleted ", "Success");
      });
    }).catchError(
        (onError) => Get.snackbar("Credential Failed, Try Again!", "Failed"));
  }

  static updateFirebaseToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    String token = await firebaseMessaging.getToken();
    print("updateFirebaseToken $token");
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .update({'Token': token});
  }
}
