
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/billing_model.dart';

class BillingViewModel extends GetxController {
  var billingList = <BillingModel>[].obs;

  String? name;

  String? address;

  String? city;

  String? phone;

  void addBilling() {
    var billing = BillingModel(
      name: name,
      city: city,
      phone: phone,
      address: address,
    );
    billingList.add(billing);
    GetStorage().write('billingList', billingList.toList());
    
    Get.back();
    update();
  }

  void removeBilling(int index) {
    billingList.removeAt(index);
    GetStorage().write('billingList', billingList.toList());
    update();
  }

  @override
  void onInit() {
    super.onInit();
    var storedList = GetStorage().read<List>('billingList');

    if (storedList != null) {
      billingList.assignAll(storedList.map((e) => BillingModel(
            name: e['name'],
            city: e['city'],
            address: e['address'],
            phone: e['phone'],
          )));
    }
  }
}
