import 'package:buyer/utils/database/local_database_helper.dart';
import 'package:buyer/viewmodel/account_view_model.dart';
import 'package:buyer/viewmodel/cart_view_model.dart';
import 'package:buyer/viewmodel/control_view_model.dart';
import 'package:get/get.dart';

import '../../viewmodel/auth_view_model.dart';
import '../../viewmodel/home_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel(),);
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => LocaleDatabaseHelper());
    Get.lazyPut(() => AccountViewModel());
  }
}
