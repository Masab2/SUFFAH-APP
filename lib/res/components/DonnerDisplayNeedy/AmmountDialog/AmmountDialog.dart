import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AmmountDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback ontap;
  const AmmountDialog(
      {super.key, required this.controller, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(
        context,
        controller,
        ontap,
      ),
    );
  }

  Widget contentBox(BuildContext context, TextEditingController controller,
      VoidCallback ontap) {
    return Container(
      padding: EdgeInsets.all(context.mh * 0.02),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(
              image: AssetImage(ImageAsset.applogo),
              height: context.mw * 0.5,
              width: context.mw * 0.5,
            ),
            0.03.ph,
            Text(
              'Donnation Ammount',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.mh * 0.022,
                fontWeight: FontWeight.bold,
              ),
            ),
            0.02.ph,
            Container(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
              ),
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Donnation Ammount',
                  border: InputBorder.none,
                  icon: Icon(
                    CupertinoIcons.money_dollar_circle,
                  ),
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            0.02.ph,
            ElevatedButton(
              onPressed: ontap,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.mehroonColor),
              ),
              child:
                  const Text('Donate', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
