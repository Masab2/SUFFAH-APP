import 'package:flutter/material.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class JazzCashPaymentReceiptDialog extends StatelessWidget {
  final String amount;
  final String recipientName;
  final String transactionId;
  final String date;

  const JazzCashPaymentReceiptDialog({super.key, 
    required this.amount,
    required this.recipientName,
    required this.transactionId, required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.mh * 0.02),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: context.mh * 0.08,
          ),
          0.02.ph,
          Text(
            'Payment Successful',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.mh * 0.022,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            date,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.mh * 0.017,
              fontWeight: FontWeight.w600,
              color: AppColor.geryColor,
            ),
          ),
          0.02.ph,
          ListTile(
            title: const Text(
              'Amount:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(amount),
          ),
          ListTile(
            title: const Text(
              'Recipient No :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(recipientName),
          ),
          ListTile(
            title: const Text(
              'Transaction ID:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(transactionId),
          ),
          0.02.ph,
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Text('Close', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// Usage:
// showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return JazzCashPaymentReceiptDialog(
//       amount: '100.00 USD',
//       recipientName: 'John Doe',
//       transactionId: '123456789',
//     );
//   },
// );
