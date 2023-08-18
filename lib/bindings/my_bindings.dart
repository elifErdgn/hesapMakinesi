import 'package:get/get.dart';
import '../controller/calculate_controller.dart';

class MyBindings implements Bindings { /// binding- bağlam
  @override
  void dependencies() {
    Get.lazyPut(() => CalculateController());
  }
}
