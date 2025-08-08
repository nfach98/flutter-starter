import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:starter/app/modules/list/controllers/list_controller.dart';

class ListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListController>(() => ListController());
  }
}
