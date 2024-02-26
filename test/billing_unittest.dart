import 'package:buyer/model/billing_model.dart';
import 'package:buyer/view/Settings%20Screens/billing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mockito/mockito.dart';

import 'package:buyer/viewmodel/billing_view_model.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  group('BillingViewModel Tests', () {
    late BillingViewModel viewModel;
    late MockGetStorage mockGetStorage;

    setUp(() {
      mockGetStorage = MockGetStorage();
      viewModel = BillingViewModel();
      GetStorage.init();
      Get.put<BillingViewModel>(viewModel);
    });

    test('addBilling should add a new billing address', () {
      viewModel.name = 'Kripesh Poudel';
      viewModel.city = 'Bhaktapur';
      viewModel.address = '1';
      viewModel.phone = '1234567890';

      viewModel.addBilling();

      expect(viewModel.billingList.length, 1);
    });

    test('removeBilling should remove a billing address', () {
      final billingModel = BillingModel(
        name: 'Kripesh Poudel',
        city: 'Bhaktapur',
        address: '1',
        phone: '1234567890',
      );
      viewModel.billingList.add(billingModel);

      viewModel.removeBilling(0);

      expect(viewModel.billingList.length, 0);
    });
  });

  group('BillingScreen Tests', () {
    testWidgets('Adding new billing address', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BillingScreen()));

      await tester.tap(find.byType(InkWell));

      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('name_field')), 'Kripesh Poudel');
      await tester.enterText(find.byKey(Key('city_field')), 'Bhaktapur');
      await tester.enterText(find.byKey(Key('address_field')), '1');
      await tester.enterText(find.byKey(Key('phone_field')), '1234567890');

      await tester.tap(find.text('Save Address'));

      await tester.pumpAndSettle();

      expect(find.text('Kripesh Poudel'), findsOneWidget);
      expect(find.text('Bhaktapur'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('1234567890'), findsOneWidget);
    });
  });
}
