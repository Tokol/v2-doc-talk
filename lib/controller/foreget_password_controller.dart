import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ForgetPasswordController extends GetxController {
  final userId = "".obs;

  void updateUserID(String id) {
    userId.update((newValue) {
      userId.value = id;
    });
  }

}
