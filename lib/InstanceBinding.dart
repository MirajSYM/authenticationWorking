import 'package:get/get.dart';
import 'get/FirebaseController.dart';

class InstanceBinding extends Bindings {
  @override
  void dependencies() {
    //TODO: implement dependencies
    Get.lazyPut<FirebaseController>(() => FirebaseController());
  }
}
