import 'package:buyer/utils/services/theme_service.dart';
import 'package:buyer/viewmodel/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../widgets/buttons.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.darkGrey,
      width: 1.5,
    ),
  );
  OutlineInputBorder? errorBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.5,
    ),
  );
  OutlineInputBorder? focusBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.orange,
      width: 1.5,
    ),
  );

  OutlineInputBorder? focusErrorBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.5,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Ionicons.chevron_back,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.orange),
        centerTitle: true,
        title: const Text(
          'Add Crad',
          style: TextStyle(fontSize: 22, color: AppColors.orange),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              bankName: 'Bank Name',
              frontCardBorder: Border.all(color: Colors.grey),
              backCardBorder: Border.all(color: Colors.grey),
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              cardBgColor: ThemeService().isSavedDarkMode()
                  ? const Color.fromARGB(255, 49, 48, 49)
                  : AppColors.orange,
              isSwipeGestureEnabled: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              customCardTypeIcons: <CustomCardTypeIcon>[
                CustomCardTypeIcon(
                  cardType: CardType.mastercard,
                  cardImage: Image.asset(
                    'assets/images/mastercard.png',
                    height: 48,
                    width: 48,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    SizedBox(
                      height: 3.h,
                    ),
                    GetBuilder<PaymentViewModel>(
                      init: PaymentViewModel(),
                      builder: (controller) => Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: filledButton(
                          height: 6.h,
                          width: 100.w,
                          buttonText: 'Add Card',
                          textSize: 13.sp,
                          buttonColor: AppColors.orange,
                          buttonTextColor: Colors.white,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              controller.toggelCradAdded();
                              Get.back();
                              Get.snackbar('Process Successful',
                                  'Card added successfully.',
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              Get.snackbar(
                                  'Process Failed', 'Failed to add card.',
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
