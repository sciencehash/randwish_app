import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/widgets/dialog_scaffold.dart';

class PremiumClarificationMsgDialogContent extends StatelessWidget {
  const PremiumClarificationMsgDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      title: 'Important!'.tr,
      maxWidth: 570,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            r'''Synchronization between devices will be activated for free during the beta stage of Uolia Learning's development, it continues with 3 free months for Early adopters like you, and will finally be priced at US $1.99 per month paying annually via PayPal.'''
                .tr,
            style: TextStyle(height: 1.4),
          ),
          SizedBox(height: 20),
          Text(
            'This money is used to cover the costs of cloud resources used for synchronization and to support the development team. You can cancel whenever you want.'
                .tr,
            style: TextStyle(height: 1.4),
          ),
          SizedBox(height: 20),
          Text(
            'We will notify you when the beta stage concludes.'.tr,
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
      buttons: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            child: Text('CANCEL'.tr),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 26,
              ),
            ),
            onPressed: () {
              Get.offNamed('/');
            },
          ),
          SizedBox(width: 15),
          ElevatedButton(
            child: Text('CONTINUE'.tr),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 26,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
